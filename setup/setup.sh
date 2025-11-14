#!/bin/bash
# Flags
#     --no_import: Do not import from .repos 
#     --host: Install on host (skip fzf and lightsfm)
#     --no_build: Do not build ROS packages
import=true
container=true
build=true

while [[ $# -gt 0 ]]; do
    case "$1" in
    --no_import)
        import=false
        shift
        ;;
    --host)
        container=false
        shift
        ;;      
    --no_build)
        build=false
        shift
        ;;            
    *)
        echo "Unknown option: $arg"
        exit 1
        ;;
    esac
done

set -e
mkdir -p py
mkdir -p src

# ======================
# Clone non-ROS packages
# ======================
# tmux config
if [[ $container == true ]]; then
    if [ ! -f ~/.tmux.conf ]; then
        touch ~/.tmux.conf
        echo "set -g history-limit 10000" >> ~/.tmux.conf
        echo "set -g mouse on" >> ~/.tmux.conf
    fi
    
    # fzf
    if [ ! -d ~/.fzf/ ]; then
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install --key-bindings --completion --update-rc
    fi
    
    
    # For hunavsim
    cd py 
    if [ ! -d lightsfm ] ; then
        git clone https://github.com/robotics-upo/lightsfm
    fi
    cd lightsfm; make; sudo make install; cd ..;
    cd ..
fi

# ============
# ROS packages
# ============
# Import repos
if [[ $import == true ]]; then
    vcs import < setup/ros2.repos src --skip-existing --recursive
fi

if [[ $build == true ]]; then
    # Resolve dependencies
    sudo apt-get update
    rosdep update
    rosdep install -i --from-path src --rosdistro humble -y --skip-keys="scout_description"
    
    # Build workspace
    colcon build --symlink-install --packages-skip zed_isaac_ros_nitros_sub zed_isaac_ros_april_tag
fi

echo "Setup complete. Next, run source ~/.bashrc and follow README."
