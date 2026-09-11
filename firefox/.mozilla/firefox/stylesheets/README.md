# Firefox userChrome tweaks

## Why this takes two steps

Stow puts these files at `~/.mozilla/firefox/stylesheets/`. That is *storage* --
Firefox never reads that path. Firefox only reads `chrome/userChrome.css` inside
a **profile** directory, and a profile is named with a random prefix
(`oxswe49e.default-release`) that differs on every machine, under a path that
differs per platform:

| | profiles live in |
| --- | --- |
| Linux | `~/.mozilla/firefox/` |
| macOS | `~/Library/Application Support/Firefox/Profiles/` |

Stow cannot target a directory whose name it cannot predict, so the second step
exists to bridge that gap. It is one command, and re-running it is harmless:

```sh
~/.mozilla/firefox/stylesheets/apply.sh
```

That finds the `*.default-release` profile for your platform, symlinks `chrome/`
into it, and sets the two prefs below in `user.js` -- not `prefs.js`, which
Firefox rewrites from under you. Pass a name or path to target another profile:

```sh
~/.mozilla/firefox/stylesheets/apply.sh oxswe49e.default-release
```

It refuses to clobber a profile that already has a real `chrome/` directory, and
leaves a pref alone if you have already set it to something else.
**Restart Firefox afterwards** -- userChrome is read only at startup.

Prefs it sets:

| pref | why |
| --- | --- |
| `toolkit.legacyUserProfileCustomizations.stylesheets` | makes Firefox read `userChrome.css` at all |
| `userchrome.navbar-tabs-oneliner.tabs-on-right.enabled` | tabs to the right of the address bar; upstream defaults to left |

## What it does

`userChrome.css` is only an entry point. It imports:

- **`oneline_toolbar.css`** -- upstream, verbatim. Puts the tab strip and the
  address bar on a single row using CSS grid.
- **`custom.css`** -- mine. Splits that row evenly instead of upstream's 60/40.

**`hide_tabs_toolbar_v2.css`** is also here but commented out of
`userChrome.css`. It hides the tab strip completely; uncomment the `@import` to
use it instead of the one-liner.

## Keeping it in sync

The previous version of this folder was pinned so long ago that every upstream
source had been deleted or rewritten, and it had quietly stopped working:
Firefox dropped the XUL internals it targeted (`-moz-box-pack`,
`-moz-appearance`, `:root[tabsintitlebar]`). It is now on the current rewrite,
which requires **Firefox 133+**.

To avoid repeating that, upstream files are kept **byte-identical** and all
local changes live in `custom.css`. Re-syncing is a copy, never a merge:

```sh
cd ~/.dotfiles/firefox/.mozilla/firefox/stylesheets/chrome
base=https://raw.githubusercontent.com/MrOtherGuy/firefox-csshacks/master/chrome
curl -fsSL -O $base/oneline_toolbar.css
curl -fsSL -O $base/hide_tabs_toolbar_v2.css
```

Then check `custom.css` still lines up -- it overrides
`grid-template-columns` on `#navigator-toolbox`, so it only breaks if upstream
renames that.

Models stealed from [other guy](https://github.com/MrOtherGuy/firefox-csshacks/tree/master/chrome)
