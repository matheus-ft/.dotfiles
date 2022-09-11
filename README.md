# Pop!_OS 22.04

How to manage:

After a clean install, do

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

Note that `config` is the alias for this *bare repo*, so `git` won't work.

---

## Package managers

Language specific ones detailed under [programming](https://github.com/matheus-ft/.dotfiles#programming).

### Nala

Better package manager interface for APT.

```sh
echo "deb https://deb.volian.org/volian/ scar main" | sudo tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list
wget -qO - https://deb.volian.org/volian/scar.key | sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg > /dev/null
sudo apt update && sudo apt install nala
```

### Pacstall

Debian based distros' AUR.

```sh
sudo bash -c "$(curl -fsSL https://git.io/JsADh || wget -q https://git.io/JsADh -O -)"
```

### Topgrade

A freaking cool way to upgrade the shit out of your system - make sure to have [Rust](https://github.com/matheus-ft/.dotfiles#rust) set up before.

```sh
cargo install topgrade
```

---

## Terminal

### Kitty

Better terminal emulator.

```sh
sudo nala install kitty
```

Settings in [kitty.conf](https://github.com/matheus-ft/dotfiles/blob/master/.config/kitty).

#### Fira Code

Cool font with ligatures (and apparently the only one working properly with my terminal).

```sh
sudo nala install fonts-firacode
```

Also installed a non-offical version of the italics manually from [github](https://github.com/Avi-D-coder/FiraCode-italic).

#### JetBrains Mono Nerd Font

Another cool nerd font.

```sh
sudo nala install fonts-jetbrains-mono
```

### Z shell

```sh
sudo nala install zsh
chsh -s $(which zsh)
```

Last line makes z shell the default shell.

#### Oh My Zsh

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

##### Powerlevel10k

```sh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

### Starship

Prompt that works with any shell.

```sh
curl -sS https://starship.rs/install.sh | sh
```

Ricing in [starship.toml](https://github.com/matheus-ft/dotfiles/blob/master/.config/starship.toml).

For zsh, Powerlevel10k does it better, but this is still set for bash.

### Exa

Better `ls` command.

```sh
sudo nala install exa
```

### Htop

```sh
sudo nala install htop
```

---

## Programming

### Python

Python interpreter came pre-installed. But we must add `pip`, `venv`, and `tkinter`.

- `pip` is the python package manager

- `venv` is the tool to manage virtual environments

- `tkinter` is a GUI backend installed to use matplotlib


```sh
sudo nala install python3-pip python3-venv python3-tk
```

#### Jupyter notebooks

```sh
pip install jupyterlab
pip install --upgrade jupyterlab-vim
pip install jupytext
```

#### Neovim integration

```sh
pip install --upgrade pynvim
pip install ueberzug Pillow cairosvg pnglatex plotly kaleido
```

### Node.js 16 and Yarn

For Typescript programming and to use pyright language server in Neovim (also, Yarn is a dependency for the markdown
preview plugin in neovim).

```sh
curl -sL https://deb.nodesource.com/setup_16.x | sudo bash -
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg >/dev/null
     echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
     sudo nala update && sudo nala install yarn
```

`sudo nala instal nodejs` is not necessary, but can be run just to be sure.

### Rust

Because it's cool... and because Neovide requires it.

```sh
curl --proto '=https' --tlsv1.2 -sSf "https://sh.rustup.rs" | sh
cargo install cargo-update
```

### Neovim

```sh
mkdir -p ~/Applications && cd ~/Applications
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage +PackerSync
```

For the nightly version use https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage

Settings in [init.lua](https://github.com/matheus-ft/nvim) and simple alias in [aliases.sh](https://github.com/matheus-ft/dotfiles/blob/master/.config/shell/aliases.sh).

Also possible to get bleeding edge versions with APT:

```sh
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo nala update
sudo nala install neovim
nvim +PackerSync
```

#### Rip grep

Essential for a good Telescope experience

```sh
sudo nala install ripgrep
```

#### Neovide

GUI client. Building from source

```sh
sudo nala install gcc-multilib g++-multilib cmake libssl-dev pkg-config \
    libfreetype6-dev libasound2-dev libexpat1-dev libxcb-composite0-dev \
    libbz2-dev libsndio-dev freeglut3-dev libxmu-dev libxi-dev libfontconfig1-dev
cd Downloads
git clone "https://github.com/neovide/neovide"
cd neovide && cargo build --release
sudo cp ./target/release/neovide $HOME/.local/bin/
```

#### Default editor

##### In terminal emulator

```sh
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 100
sudo update-alternatives --config editor
```

##### In Gnome

Done with the files in [.local/share/applications](https://github.com/matheus-ft/.dotfiles/tree/master/.local/share/applications)

---

## Qtile

Installation:

```sh
pip3 install xcffib
pip3 install --no-cache-dir cairocffi
pip3 install qtile
```

To login, create a `/usr/share/xsessions/qtile.desktop`:

```
[Desktop Entry]
Name=Qtile
Comment=Qtile Session
Exec=qtile start
Type=Application
Keywords=wm;tiling
```

[config.py](https://github.com/matheus-ft/.dotfiles/tree/master/.config/qtile/config.py) was heavily inspired by [DistroTube](https://gitlab.com/dwt1/dotfiles/-/tree/master/.config/qtile) and
[David](https://github.com/david35mm/.files/tree/main/.config/qtile)

[autostart.sh](https://github.com/matheus-ft/.dotfiles/tree/master/.config/qtile/scripts/autostart.sh) has autostart instructions (duh) - and don't forget to `chmod +x autostart.sh`

## Additional software needed

### Rofi

Run prompt

```sh
sudo nala install rofi
```

### Brightnessctl

To regulate the monitor backlight

```sh
sudo nala install brightnessctl
```

### Picom

Compositor

```sh
sudo nala install picom
```

### Nitrogen

To set wallpapers

```sh
sudo nala install nitrogen
```

Also, cloned [DT's wallpapers](https://gitlab.com/dwt1/wallpapers) repo into ~/Pictures

### Lxpolkit

Policy kit

```sh
sudo nala install lxpolkit
```

### Lxappearance

LXDE GTK+ theme switcher

```sh
sudo nala install lxappearance
```

### Arandr

Simple visual front end for XRandR (to easily align multiple monitors)

```sh
sudo nala install arandr
```

### Power Menu

Copied the script from [`rofi-power-menu`](https://github.com/jluttine/rofi-power-menu) to `~/.local/bin`, did `chmod +x rofi-power-menu`
and added a keybind to my qtile config.

### Keyboard layout switcher

Create `~/.local/bin/toggle_keyboard_layout` (which is in PATH) with

```sh
#!/usr/bin/bash

case $(setxkbmap -query | grep layout | awk '{ print $2 }') in
            us) setxkbmap br ;;
            br) setxkbmap us ;;
esac
```

### Widgets dependencies

#### Wifi

```sh
sudo nala install libw-dev
pip install iwlib
```

`nm-applet` was already installed apparently, but it's possible to manage network connection with `nmcli dev wifi`

#### CPU, RAM and stuff

```sh
pip install psutil
```

#### Thermal sensor

```sh
sudo nala install lm-sensors
```

#### Cool icons

[Nerd fonts cheat sheet](https://www.nerdfonts.com/cheat-sheet)

---

## GNOME Desktop

### GNOME tweaks

```sh
sudo nala install gnome-tweaks
```

### Extension Manager

```sh
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

```sh
dconf dump <path> > config-name.ini
```

- apply

```sh
dconf load <path> < config-name.ini
```

