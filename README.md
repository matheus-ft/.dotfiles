# Pop!_OS 22.04 with GNOME 42.1

## Gdebi

```sh
sudo apt install gdebi-core
```

---

## Stronger `ls`

```sh
sudo apt install exa
```

---

## Starship terminal

```sh
curl -sS https://starship.rs/install.sh | sh
```

`starship` is set to be the terminal emulator in line 1 of [bash_init](https://github.com/matheus-ft/dotfiles/blob/master/.bashrc.d/init)

Settings are in [starship.toml](https://github.com/matheus-ft/dotfiles/blob/master/.config/starship.toml)

---

## htop

```sh
sudo apt install htop
```

---

## Vim

```sh
sudo apt install vim
```

Configs in [.vimrc](https://github.com/matheus-ft/dotfiles/blob/master/.vimrc)

---

## Neovim

```sh
sudo apt install neovim
```

Configs in [init.vim](https://github.com/matheus-ft/dotfiles/blob/master/.config/nvim/init.vim)

---

## GNOME tweaks

```sh
sudo apt install gnome-tweaks
```

---

## Extension Manager

```sh
flatpak install flathub com.mattjakeman.ExtensionManager
```

---

## Rofi

```sh
sudo apt install rofi
```

Settings in [config.rasi](https://github.com/matheus-ft/dotfiles/blob/master/.config/rofi/config.rasi)

---

## Visual Studio Code

```sh
sudo apt install code
```

---

## Desktop

- Configs in [.dconf-configs](https://github.com/matheus-ft/.dotfiles/tree/master/.dconf-configs): `dconf dump / > pop-os-<specifier>.ini`

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

- add extensions and *rice*

  - customize starship

  - customize themes and stuff
  
- get a "less bloated neoftech"

