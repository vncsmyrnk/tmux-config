os := `cat /etc/os-release | grep "^NAME=" | cut -d "=" -f2 | tr -d '"'`

utils_path := "${UTILS_SCRIPTS_DIR:-$HOME/utils}"

default:
  just --list

install-deps:
  #!/bin/bash
  if [ "{{os}}" = "Debian GNU/Linux" ] || [ "{{os}}" = "Ubuntu" ]; then
    sudo apt-get install tmux stow
  elif [ "{{os}}" = "Arch Linux" ]; then
    sudo pacman -S tmux stow
  fi
  [ ! -d ~/.tmux/plugins/tpm ] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

install: install-deps config

config:
  stow -t {{home_dir()}} . --ignore=utils
  stow -t {{utils_path}} utils
  ~/.tmux/plugins/tpm/scripts/install_plugins.sh

unset-config:
  stow -D -t {{home_dir()}} . --ignore=utils
  stow -D -t {{utils_path}} utils

source-config:
  tmux source ~/.tmux.conf
