os := `cat /etc/os-release | grep "^NAME=" | cut -d "=" -f2`
os_full := if os == "\"Arch Linux\"" { "arch" } else if os == "\"Debian GNU/Linux\"" { "debian" } else { error("Unsuported OS") }

default:
  just --list

install-deps:
  #!/bin/bash
  if [ "{{os_full}}" = "debian" ]; then
    sudo apt-get install tmux stow
  elif [ "{{os_full}}" = "arch" ]; then
    sudo pacman -S tmux stow
  fi
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

install: install-deps config

config:
  stow -t {{home_dir()}} .
  @echo "Press prefix + I (capital i, as in Install) to fetch the plugins"

delete-config:
  stow -D -t {{home_dir()}} .

source-config:
  tmux source ~/.tmux.conf
