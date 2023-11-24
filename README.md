<!--toc:start-->

- [Instructions](#instructions)
- [Package managers](#package-managers)
  - [Nala](#nala)
  - [Pacstall](#pacstall)
  - [Topgrade](#topgrade)
  - [Build tools](#build-tools)
- [Terminal](#terminal)
  - [Kitty](#kitty)
  - [Z shell](#z-shell)
    - [Oh My Zsh](#oh-my-zsh)
      - [Powerlevel10k](#powerlevel10k)
      - [Syntax highlighting](#syntax-highlighting)
  - [Starship](#starship)
  - [Exa](#exa)
  - [Bat](#bat)
  - [System monitor](#system-monitor)
  - [Calendar](#calendar)
  - [Clipboard](#clipboard)
- [Fonts](#fonts)
  - [JetBrains Mono Nerd Font](#jetbrains-mono-nerd-font)
- [Connection with Andorid device](#connection-with-andorid-device)
- [Other apps](#other-apps)
  - [Brave](#brave)
  - [Zoom](#zoom)
- [Programming](#programming)
  - [Python](#python)
    - [Jupyter notebooks](#jupyter-notebooks)
    - [Neovim integration](#neovim-integration)
  - [Node.js](#nodejs)
  - [Rust](#rust)
  - [Latex](#latex)
  - [Neovim](#neovim)
    - [Bob](#bob)
    - [PPA](#ppa)
    - [Rip grep](#rip-grep)
    - [Neovide](#neovide)
    - [Default editor](#default-editor)
      - [In a terminal](#in-a-terminal)
      - [In Gnome](#in-gnome)
- [Qtile](#qtile)
  - [Additional software needed](#additional-software-needed)
    - [Rofi](#rofi)
    - [Brightnessctl](#brightnessctl)
    - [Picom](#picom)
    - [Dunst](#dunst)
    - [Nitrogen](#nitrogen)
    - [Lxpolkit](#lxpolkit)
    - [Lxappearance](#lxappearance)
    - [Arandr](#arandr)
    - [Power Menu](#power-menu)
    - [Screen locker/saver](#screen-lockersaver)
    - [Keyboard layout switcher](#keyboard-layout-switcher)
    - [Bluetooth](#bluetooth)
    - [Screenshooter](#screenshooter)
    - [Widgets dependencies](#widgets-dependencies)
      - [Wifi](#wifi)
      - [CPU, RAM and stuff](#cpu-ram-and-stuff)
      - [Thermal sensor](#thermal-sensor)
      - [Cool icons](#cool-icons)
  - [GNOME Desktop](#gnome-desktop) - [GNOME tweaks](#gnome-tweaks) - [Extension Manager](#extension-manager) - [Dconf](#dconf)
  <!--toc:end-->

# Instructions

How to manage:

After a clean install, do

```bash
git clone --bare https://github.com/matheus-ft/.dotfiles $HOME/.dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
config checkout
```

If there's conflict, put such files in a separate `.backup` folder, then run

```bash
config checkout
config config --local status.showUntrackedFiles no
```

and finally resolve those conflicts as you like.

Note that `config` is the alias for this _bare repo_, so `git` won't work.

---

# Package managers

Language specific ones detailed under [programming](https://github.com/matheus-ft/.dotfiles#programming).

## Nala

Better package manager interface for APT

```bash
echo "deb https://deb.volian.org/volian/ scar main" | sudo tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list
wget -qO - https://deb.volian.org/volian/scar.key | sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg > /dev/null
sudo apt update && sudo apt install nala
```

## Pacstall

Debian based distros' AUR

```bash
sudo bash -c "$(curl -fsSL https://git.io/JsADh || wget -q https://git.io/JsADh -O -)"
```

## Topgrade

A freaking cool way to upgrade the shit out of your system - make sure to have [Rust](https://github.com/matheus-ft/.dotfiles#rust) set up before.

```bash
cargo install topgrade
```

## Build tools

Some of the general build tools I had to get

```bash
sudo nala install meson ninja-build
```

---

# Terminal

## Kitty

Better terminal emulator.

```bash
sudo nala install kitty
```

Settings in [kitty.conf](https://github.com/matheus-ft/dotfiles/blob/master/.config/kitty).

## Z shell

```bash
sudo nala install zsh zsh-doc
chsh -s $(which zsh)
```

Last line makes z shell the default login shell.

### Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

#### Powerlevel10k

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

#### Syntax highlighting

```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

## Starship

Prompt that works with any shell.

```bash
curl -sS https://starship.rs/install.sh | sh
```

Ricing in [starship.toml](https://github.com/matheus-ft/dotfiles/blob/master/.config/starship.toml).

For zsh, Powerlevel10k does it better, but this is still set for bash.

## Exa

Better `ls` command.

```bash
cargo install exa
```

## Bat

Better `cat` command.

```bash
sudo nala install bat
```

## System monitor

```bash
sudo nala install bashtop
```

## Calendar

```bash
sudo nala install calcurse
```

## Clipboard

Clipbaord utility

```bash
sudo nala install xclip
```

Clipbaord manager

```bash
sudo add-apt-repository ppa:hluk/copyq
sudo apt update && sudo nala install copyq
```

---

# Fonts

## JetBrains Mono Nerd Font

Manually installed from https://www.nerdfonts.com/font-downloads and extracted the zip to `$HOME/.local/share/fonts/JetBrainsMono/`

---

# Connection with Andorid device

Yes, this is a KDE app, so be ready for a shit ton of dependencies

```bash
sudo nala install kdeconnect nautilus-kdeconnect
```

---

# Other apps

## Brave

To create webapps

```bash
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update && sudo nala install brave-browser
```

---

## Zoom

```bash
flatpak install flathub us.zoom.Zoom
```

---

# Programming

## Python

Python interpreter came pre-installed. But we must add `pip`, `venv`, and `tkinter`.

- `pip` is the python package manager

- `venv` is the tool to manage virtual environments

- `tkinter` is a GUI backend installed to use matplotlib

```bash
sudo nala install python3-pip python3-venv python3-tk
```

### Jupyter notebooks

```bash
pip install jupyterlab
pip install --upgrade jupyterlab-vim
pip install jupytext
```

### Neovim integration

```bash
mkdir -p $HOME/.local/venv && cd $HOME/.local/venv
python3 -m venv nvim
cd nvim
. ./bin/activate
pip install --upgrade pynvim
pip install Pillow cairosvg pnglatex plotly kaleido jupyter-client black docformatter
```

Last line is for Magma and Formatter. TODO find replacement for `ueberzug`

## Node.js

Mostly for other dependencies -- such as `npm`

```bash
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
NODE_MAJOR=20
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt-get update
sudo apt-get install nodejs -y
```

## Rust

Because it's cool... and because of Neovim (Bob and Neovide).

```bash
curl --proto '=https' --tlsv1.2 -sSf "https://sh.rustup.rs" | sh
cargo install cargo-update
```

Make sure to have `gcc` (`build-essential`), `openssl` (including `libssl-dev`), and `pkg-config`

## Latex

Tex Live

```bash
sudo nala install texlive texlive-luatex texlive-lang-english texlive-lang-portuguese texlive-science perl-tk texlive-bibtex-extra biber
```

Latexmk

```bash
sudo nala install latexmk
```

## Neovim

### Bob

Installing and managing neovim versions.

From crates

```bash
cargo install bob-nvim
```

From source

```bash
cargo install --git https://github.com/MordechaiHadad/bob.git
```

Make sure to uninstall manually installed versions beforehand. And then

```bash
bob use <version>
```

### PPA

This way you get the last release - which is way newer than the one from APT

```bash
sudo add-apt-repository ppa:neovim-ppa/stable
sudo nala update
sudo nala install neovim
nvim +PackerSync
```

Settings in [init.lua](https://github.com/matheus-ft/nvim)

Also possible to get bleeding edge versions with `ppa:neovim-ppa/unstable` or nightly appimage builds

### Rip grep

Essential for a good Telescope experience

```bash
sudo nala install ripgrep
```

### Neovide

GUI client. Building from source (first line of dependencies might be redundant, but it's here anyway)

```bash
sudo nala install gcc-multilib g++-multilib cmake libssl-dev pkg-config \
    libfreetype6-dev libasound2-dev libexpat1-dev libxcb-composite0-dev \
    libbz2-dev libsndio-dev freeglut3-dev libxmu-dev libxi-dev libfontconfig1-dev
cd $HOME/Downloads
git clone "https://github.com/neovide/neovide"
cd neovide
cargo build --release
cp ./target/release/neovide $HOME/.local/bin/
```

### Default editor

#### In a terminal

```bash
sudo update-alternatives --install /usr/bin/editor editor $(which nvim) 100
sudo update-alternatives --config editor
```

#### In Gnome

Done with the files in [.local/share/applications](https://github.com/matheus-ft/.dotfiles/tree/master/.local/share/applications)

---

# Qtile

Installation:

```bash
pip3 install xcffib
pip3 install --no-cache-dir cairocffi
pip3 install qtile
```

Then

```bash
cd $HOME/Downloads
git clone https://github.com/elParaguayo/qtile-extras
cd qtile-extras
sudo python3 setup.py install
```

To login, create a `/usr/share/xsessions/qtile.desktop`:

```desktop
[Desktop Entry]
Name=Qtile
Comment=Qtile Session
Exec=qtile start
Type=Application
Keywords=wm;tiling
```

Settings in [config.py](https://github.com/matheus-ft/.dotfiles/tree/master/.config/qtile).

## Additional software needed

### Rofi

Run prompt

```bash
sudo nala install rofi
```

### Brightnessctl

To regulate the monitor backlight

```bash
sudo nala install brightnessctl
```

Possibly needed to do `sudo usermod -aG video ${USER}` and reboot

### Picom

Compositor

```bash
cd $HOME/Downloads
sudo nala install libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl-dev libegl-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev libxcb-dpms0-dev
git clone https://github.com/yshui/picom
cd picom
git submodule update --init --recursive
meson --buildtype=release . build
ninja -C build
cp build/src/picom $HOME/.local/bin/
```

This requires having meson and ninja available (as well as GCC obviously)

### Dunst

Notifications

```bash
cd $HOME/Downloads
sudo nala install libdbus-1-dev libx11-dev libxinerama-dev libxrandr-dev libxss-dev libglib2.0-dev libpango1.0-dev libgtk-3-dev libxdg-basedir-dev libnotify-dev
git clone https://github.com/dunst-project/dunst.git
cd dunst
make
sudo make install
```

### Nitrogen

To set wallpapers

```bash
sudo nala install nitrogen
```

Also, cloned [DT's](https://gitlab.com/dwt1/wallpapers) wallpapers into ~/Pictures/wallpapers/

### Lxpolkit

Policy kit

```bash
sudo nala install lxpolkit
```

### Lxappearance

LXDE GTK+ theme switcher

```bash
sudo nala install lxappearance
```

### Arandr

Simple visual front end for XRandR (to easily align multiple monitors)

```bash
sudo nala install arandr
```

### Power Menu

```bash
cd $HOME/Downloads
git clone https://github.com/jluttine/rofi-power-menu
cd rofi-power-menu
cp rofi-power-menu $HOME/.local/bin
```

### Screen locker/saver

```bash
sudo nala install i3lock scrot
```

And create `$HOME/.local/bin/i3lock-custom` with

```bash
#!/bin/bash
scrot /tmp/screenshot.png
convert /tmp/screenshot.png -blur 0x5 /tmp/screenshotblur.png
i3lock -i /tmp/screenshotblur.png
```

and then `chmod u+x` it

### Keyboard layout switcher

Create `$HOME/.local/bin/toggle_keyboard_layout` with

```bash
#!/usr/bin/bash

case $(setxkbmap -query | grep layout | awk '{ print $2 }') in
            us) setxkbmap br ;;
            br) setxkbmap us ;;
esac
```

### Bluetooth

Bluez was already installed, but let's get a GUI

```bash
sudo nala install blueman
```

### Screenshooter

```bash
sudo nala install flameshot
```

### Widgets dependencies

#### Wifi

```bash
sudo nala install libiw-dev && pip install iwlib
```

`nm-applet` was already installed apparently, but it's possible to manage network connection with `nmcli dev wifi`

#### CPU, RAM and stuff

```bash
pip install psutil
```

#### Thermal sensor

```bash
sudo nala install lm-sensors
```

#### Cool icons

[Nerd fonts cheat sheet](https://www.nerdfonts.com/cheat-sheet)

---

## GNOME Desktop

### GNOME tweaks

```bash
sudo nala install gnome-tweaks
```

### Extension Manager

```bash
flatpak install flathub com.mattjakeman.ExtensionManager
```

Extensions added:

- [User Themes](https://extensions.gnome.org/extension/19/user-themes/)

- [Vitals](https://extensions.gnome.org/extension/1460/vitals/)

- [Dash to Panel](https://extensions.gnome.org/extension/1160/dash-to-panel/)

- [Auto Move Windows](https://extensions.gnome.org/extension/16/auto-move-windows/) - didn't actually use yet

### Dconf

- Settings are in [.dconf-configs](https://github.com/matheus-ft/.dotfiles/tree/master/.config/.dconf-configs) : `pop-os-{specifier}.ini`

How to

- save

```bash
dconf dump <path> > config-name.ini
```

- apply

```bash
dconf load <path> < config-name.ini
```
