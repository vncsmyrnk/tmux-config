#!/bin/bash

sudo apt-get install tmux
ln -s $HOME/utils/tmux-config/.tmux.conf $HOME/.tmux.conf
echo -e "\033[1;32mDone.\033[0m"
