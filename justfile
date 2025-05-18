os := `cat /etc/os-release | grep "^NAME=" | cut -d "=" -f2 | tr -d '"'`

scripts_path := "${SU_SCRIPTS_PATH:-$HOME/.config/util/scripts}/tmux"
config_path := "${SU_RC_SOURCE_PATH:-$HOME/.config/setup}/tmux"

default:
  just --list

install-deps:
  #!/bin/bash
  if [ "{{os}}" = "Debian GNU/Linux" ] || [ "{{os}}" = "Ubuntu" ]; then
    sudo apt-get install stow
    if command -v brew >/dev/null; then
      brew install tmux # prefers tmux version as it is updated more often
    else
      sudo apt-get install tmux
    fi
  elif [ "{{os}}" = "Arch Linux" ]; then
    sudo pacman -S tmux stow
  fi
  [ ! -d ~/.tmux/plugins/tpm ] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

install-tpm:
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

install: install-deps install-tpm config

config:
  mkdir -p {{scripts_path}} {{config_path}}
  stow -t {{home_dir()}} . --ignore=scripts --ignore='^config'
  stow -t {{scripts_path}} scripts
  stow -t {{config_path}} config
  ~/.tmux/plugins/tpm/scripts/install_plugins.sh

unset-config:
  stow -D -t {{home_dir()}} . --ignore=scripts --ignore='^config'
  stow -D -t {{scripts_path}} scripts
  stow -D -t {{config_path}} config

source-config:
  tmux source ~/.tmux.conf
