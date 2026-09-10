# Firefox userChrome tweaks

Stowed to `~/.mozilla/firefox/stylesheets/` on every platform. That path is a
Linux convention, but it is only *storage* -- Firefox never reads it directly.
You link `chrome/` into whichever profile should use it, which is why the same
files serve Linux and macOS.

## Applying it

```sh
~/.mozilla/firefox/stylesheets/apply.sh
```

That finds the `*.default-release` profile for your platform, links `chrome/`
into it, and enables `toolkit.legacyUserProfileCustomizations.stylesheets` via
`user.js` (rather than `prefs.js`, which Firefox rewrites). Re-running is safe.
Pass a profile name or path to target a different one:

```sh
~/.mozilla/firefox/stylesheets/apply.sh oxswe49e.default-release
```

It refuses to clobber a profile that already has a real `chrome/` directory.
**Restart Firefox afterwards** -- userChrome is read at startup only.

## What it does

`userChrome.css` is just an entry point; it imports `oneliner.css` and nothing
else.

- **`oneliner.css`** puts the tab strip and the address bar on a *single row*,
  tabs to the right of an address bar occupying half the window width. It only
  engages on windows at least 1100px wide; narrower than that, Firefox falls
  back to its normal two-row layout.
- **`hidden_tabs.css`** would hide the tab strip completely, keeping only the
  all-tabs dropdown next to the window controls. It is **not currently
  imported**, so it does nothing. Add `@import "./hidden_tabs.css";` to
  `userChrome.css` to switch from the one-liner to the no-tabs look.
- **`window_control_placeholder_support.css`** is a dependency of
  `hidden_tabs.css`, reserving space so the minimise/maximise/close buttons do
  not overlap the toolbar. Also dormant.

## These are out of date

They were copied from [MrOtherGuy's
csshacks](https://github.com/MrOtherGuy/firefox-csshacks) and pinned. Upstream
has since deleted or rewritten all three source files:

| this repo | upstream now |
| --- | --- |
| `oneliner.css` (from `navbar_tabs_responsive_oneliner.css`) | `oneline_toolbar.css` -- "Requires Fx 133+" |
| `hidden_tabs.css` (from `hide_tabs_toolbar_w_with_alltabs_button.css`) | `hide_tabs_toolbar_v2.css` |
| `window_control_placeholder_support.css` | removed |

The copies here target Firefox's old XUL internals: they use `-moz-box-pack`,
`-moz-appearance`, and the `:root[tabsintitlebar]` attribute, which the current
rewrite replaces with `:root[customtitlebar]`. Expect them to do little or
nothing on a modern Firefox.

Porting is not a straight copy -- `oneliner.css` here carries local edits (the
1100px breakpoint and the 50vw address bar), and those knobs are named
differently upstream, so the tweaks have to be re-applied by hand.

Models stealed from [other guy](https://github.com/MrOtherGuy/firefox-csshacks/tree/master/chrome)
