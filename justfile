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
  stow -t {{home_dir()}} . --ignore=scripts --ignore='^config'
  util config add scripts -t tmux --force
  util config add config -p setup -t tmux --force
  ~/.tmux/plugins/tpm/scripts/install_plugins.sh

unset-config:
  stow -D -t {{home_dir()}} . --ignore=scripts --ignore='^config'
  util config remove scripts/tmux --force
  util config remove setup/tmux --force

source-config:
  tmux source ~/.tmux.conf

force-reload:
  rm -rf /tmp/tmux-*
