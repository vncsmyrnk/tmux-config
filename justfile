default:
  just --list

install-deps:
  sudo apt-get install tmux

install: install-deps config

config:
  stow -t {{home_dir()}} .
  tmux source ~/.tmux.conf

delete-config:
  stow -D -t {{home_dir()}} .
