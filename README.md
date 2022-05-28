# dotfiles

## Neofetch

```sh
sudo apt install neofetch
```

---

## Rofi run prompt

```sh
sudo apt install rofi
```

---

## Stronger `ls`

```sh
sudo apt install cargo
cargo install exa
```

`cargo` is added to the `PATH` in line 5 of [.bashrc](https://github.com/matheus-ft/dotfiles/blob/master/.bashrc)

---

## Starship terminal

```sh
sudo apt install snapd
sudo snap install starship
```

`snap` is added to the `PATH` in line 6 of [.bashrc](https://github.com/matheus-ft/dotfiles/blob/master/.bashrc)

`starship` is set to be the terminal emulator in line 117 of [.bashrc](https://github.com/matheus-ft/dotfiles/blob/master/.bashrc)

configs are in [starship.toml](https://github.com/matheus-ft/dotfiles/blob/master/.config/starship.toml)

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

---

## Dracula Theme

- <https://draculatheme.com/gnome-terminal>

- <https://draculatheme.com/gtk>

- <https://draculatheme.com/visual-studio-code>

- <https://draculatheme.com/firefox>

- <https://draculatheme.com/rofi>

---

## Desktop configs

### Cinnamon

- [Linux Mint Debian Edition 5](https://github.com/matheus-ft/dotfiles/blob/master/.dconf-configs/cinnamon-desktop.ini) `dconf dump / > cinnamon-desktop.ini`

  - [keybindings](https://github.com/matheus-ft/dotfiles/blob/master/.dconf-configs/cinnamon-keybindings.ini) `dconf dump /org/cinnamon/desktop/keybindings/ > cinnamon-keybindings.ini`

  - [terminal-keybindings](https://github.com/matheus-ft/dotfiles/blob/master/.dconf-configs/gnome-terminal-keybindings.ini) `dconf dump /org/gnome/terminal/legacy/keybindings/ > gnome-terminal-keybindings.ini`

- dependency

```sh
sudo apt install dconf-cli
```

- save

```sh
dconf dump path > config-name.ini
```

- load

```sh
dconf load path < config-name.ini
```

