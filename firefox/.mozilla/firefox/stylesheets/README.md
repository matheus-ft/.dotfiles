# Firefox userChrome tweaks

Stowed to `~/.mozilla/firefox/stylesheets/` on every platform. That path is a
Linux convention, but it is only *storage* here -- Firefox never reads it
directly. You symlink `chrome/` into whichever profile you want it applied to,
so the same files serve Linux and macOS.

First, in `about:config`, set
`toolkit.legacyUserProfileCustomizations.stylesheets` to `true`.

Then link `chrome/` into your profile folder.

Linux:

```bash
ln -s ~/.mozilla/firefox/stylesheets/chrome/ ~/.mozilla/firefox/<profile>.default-release/
```

macOS -- profiles live elsewhere, and the path has spaces, so quote it:

```bash
ln -s ~/.mozilla/firefox/stylesheets/chrome/ \
  ~/"Library/Application Support/Firefox/Profiles/<profile>.default-release/"
```

Find `<profile>` by listing that directory, or read it off `about:profiles`.
Restart Firefox afterwards; changes to the CSS need a restart, not just a reload.

Models stealed from [other guy](https://github.com/MrOtherGuy/firefox-csshacks/tree/master/chrome)
