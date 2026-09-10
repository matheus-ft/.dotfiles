# macOS-only packages

Stow packages here are only meaningful on macOS:

```bash
stow --dir=~/.dotfiles/mac --target=~ <package>
```

Nothing lives here yet. The macOS-specific settings currently in use are small
enough to sit inside the cross-platform packages without breaking Linux --
`macos_option_as_alt` in `kitty/.config/kitty/keybindings.conf` is ignored by
kitty on X11, for instance. Move a package here the moment a file would actually
misbehave on Linux.
