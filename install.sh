#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sourcing=false

while [[ "$#" -gt 0 ]]; do
  case $1 in
    --sourcing)
      sourcing=true
      shift
      ;;
    *)
      break
      ;;
  esac
done

before() {
  sudo apt-get install tmux
}

config() {
  ln -s $SCRIPT_DIR/.tmux.conf $HOME/.tmux.conf
}

symbolic_install() {
  before
  config
  echo -e "\033[1;32mDone.\033[0m"
}

install() {
  before
  curl -O $HOME/.tmux.conf https://raw.githubusercontent.com/vncsmyrnk/tmux-config/main/.tmux.conf
  echo -e "\033[1;32mDone.\033[0m"
}

if [[ "$sourcing" = "false" ]]; then
  install
fi
