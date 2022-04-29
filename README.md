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

`exa` is added to the `PATH` in line 5 of [.bashrc](https://github.com/matheus-ft/dotfiles/blob/master/.bashrc)

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

## Dracula Theme

- <https://draculatheme.com/gnome-terminal>

- <https://draculatheme.com/gtk>

- <https://draculatheme.com/visual-studio-code>

- <https://draculatheme.com/firefox>

- <https://draculatheme.com/rofi>

---

## Desktops

- [Cinnamon](https://github.com/matheus-ft/dotfiles/blob/master/cinnamon-desktop.ini) - Linux Mint Debian Edition 5

  - [keybindings](https://github.com/matheus-ft/dotfiles/blob/master/cinnamon-keybindings.ini)

---

## Desktop Configs

### save

```sh
dconf dump path > config-name.ini
```

### load

```sh
dconf load path < config-name.ini
```

### dependency

```sh
sudo apt install dconf-cli
```
