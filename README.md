# Pop!_OS 22.04 with GNOME 42.1

```sh
git clone --bare https://github.com/matheus-ft/.dotfiles $HOME/.dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
config checkout
```

If there's conflict, put such files in a separate `.backup` folder, then run

```sh
config checkout
config config --local status.showUntrackedFiles no
```

and finally resolve those conflicts as you like.

---

## Exa

Better `ls` command

```sh
sudo apt install exa
```

---

## Starship

```sh
curl -sS https://starship.rs/install.sh | sh
```

`starship` is set to be the shell prompt os the last line of [bash_finish](https://github.com/matheus-ft/dotfiles/blob/master/.bashrc.d/finish)

Settings are in [starship.toml](https://github.com/matheus-ft/dotfiles/blob/master/.config/starship.toml)

---

## Programming

### Neovim

```sh
sudo apt install neovim
```

Config in [init.vim](https://github.com/matheus-ft/dotfiles/blob/master/.config/nvim/init.vim)

#### Vim-plug

Plugin manager for nvim

```sh
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

### Node.js

```sh
sudo apt instal nodejs
```

### Python

```sh
sudo apt install python3-venv python3-pip
```

### Octave

```sh
sudo apt install octave
```

---

## Desktop

### GNOME tweaks

```sh
sudo apt install gnome-tweaks
```

### Extension Manager

```sh
flatpak install flathub com.mattjakeman.ExtensionManager
```

Extensions added:

- [User Themes](https://extensions.gnome.org/extension/19/user-themes/)

- [Vitals](https://extensions.gnome.org/extension/1460/vitals/)

- [Dash to Panel](https://extensions.gnome.org/extension/1160/dash-to-panel/)

- [Auto Move Windows](https://extensions.gnome.org/extension/16/auto-move-windows/)

### Dconf

- Configs in [.dconf-configs](https://github.com/matheus-ft/.dotfiles/tree/master/.config/.dconf-configs): `dconf dump / > pop-os-{specifier}.ini`

How to:

- save

```sh
dconf dump path > config-name.ini
```

- load

```sh
dconf load path < config-name.ini
```

---

## To do

- startup script to load dconf configs automatically and also change starship.toml, theme.vim and gnome-terminal profile based on the current colorscheme

