<!--toc:start-->

- [Instructions](#instructions)
  - [Layout](#layout)
  - [Shell layering](#shell-layering)
- [Setup](#setup)
  - [1. Bootstrap](#1-bootstrap)
  - [2. Fonts](#2-fonts)
  - [3. Terminal](#3-terminal)
  - [4. CLI tools](#4-cli-tools)
  - [5. Programming toolchain](#5-programming-toolchain)
  - [6. The dotfiles](#6-the-dotfiles)
- [Claude Code](#claude-code)
  - [Status line](#status-line)
  - [Careful with settings.json](#careful-with-settingsjson)
- [Linux only](#linux-only)
- [Package managers](#package-managers)
  - [Nala](#nala)
  - [Pacstall](#pacstall)
  - [Topgrade](#topgrade)
  - [Build tools](#build-tools)
  - [Starship](#starship)
  - [Screenshooter](#screenshooter)
- [Connection with mobile device](#connection-with-mobile-device)
- [Other apps](#other-apps)
  - [Brave](#brave)
  - [Zoom](#zoom)
- [Programming](#programming)
  - [Node.js](#nodejs)
  - [Neovim](#neovim)
    - [PPA](#ppa)
    - [Neovide](#neovide)
    - [Default editor](#default-editor)
      - [In a terminal](#in-a-terminal)
      - [In Gnome](#in-gnome)
- [Qtile](#qtile)
  - [Additional software needed](#additional-software-needed)
  - [System monitor](#system-monitor)
  - [Calendar](#calendar)
  - [Clipboard](#clipboard)
    - [Rofi](#rofi)
    - [Picom](#picom)
    - [Brightnessctl](#brightnessctl)
    - [Dunst](#dunst)
    - [Nitrogen](#nitrogen)
    - [Lxpolkit](#lxpolkit)
    - [Lxappearance](#lxappearance)
    - [Arandr](#arandr)
    - [Power Menu](#power-menu)
    - [Screen locker/saver](#screen-lockersaver)
    - [Keyboard layout switcher](#keyboard-layout-switcher)
    - [Bluetooth](#bluetooth)
    - [Widgets dependencies](#widgets-dependencies)
      - [Wifi](#wifi)
      - [CPU, RAM and stuff](#cpu-ram-and-stuff)
      - [Thermal sensor](#thermal-sensor)
      - [Cool icons](#cool-icons)
  - [GNOME Desktop](#gnome-desktop)
    - [GNOME tweaks](#gnome-tweaks)
    - [Extension Manager](#extension-manager)
    - [Dconf](#dconf)

<!--toc:end-->

# Instructions

Managed with [GNU Stow](https://www.gnu.org/software/stow/). Every top-level
directory is a _package_ whose insides mirror `$HOME`, so
`zsh/.config/zsh/finish.sh` gets linked to `~/.config/zsh/finish.sh`.

After a clean install/new machine:

```bash
git clone git@github.com:matheus-ft/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
stow shell zsh kitty vim firefox claude
```

Stow refuses to clobber a real file, so if it complains, move the conflicting
file aside and re-run. `stow -n -v <package>` dry-runs without touching
anything, and `stow -D <package>` unlinks it again.

## Layout

| Where         | What                            | How to stow                                        |
| ------------- | ------------------------------- | -------------------------------------------------- |
| repo root     | cross-platform packages         | `stow <package>`                                   |
| `linux/`      | X11/Linux-desktop-only packages | `stow --dir=linux --target=~ <package>`            |
| `mac/`        | macOS-only packages             | `stow --dir=mac --target=~ <package>`              |
| `deprecated/` | kept for reference, not stowed  | see [`deprecated/README.md`](deprecated/README.md) |

Cross-platform: `shell`, `zsh`, `kitty`, `vim`, `firefox`, `claude`.

Linux-only: `qtile`, `rofi`, `dunst`, `picom`, `copyq`, `pop-shell`, `dconf`,
`htop`, `neofetch`, `topgrade`, `screenlayout`, `desktop-entries`. On a Linux:

```bash
stow --dir=~/.dotfiles/linux --target=~ qtile rofi dunst picom copyq pop-shell
```

`dconf` and `firefox` are storage rather than live config: stow puts the files
in place, but applying them is a second step. For firefox that step is a
script, so it is one command on either platform:

```bash
~/.mozilla/firefox/stylesheets/apply.sh
```

It links `chrome/` into your profile and sets the pref that makes Firefox read
it. That is why `firefox` sits at the root rather than under `linux/` -- the
stylesheets are identical on both platforms and only the profile directory
differs, which the script works out for itself. Note that the stylesheets
themselves are stale; see
[their README](firefox/.mozilla/firefox/stylesheets/README.md).
`dconf` still wants `dconf load` ran by hand.

## Shell layering

`shell/` is deliberately shell-agnostic: it puts `aliases.sh` and `variables.sh`
in `~/.config/shell/`, and `zsh/.config/zsh/finish.sh` sources everything it
finds there. **`shell` and `zsh` must both be stowed** -- without `shell`, zsh
loses its aliases and `~/.local/bin` drops off `PATH`.

Bash used to be the other consumer of that directory; it now lives in
`deprecated/bash/`.

The startup files that run _before_ `.zshrc` are tracked too, because they
carry the toolchain `PATH` setup:

| File        | Package | Runs on                                     |
| ----------- | ------- | ------------------------------------------- |
| `.zshenv`   | `zsh`   | every zsh, interactive or not -- rust + bob |
| `.zprofile` | `zsh`   | zsh login shells -- Homebrew                |
| `.profile`  | `shell` | sh/bash login shells -- rust                |

Every line in them is guarded by an existence check, so a machine without
cargo, bob or Homebrew sources them without error.

# Setup

Everything here is shared: both machines get it, only the install command
differs. Linux-only software lives under [Linux only](#linux-only) at the end.

## 1. Bootstrap

macOS -- Command Line Tools give `git`, `cc` and `g++`, which Homebrew needs:

```bash
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install stow
```

Ignore the `shellenv` line the installer prints -- `zsh/.zprofile` already runs
it, on every login rather than once.

Linux -- set up [Nala](#nala) first, then:

```bash
sudo nala install stow build-essential meson ninja-build
```

## 2. Fonts

JetBrains Mono Nerd Font, which every kitty and terminal setting here assumes.

macOS:

```bash
brew install --cask font-jetbrains-mono-nerd-font
```

Linux -- grab the zip from <https://www.nerdfonts.com/font-downloads>, then:

```bash
unzip JetBrainsMono.zip -d ~/.local/share/fonts/JetBrainsMono/
fc-cache -fv
```

## 3. Terminal

Kitty. Settings in [kitty.conf](kitty/.config/kitty).

```bash
brew install --cask kitty   # macOS
sudo nala install kitty     # Linux
```

Zsh is already the login shell on macOS. On Linux:

```bash
sudo nala install zsh zsh-doc
chsh -s $(which zsh)
```

Then oh-my-zsh and its two add-ons, identical on both:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

The oh-my-zsh installer writes its own `~/.zshrc`. Delete it, or stow will
refuse to overwrite it in step 6:

```bash
rm ~/.zshrc
```

## 4. CLI tools

| tool    | what for                               | macOS                        | Linux                        |
| ------- | -------------------------------------- | ---------------------------- | ---------------------------- |
| eza     | better `ls`                            | `cargo install eza --locked` | `cargo install eza --locked` |
| bat     | better `cat`                           | `brew install bat`           | `sudo nala install bat`      |
| ripgrep | Telescope, and grep generally          | `brew install ripgrep`       | `sudo nala install ripgrep`  |
| fd      | faster `find`                          | `brew install fd`            | `sudo nala install fd-find`  |
| jq      | the Claude [status line](#status-line) | ships with recent macOS      | `sudo nala install jq`       |

`--locked` is not optional for eza: without it cargo resolves a `palette`
version that fails to build on current rustc. `brew install eza` also works on
macOS if you would rather not compile it.

eza is the maintained fork of `exa`, which was archived in 2023.

## 5. Programming toolchain

Rust -- needed for eza, bob and neovide, so it comes first:

```bash
curl --proto '=https' --tlsv1.2 -sSf "https://sh.rustup.rs" | sh
cargo install cargo-update
```

On Linux also make sure you have `gcc` (`build-essential`), `openssl`
(including `libssl-dev`) and `pkg-config`.

Neovim through [bob](https://github.com/MordechaiHadad/bob), so the version is
pinned the same way on both machines. Uninstall any manually installed neovim
first. Settings live in [their own repo](https://github.com/matheus-ft/nvim).

```bash
cargo install bob-nvim
bob use stable
```

Neovide, the GUI client:

```bash
brew install --cask neovide   # macOS
```

On Linux it has to be [built from source](#neovide).

Node, mostly for other things' dependencies:

```bash
brew install node             # macOS
```

On Linux use the [NodeSource repo](#nodejs).

Python ships with both; what is missing is `pip`, `venv` and `tkinter` (a
matplotlib backend):

```bash
brew install python-tk                              # macOS
sudo nala install python3-pip python3-venv python3-tk   # Linux
```

Jupyter, if wanted:

```bash
pip install jupyterlab
pip install --upgrade jupyterlab-vim
pip install jupytext
```

And the venv neovim talks to:

```bash
mkdir -p $HOME/.local/venv && cd $HOME/.local/venv
python3 -m venv nvim
cd nvim
. ./bin/activate
pip install --upgrade pynvim
pip install Pillow cairosvg pnglatex plotly kaleido jupyter-client black docformatter
```

Last line is for Magma and Formatter. TODO find replacement for `ueberzug`

LaTeX:

```bash
brew install --cask mactex-no-gui   # macOS
```

```bash
sudo nala install texlive texlive-luatex texlive-lang-english \
    texlive-lang-portuguese texlive-science perl-tk texlive-bibtex-extra biber
sudo nala install latexmk
```

## 6. The dotfiles

Clone and stow as described in [Instructions](#instructions).

Firefox, if it is not on the machine yet:

```bash
brew install --cask firefox   # macOS
sudo nala install firefox     # Linux
```

Then link the stylesheets into its profile:

```bash
~/.mozilla/firefox/stylesheets/apply.sh
```

Open a new terminal when you are done -- `.zshenv` and `.zprofile` only run on a
fresh login shell, so the `PATH` from step 5 is not live in the one you set all
this up in.

---

# Claude Code

Cross-platform package at the repo root, holding `settings.json` and the status
line:

```bash
stow claude
```

Stow folds into the existing `~/.claude` instead of replacing it, linking each
entry individually. That matters: `~/.claude/skills` is a symlink to a separate
repo ([matheus-ft/skills](https://github.com/matheus-ft/skills)) and has to
survive untouched.

## Status line

The bar above Claude Code's footer: repo, branch, worktree and open PR on the
left; model, context window, rate limits and session cost on the right. It is a
bash script handed a JSON payload on stdin, so it needs a shell, `jq`, `git` and
a working directory -- which is why it is machine config rather than something
for the skills repo.

Render it against captured fixtures, without starting a session:

```bash
~/.claude/statusline/preview.sh
```

Full notes in
[`claude/.claude/statusline/README.md`](claude/.claude/statusline/README.md).

## Careful with `settings.json`

Claude Code rewrites that file whenever you change a setting through `/config`.
If a write replaces it instead of following the symlink, the repo quietly stops
tracking reality. To check, and repair if needed:

```bash
test -L ~/.claude/settings.json || stow -R claude
```

---

---

# Linux only

Debian-based distros running X11.

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

## Starship

Prompt that works with any shell.

```bash
curl -sS https://starship.rs/install.sh | sh
```

Ricing in [starship.toml](deprecated/bash/.config/starship.toml).

zsh uses Powerlevel10k instead, so starship only ever applied to bash -- both now
live in [`deprecated/bash/`](deprecated/README.md).

## Screenshooter

```bash
sudo nala install flameshot
```

# Connection with mobile device

> For GNOME, use the extension [GSConnect](https://extensions.gnome.org/extension/1319/gsconnect/)

Yes, this is a KDE app, so be ready for a shit ton of dependencies

```bash
sudo nala install kdeconnect nautilus-kdeconnect
```

# Other apps

## Brave

If you want to create some webapps

```bash
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update && sudo nala install brave-browser
```

## Zoom

```bash
flatpak install flathub us.zoom.Zoom
```

# Programming

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

## Neovim

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
# sudo update-alternatives --config editor
```

#### In Gnome

Done with the files in [linux/desktop-entries](linux/desktop-entries/.local/share/applications)

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

Settings in [config.py](linux/qtile/.config/qtile).

## Additional software needed

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

### Rofi

Run prompt

```bash
sudo nala install rofi
```

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

### Brightnessctl

To regulate the monitor backlight

```bash
sudo nala install brightnessctl
```

Possibly needed to do `sudo usermod -aG video ${USER}` and reboot

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

## GNOME Desktop

### GNOME tweaks

```bash
sudo nala install gnome-tweaks
```

### Extension Manager

```bash
flatpak install flathub com.mattjakeman.ExtensionManager
```

or

```bash
sudo nala install gnome-shell-extension-manager
```

Extensions added:

- [User Themes](https://extensions.gnome.org/extension/19/user-themes/)

- [Vitals](https://extensions.gnome.org/extension/1460/vitals/) - superfluous?

~~- [Dash to Panel](https://extensions.gnome.org/extension/1160/dash-to-panel/)~~ (not anymore)

- [Auto Move Windows](https://extensions.gnome.org/extension/16/auto-move-windows/) - didn't actually use yet

- others to make the DE look cool as needed

### Dconf

- Settings are in [linux/dconf](linux/dconf/.config/.dconf-configs) : `pop-os-{specifier}.ini`

How to

- save

```bash
dconf dump <path> > config-name.ini
```

- apply

```bash
dconf load <path> < config-name.ini
```
