# tmux Config

My tmux config.

## Install

This project uses [just](https://github.com/casey/just) and [stow](https://www.gnu.org/software/stow/) for the installation.

```bash
just install
```

Considering `tmux` is already installed, you can just run:

```bash
just config
```

After downloading the config, run `tmux source ~/.tmux.conf` and `PREFIX + I` for installing the plugins.
