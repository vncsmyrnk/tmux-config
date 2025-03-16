os := `cat /etc/os-release | grep "^NAME=" | cut -d "=" -f2 | tr -d '"'`

scripts_path := "${SU_SCRIPTS_PATH:-$HOME/.config/util/scripts}/tmux"

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
  mkdir -p {{scripts_path}}
  stow -t {{home_dir()}} . --ignore=scripts
  stow -t {{scripts_path}} scripts
  ~/.tmux/plugins/tpm/scripts/install_plugins.sh

unset-config:
  stow -D -t {{home_dir()}} . --ignore=scripts
  stow -D -t {{scripts_path}} scripts

source-config:
  tmux source ~/.tmux.conf
