#!/bin/bash
# Args
#     --no_import: Do not import from .repos 
import=true

while [[ $# -gt 0 ]]; do
    case "$1" in
    --no_import)
        import=false
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

# ============
# ROS packages
# ============
# Import repos
if $import; then
    vcs import < setup/ros2.repos src --skip-existing --recursive
fi

# Resolve dependencies
sudo apt-get update
rosdep update
rosdep install -i --from-path src --rosdistro humble -y --skip-keys="scout_description"

# Build workspace
colcon build --symlink-install

echo "Setup complete. Next, run source ~/.bashrc and follow README."
