# Pop!\_OS 22.04

<!--toc:start-->

- [Pop!\_OS 22.04](#popos-2204)
  - [Package managers](#package-managers)
    - [Nala](#nala)
    - [Pacstall](#pacstall)
    - [Topgrade](#topgrade)
    - [Build tools](#build-tools)
    - [Homebrew](#homebrew)
  - [Terminal](#terminal)
    - [Kitty](#kitty)
    - [Z shell](#z-shell)
      - [Oh My Zsh](#oh-my-zsh)
        - [Powerlevel10k](#powerlevel10k)
        - [Syntax highlighting](#syntax-highlighting)
    - [Starship](#starship)
    - [Exa](#exa)
    - [Bat](#bat)
    - [Bashtop](#bashtop)
    - [Clipboard](#clipboard)
  - [Fonts](#fonts)
    - [Fira Code](#fira-code)
    - [JetBrains Mono Nerd Font](#jetbrains-mono-nerd-font)
    - [Cascadia Code](#cascadia-code)
  - [Connection with Andorid device](#connection-with-andorid-device)
  - [Brave](#brave)
  - [Programming](#programming)
    - [Python](#python)
      - [Jupyter notebooks](#jupyter-notebooks)
      - [Neovim integration](#neovim-integration)
    - [Node 16 and Yarn](#node-16-and-yarn)
    - [Rust](#rust)
    - [Latex](#latex)
    - [Neovim](#neovim)
      - [Bob](#bob)
      - [Rip grep](#rip-grep)
      - [Neovide](#neovide)
      - [Default editor](#default-editor)
        - [In terminal emulator](#in-terminal-emulator)
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

## Package managers

Language specific ones detailed under [programming](https://github.com/matheus-ft/.dotfiles#programming).

### Nala

Better package manager interface for APT

```bash
echo "deb https://deb.volian.org/volian/ scar main" | sudo tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list
wget -qO - https://deb.volian.org/volian/scar.key | sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg > /dev/null
sudo apt update && sudo apt install nala
```

### Pacstall

Debian based distros' AUR

```bash
sudo bash -c "$(curl -fsSL https://git.io/JsADh || wget -q https://git.io/JsADh -O -)"
```

### Topgrade

A freaking cool way to upgrade the shit out of your system - make sure to have [Rust](https://github.com/matheus-ft/.dotfiles#rust) set up before.

```bash
cargo install topgrade
```

### Build tools

Some of the general build tools I had to get

```bash
sudo nala install meson ninja-build
```

### Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

---

## Terminal

### Kitty

Better terminal emulator.

```bash
sudo nala install kitty
```

Settings in [kitty.conf](https://github.com/matheus-ft/dotfiles/blob/master/.config/kitty).

### Z shell

```bash
sudo nala install zsh
chsh -s $(which zsh)
```

Last line makes z shell the default shell.

#### Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

##### Powerlevel10k

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

##### Syntax highlighting

```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### Starship

Prompt that works with any shell.

```bash
curl -sS https://starship.rs/install.sh | sh
```

Ricing in [starship.toml](https://github.com/matheus-ft/dotfiles/blob/master/.config/starship.toml).

For zsh, Powerlevel10k does it better, but this is still set for bash.

### Exa

Better `ls` command.

```bash
sudo nala install exa
```

### Bat

Better `cat` command.

```bash
brew install bat
```

### Bashtop

```bash
sudo nala install bashtop
```

### Clipboard

Clipbaord utility

```bash
sudo nala install xclip
```

Clipbaord manager

```bash
sudo add-apt-repository ppa:hluk/copyq
sudo apt update
sudo nala install copyq
```

---

## Fonts

### Fira Code

Cool font with ligatures (and apparently the only one working properly with my terminal).

```bash
sudo nala install fonts-firacode
```

Also installed a non-offical version of the italics manually from [github](https://github.com/Avi-D-coder/FiraCode-italic).

### JetBrains Mono Nerd Font

Another cool nerd font.

```bash
sudo nala install fonts-jetbrains-mono
```

### Cascadia Code

```bash
sudo nala install fonts-cascadia-code
```

---

## Connection with Andorid device

Yes, this is a KDE app, so be ready for a shit ton of dependencies

```bash
sudo nala install kdeconnect nautilus-kdeconnect
```

---

## Brave

To create webapps

```bash
sudo nala install curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo nala install brave-browser
```

---

## Programming

### Python

Python interpreter came pre-installed. But we must add `pip`, `venv`, and `tkinter`.

- `pip` is the python package manager

- `venv` is the tool to manage virtual environments

- `tkinter` is a GUI backend installed to use matplotlib

```bash
sudo nala install python3-pip python3-venv python3-tk
```

#### Jupyter notebooks

```bash
pip install jupyterlab
pip install --upgrade jupyterlab-vim
pip install jupytext
```

#### Neovim integration

```bash
mkdir -p ~/.local/venv && cd ~/.local/venv
python3 -m venv nvim
cd nvim
. ./bin/activate
pip install --upgrade pynvim
pip install ueberzug Pillow cairosvg pnglatex plotly kaleido jupyter-client
```

Last line is for Magma.

### Node 16 and Yarn

Mostly for other dependencies -- such as `npm`

```bash
curl -sL https://deb.nodesource.com/setup_16.x | sudo bash -
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg >/dev/null
     echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
     sudo nala update && sudo nala install yarn
```

`sudo nala instal nodejs` is not necessary, but can be run just to be sure.

### Rust

Because it's cool... and because of Neovim (Bob and Neovide).

```bash
curl --proto '=https' --tlsv1.2 -sSf "https://sh.rustup.rs" | sh
cargo install cargo-update
```

Make sure to have `gcc` (`build-essential`), `openssl` (including `libssl-dev`), and `pkg-config`

### Latex

Tex Live

```bash
sudo nala install texlive texlive-luatex texlive-lang-english texlive-lang-portuguese texlive-science perl-tk
```

Latexmk

```bash
sudo nala install latexmk
```

### Neovim

This way you get the last release - which is way newer than the one from APT

```bash
sudo add-apt-repository ppa:neovim-ppa/stable
sudo nala update
sudo nala install neovim
nvim +PackerSync
```

Settings in [init.lua](https://github.com/matheus-ft/nvim)

Also possible to get bleeding edge versions with `ppa:neovim-ppa/unstable` or nightly appimage builds

#### Bob

Installing and managing neovim versions.

From source

```bash
cargo install --git https://github.com/MordechaiHadad/bob.git
```

From crates

```bash
cargo install bob-nvim
```

Make sure to uninstall manually installed versions beforehand. And then

```bash
bob use <version>
```

#### Rip grep

Essential for a good Telescope experience

```bash
sudo nala install ripgrep
```

#### Neovide

GUI client. Building from source (first line of dependencies might be redundant, but it's here anyway)

```bash
sudo nala install gcc-multilib g++-multilib cmake libssl-dev pkg-config \
    libfreetype6-dev libasound2-dev libexpat1-dev libxcb-composite0-dev \
    libbz2-dev libsndio-dev freeglut3-dev libxmu-dev libxi-dev libfontconfig1-dev
cd ~/Downloads
git clone "https://github.com/neovide/neovide"
cd neovide
cargo build --release
cp ./target/release/neovide $HOME/.local/bin/
```

#### Default editor

##### In terminal emulator

```bash
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 100
sudo update-alternatives --config editor
```

##### In Gnome

Done with the files in [.local/share/applications](https://github.com/matheus-ft/.dotfiles/tree/master/.local/share/applications)

---

## Qtile

Installation:

```bash
pip3 install xcffib
pip3 install --no-cache-dir cairocffi
pip3 install qtile
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

Settings in [config.py](https://github.com/matheus-ft/.dotfiles/tree/master/.config/qtile/config.py).

[autostart.sh](https://github.com/matheus-ft/.dotfiles/tree/master/.config/qtile/scripts/autostart.sh) has autostart instructions (duh) - and don't forget to `chmod +x` it!!

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

### Picom

Compositor

```bash
cd ~/Downloads
sudo nala install libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl-dev libegl-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev
git clone https://github.com/yshui/picom
cd picom
git submodule update --init --recursive
meson --buildtype=release . build
ninja -C build
cp build/src/picom ~/.local/bin/
```

This requires having meson and ninja available (as well as GCC obviously)

### Dunst

Notifications

```bash
cd ~/Downloads
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

Also, cloned [DT's](https://gitlab.com/dwt1/wallpapers) and [catppuccin](https://github.com/catppuccin/wallpapers) wallpapers into ~/Pictures/wallpapers/

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

Copied the script from [`rofi-power-menu`](https://github.com/jluttine/rofi-power-menu) to `~/.local/bin`, did `chmod +x rofi-power-menu`
and added a keybind to my qtile config.

### Screen locker/saver

```bash
sudo nala install i3lock scrot
```

And add `~/.local/bin/i3lock-custom` with

```bash
#!/bin/bash
scrot /tmp/screenshot.png
convert /tmp/screenshot.png -blur 0x5 /tmp/screenshotblur.png
i3lock -i /tmp/screenshotblur.png
```

and then `chmod u+x` it

### Keyboard layout switcher

Create `~/.local/bin/toggle_keyboard_layout` (which is in PATH) with

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
sudo nala install libw-dev
pip install iwlib
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
