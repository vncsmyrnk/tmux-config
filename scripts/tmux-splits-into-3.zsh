#!/bin/zsh

# Splits the current window both horizontally
# and vertically

tmux split-window -h &&
  tmux split-window -v
