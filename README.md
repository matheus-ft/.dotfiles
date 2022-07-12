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

Note that `config` is the alias for this bare repo, so `git` won't work.

---

## Kitty

Installation

```sh
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
```

Desktop integration

```sh
# Create a symbolic link to add kitty to PATH (assuming ~/.local/bin is in
# your system-wide PATH)
ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/
# Place the kitty.desktop file somewhere it can be found by the OS
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
# If you want to open text files and images in kitty via your file manager also add the kitty-open.desktop file
cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
# Update the paths to the kitty and its icon in the kitty.desktop file(s)
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
```

These commands are from the [website](https://sw.kovidgoyal.net/kitty/binary/)

Settings in kitty.conf

### Fira Code

Font with ligatures

```sh
sudo apt install fonts-firacode
```

Also installed a non-offical version of the italics manually from [github](https://github.com/Avi-D-coder/FiraCode-italic)

---

## Exa

Better `ls` command

```sh
sudo apt install exa
```

---

## Starship

```sh
curl -sS https://starship.rs/install.sh | sh
```

`starship` is set to be the shell prompt os the last line of [bash_finish](https://github.com/matheus-ft/dotfiles/blob/master/.bashrc.d/finish)

Ricing in [starship.toml](https://github.com/matheus-ft/dotfiles/blob/master/.config/starship.toml)

---

## Programming

### Neovim

Using an AppImage because Ubuntu likes the past, and I, the future

```sh
mkdir -p ~/Applications && cd ~/Applications
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
```

For the nightly version: https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage

Settings in [init.lua](https://github.com/matheus-ft/dotfiles/blob/master/.config/nvim/init.lua) and simple alias in [bash_aliases](https://github.com/matheus-ft/dotfiles/blob/master/.bashrc.d/aliases)

#### Packer

Plugin manager for Neovim

```sh
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

### Node.js 16

For Typescript programming and to use pyright language server in Neovim

```sh
curl -sL https://deb.nodesource.com/setup_16.x | sudo bash -
sudo apt instal nodejs
```

#### Yarn

Dependency for Neovim's plugin for markdown preview

```sh
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg >/dev/null
     echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
     sudo apt-get update && sudo apt-get install yarn
```

### Python

Python interpreter came pre-installed. But we must add `pip`, `venv`, and `tkinter`.

- `pip` is the python package manager

- `venv` is the tool to manage virtual environments

- `tkinter` is a GUI backend installed to use matplotlib

```sh
sudo apt install python3-pip python3-venv python3-tk
```

System-wide virtual environments

```sh
mkdir -p ~/.local/venv && cd ~/.local/venv
python3 -m venv <env-name>
cd <env-name>
. ./bin/activate
pip install <packages>
```

### Octave

Because matlab is exxxpensive

```sh
sudo apt install octave
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

## To do

- startup script to load dconf configs automatically and also change starship.toml, theme.lua and gnome-terminal profile based on the current colorscheme

