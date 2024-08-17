# tmux-config

My tmux config.

## Install

### Install tmux and config

```bash
bash <(curl -s https://raw.githubusercontent.com/vncsmyrnk/zsh-config/main/install.sh)
```

### Just the config

```bash
curl -O ~ https://raw.githubusercontent.com/vncsmyrnk/tmux-config/main/.tmux.conf
```

### Clone

```bash
git clone git@github.com:vncsmyrnk/tmux-config.git $HOME/utils
ln -s $HOME/utils/tmux-config/.tmux.conf $HOME/.tmux.conf
```

After downloading the config, run `tmux source ~/.tmux.conf` and `PREFIX + I` for installing the plugins.
