# Pop!_OS 22.04 with GNOME 42.1

## Gdebi

```sh
sudo apt install gdebi-core
```

---

## Exa

```sh
sudo apt install exa
```

---

## Starship

```sh
curl -sS https://starship.rs/install.sh | sh
```

`starship` is set to be the shell prompt in line 1 of [bash_init](https://github.com/matheus-ft/dotfiles/blob/master/.bashrc.d/init)

Settings are in [starship.toml](https://github.com/matheus-ft/dotfiles/blob/master/.config/starship.toml)

---

## htop

```sh
sudo apt install htop
```

---

## Programming

### Neovim

```sh
sudo apt install vim neovim
```

Config in [init.vim](https://github.com/matheus-ft/dotfiles/blob/master/.config/nvim/init.vim)

#### Vim-plug

```sh
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

### Python

```sh
sudo apt install python3-venv python3-pip
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

- [gnome-terminal keybindings]((https://github.com/matheus-ft/.dotfiles/tree/master/.config/.dconf-configs/gnome-terminal-keybindings.ini) are updated more often, so always load them after the theme `dconf load /org/gnome/terminal/legacy/keybindings/ < gnome-terminal-keybindings.ini`

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

- customize starship

- startup script to load dconf configs automatically

- script to create projects (auto adding a .vimrc and other special configs)

