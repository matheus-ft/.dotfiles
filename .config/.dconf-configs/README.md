# Themes

## Basic `pop-os-basic.ini` 

First bits of personalization after clean install

## Custom `pop-os-custom.ini`

Same as the basic setup, but with the extensions.

## Dracula `pop-os-dracula.ini`

- [Dracula theme and Nord icons](https://draculatheme.com/gtk)

## BigSur-like `pop-os-mac.ini`

- [WhiteSur theme](https://github.com/vinceliuice/WhiteSur-gtk-theme):

```sh
./install.sh -d ~/.themes -o normal -c Dark -i popos -l -N glassy
```

- [Colloid icons](https://github.com/vinceliuice/Colloid-icon-theme):

```sh
./install.sh -d ~/.icons
```

## Better Cosmic `pop-os-rice.ini`

- [Orchis theme and standard Pop icons](https://github.com/vinceliuice/Orchis-theme)

```sh
./install.sh -d ~/.themes  -t orange -c dark --tweaks compact -l
```

---

### Gnome-terminal

- Gnome terminal settings are updated more often, so make sure you run

```sh
dconf load /org/gnome/terminal/ < gnome-terminal.ini
```

after dumping the whole theme.

    - terminal theme

```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/denysdovhan/gnome-terminal-one/master/one-dark.sh)"
```

