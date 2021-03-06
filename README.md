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

## Kitty

```sh
sudo apt install kitty
```

Settings in [kitty.conf](https://github.com/matheus-ft/dotfiles/blob/master/.config/kitty)

### Fira Code

Cool font with ligatures (and apparently the only one working properly with my terminal)

```sh
sudo apt install fonts-firacode
```

Also installed a non-offical version of the italics manually from [github](https://github.com/Avi-D-coder/FiraCode-italic)

---

## Starship

```sh
curl -sS https://starship.rs/install.sh | sh
```

`starship` is set to be the shell prompt on [finish.sh](https://github.com/matheus-ft/dotfiles/blob/master/.bashrc.d/finish.sh)

Ricing in [starship.toml](https://github.com/matheus-ft/dotfiles/blob/master/.config/starship.toml)

---

## Exa

Better `ls` command

```sh
sudo apt install exa
```

---

## Programming

### Neovim

Using an AppImage because Ubuntu likes the past, and I, the future

```sh
mkdir -p ~/Applications && cd ~/Applications
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
cd ~/.config/nvim/lua/matheus/
nvim packer.lua
```

Then just do `:w` and all plugins will be handled. Exit neovim and the next relaunch should be all good.

For the nightly version: https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage

Settings in [init.lua](https://github.com/matheus-ft/dotfiles/blob/master/.config/nvim) and simple aliases in [aliases.sh](https://github.com/matheus-ft/dotfiles/blob/master/.bashrc.d/aliases.sh)

#### Rip grep

Essential for a good telescope experience

```sh
sudo apt install ripgrep
```

### Node.js 16 and Yarn

For Typescript programming and to use pyright language server in Neovim (also, Yarn is a dependency for the markdown
preview plugin in neovim).

```sh
curl -sL https://deb.nodesource.com/setup_16.x | sudo bash -
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg >/dev/null
     echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
     sudo apt-get update && sudo apt-get install yarn
```

`sudo apt instal nodejs` is not necessary, but can be run just to be sure.

### Python

Python interpreter came pre-installed. But we must add `pip`, `venv`, and `tkinter`.

- `pip` is the python package manager

- `venv` is the tool to manage virtual environments

- `tkinter` is a GUI backend installed to use matplotlib

```sh
sudo apt install python3-pip python3-venv python3-tk
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

