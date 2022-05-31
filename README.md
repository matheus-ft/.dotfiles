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

### Vim and Neovim

```sh
sudo apt install vim neovim
```

Configs in [.vimrc](https://github.com/matheus-ft/dotfiles/blob/master/.vimrc) and [init.vim](https://github.com/matheus-ft/dotfiles/blob/master/.config/nvim/init.vim)

### Visual Studio Code

```sh
sudo apt install code
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

- User Themes

- Vitals

- Dash to Panel

### Dconf

- Configs in [.dconf-configs](https://github.com/matheus-ft/.dotfiles/tree/master/.dconf-configs): `dconf dump / > pop-os-{specifier}.ini`

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

- *rice*

  - customize starship

  - customize themes and stuff
  
- get a "less bloated neoftech"

- startup script to load dconf configs automatically

