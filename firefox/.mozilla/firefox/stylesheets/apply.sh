#!/usr/bin/env sh
# Link these stylesheets into a Firefox profile and set the prefs they need.
# Idempotent -- safe to re-run.
#
#   ./apply.sh            # auto-detect the *.default-release profile
#   ./apply.sh <profile>  # profile directory name, or an absolute path
#
# Restart Firefox afterwards; userChrome is read at startup only.

set -eu

styles_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

case $(uname -s) in
    Darwin) profiles_dir="$HOME/Library/Application Support/Firefox/Profiles" ;;
    *)      profiles_dir="$HOME/.mozilla/firefox" ;;
esac

if [ ! -d "$profiles_dir" ]; then
    echo "no Firefox profiles directory at: $profiles_dir" >&2
    exit 1
fi

if [ $# -ge 1 ]; then
    case $1 in
        /*) profile=$1 ;;
        *)  profile="$profiles_dir/$1" ;;
    esac
else
    set -- "$profiles_dir"/*.default-release
    if [ ! -d "$1" ]; then
        echo "no *.default-release profile in $profiles_dir -- pass one explicitly:" >&2
        ls -1 "$profiles_dir" >&2
        exit 1
    fi
    if [ $# -gt 1 ]; then
        echo "several default-release profiles -- pass the one you want:" >&2
        for p in "$@"; do echo "  $(basename "$p")" >&2; done
        exit 1
    fi
    profile=$1
fi

if [ ! -d "$profile" ]; then
    echo "not a profile directory: $profile" >&2
    exit 1
fi

# 1. link chrome/ into the profile
link="$profile/chrome"
if [ -L "$link" ]; then
    rm -f "$link"
elif [ -e "$link" ]; then
    echo "refusing to replace the real directory $link" >&2
    echo "move it aside, then re-run" >&2
    exit 1
fi
ln -s "$styles_dir/chrome" "$link"
echo "linked  $link"
echo "     -> $styles_dir/chrome"

# 2. prefs, written to user.js so Firefox does not overwrite them in prefs.js
userjs="$profile/user.js"

set_pref() {
    _name=$1
    _value=$2
    _line="user_pref(\"$_name\", $_value);"
    if grep -Fq "$_line" "$userjs" 2>/dev/null; then
        echo "pref    $_name -- already $_value"
    elif grep -Fq "\"$_name\"" "$userjs" 2>/dev/null; then
        echo "pref    $_name -- present with another value, left alone" >&2
    else
        printf '%s\n' "$_line" >> "$userjs"
        echo "pref    $_name = $_value"
    fi
}

# makes Firefox read userChrome.css at all
set_pref toolkit.legacyUserProfileCustomizations.stylesheets true
# upstream's oneline_toolbar.css puts tabs on the left by default
set_pref userchrome.navbar-tabs-oneliner.tabs-on-right.enabled true

echo
echo "Done. Restart Firefox to see it."
