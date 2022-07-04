# Pop!_OS 22.04 with GNOME 42.1

How to manage:

After an OS clean install, do

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

Settings are in [starship.toml](https://github.com/matheus-ft/dotfiles/blob/master/.config/starship.toml)

---

## Programming

### Neovim

```sh
mkdir ~/Applications && cd ~/Applications
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
```

Config in [init.lua](https://github.com/matheus-ft/dotfiles/blob/master/.config/nvim/init.lua)

Alias in [bash_aliases](https://github.com/matheus-ft/dotfiles/blob/master/.bashrc.d/finish)

#### Vim-plug

Plugin manager for Neovim

```sh
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
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

```sh
sudo apt install python3-venv python3-pip
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

- [Vitals](https://extensions.gnome.org/extension/1460/vitals/) - no need for htop anymore

- [Dash to Panel](https://extensions.gnome.org/extension/1160/dash-to-panel/)

- [Auto Move Windows](https://extensions.gnome.org/extension/16/auto-move-windows/) - didn't actually use yet

### Dconf

- Settings are in [.dconf-configs](https://github.com/matheus-ft/.dotfiles/tree/master/.config/.dconf-configs) : `pop-os-{specifier}.ini`

How to:

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

