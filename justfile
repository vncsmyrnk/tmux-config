os := `cat /etc/os-release | grep "^NAME=" | cut -d "=" -f2 | tr -d '"'`

default:
  just --list

install-deps:
  #!/bin/bash
  if [ "{{os}}" = "Debian GNU/Linux" ] || [ "{{os}}" = "Ubuntu" ]; then
    sudo apt-get install tmux stow
  elif [ "{{os}}" = "Arch Linux" ]; then
    sudo pacman -S tmux stow
  fi
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

install: install-deps config

config:
  stow -t {{home_dir()}} .
  ~/.tmux/plugins/tpm/scripts/install_plugins.sh

delete-config:
  stow -D -t {{home_dir()}} .

source-config:
  tmux source ~/.tmux.conf
