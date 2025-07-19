os := `cat /etc/os-release | grep "^NAME=" | cut -d "=" -f2 | tr -d '"'`

scripts_path := "${SU_SCRIPTS_PATH:-$HOME/.config/util/scripts}/tmux"
config_path := "${SU_RC_SOURCE_PATH:-$HOME/.config/setup}/tmux"

default:
  just --list

check-deps:
  #!/bin/bash
  dependencies=(stow tmux)
  missing_dependencies=($(for dep in "${dependencies[@]}"; do command -v "$dep" &> /dev/null || echo "$dep"; done))

  if [ ${#missing_dependencies[@]} -gt 0 ]; then
    echo "Dependencies not found: ${missing_dependencies[*]}"
    echo "Please install them with the appropriate package manager"
    exit 1
  fi

  [ ! -d ~/.tmux/plugins/tpm ] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

install-tpm:
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

install: check-deps install-tpm config

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
