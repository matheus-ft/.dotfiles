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

## Terminal

### Nala

Better package manager interface.

```sh
echo "deb https://deb.volian.org/volian/ scar main" | sudo tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list
wget -qO - https://deb.volian.org/volian/scar.key | sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg > /dev/null
sudo apt update && sudo apt install nala
```

### Exa

Better `ls` command.

```sh
sudo nala install exa
```

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

#### JetBrains Mono Nerd Font

Another cool nerd font

```sh
sudo nala install fonts-jetbrains-mono
```

Also installed a non-offical version of the italics manually from [github](https://github.com/Avi-D-coder/FiraCode-italic).

### Z shell

```sh
sudo nala install zsh
```

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

To get recent versions with APT, do

```sh
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo nala update
sudo nala install neovim
nvim +PackerSync
```

For the nightly version use https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage

Settings in [init.lua](https://github.com/matheus-ft/nvim) and simple alias in [aliases.sh](https://github.com/matheus-ft/dotfiles/blob/master/.config/shell/aliases.sh).

Also possible to use an AppImage

```sh
mkdir -p ~/Applications && cd ~/Applications
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
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
sudo cp ./target/release/neovide /usr/bin/
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

## Topgrade

A freaking cool way to upgrade the shit out of your system

```sh
cargo install topgrade
```

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

[autostart.sh](https://github.com/matheus-ft/.dotfiles/tree/master/.config/qtile/autostart.sh) has autostart instructions (duh) - and don't forget to `chmod +x autostart.sh`

## Additional software needed

### Rofi

Run prompt

```sh
sudo nala install rofi
```

### Vifm

Terminal based file manager

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

### Lxpolkit

Policy kit

```sh
sudo nala install lxpolkit
```

### Widgets dependencies

#### Wifi

```sh
sudo nala install libw-dev
pip install iwlib
```

#### CPU, RAM and stuff

```sh
pip install psutil
```

#### Thermal sensor

```sh
sudo nala install lm-sensors
```

