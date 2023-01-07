In `about:config` set `toolkit.legacyUserProfileCustomizations.stylesheets` to `true`

And symlink these settings to your profile folder

```bash
mkdir -p ~/.mozilla/firefox/<profile>.default-release/chrome
ln -s ~/.mozilla/firefox/stylesheets/chrome/ ~/.mozilla/firefox/<profile>.default-release/
```

Models stealed from [other guy](https://github.com/MrOtherGuy/firefox-csshacks/tree/master/chrome)
