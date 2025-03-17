################
# useful utils #
################
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
#################
# hunavsim 
if [ ! -d lightsfm ] ; then
    git clone https://github.com/robotics-upo/lightsfm
fi
cd lightsfm; make; sudo make install; cd ..

# import hunavsim  repos
mkdir -p src
vcs import < ros2.repos src --skip-existing --recursive


# resolve any dependancieskj0
rosdep update
rosdep install -i --from-path src --rosdistro humble -y

# build workspace
colcon build --symlink-install