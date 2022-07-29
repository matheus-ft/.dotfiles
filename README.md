# Pop!_OS 22.04 with GNOME 42

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

### Z Shell

```sh
sudo nala install zsh
```

### Exa

Better `ls` command

```sh
sudo nala install exa
```

### Starship

```sh
curl -sS https://starship.rs/install.sh | sh
```

`starship` is set to be the shell prompt on [finish.sh](https://github.com/matheus-ft/dotfiles/blob/master/.bashrc.d/finish.sh)

Ricing in [starship.toml](https://github.com/matheus-ft/dotfiles/blob/master/.config/starship.toml)

### Kitty

```sh
sudo nala install kitty
```

Settings in [kitty.conf](https://github.com/matheus-ft/dotfiles/blob/master/.config/kitty)

#### Fira Code

Cool font with ligatures (and apparently the only one working properly with my terminal)

```sh
sudo nala install fonts-firacode
```

Also installed a non-offical version of the italics manually from [github](https://github.com/Avi-D-coder/FiraCode-italic)

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
```

Then just do `:w` and all plugins will be handled. Exit neovim and the next relaunch should be all good.

For the nightly version: https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage

Settings in [init.lua](https://github.com/matheus-ft/dotfiles/blob/master/.config/nvim) and simple aliases in [aliases.sh](https://github.com/matheus-ft/dotfiles/blob/master/.bashrc.d/aliases.sh)

Also possible to use an AppImage because Ubuntu likes the past, and I, the future

```sh
mkdir -p ~/Applications && cd ~/Applications
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
cd ~/.config/nvim/lua/matheus/
nvim packer.lua
```

#### Rip grep

Essential for a good Telescope experience

```sh
sudo nala install ripgrep
```

#### Neovide

GUI client. Building from source:

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

##### In terminal

```sh
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 100
sudo update-alternatives --config editor
```

##### In gnome

Done with the files in [.local/share/applications](https://github.com/matheus-ft/.dotfiles/tree/master/.local/share/applications)

---

## Topgrade

A freaking cool way to upgrade the shit out of your system

```sh
cargo install topgrade
```

---

## Desktop

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

