#!/usr/bin/env sh
# Link these stylesheets into a Firefox profile and turn on the pref that makes
# Firefox read them. Idempotent -- safe to re-run.
#
#   ./apply.sh            # auto-detect the *.default-release profile
#   ./apply.sh <profile>  # profile directory name, or an absolute path
#
# Restart Firefox afterwards; userChrome changes are read at startup only.

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

# 2. enable the pref, via user.js so it survives Firefox rewriting prefs.js
pref_name='toolkit.legacyUserProfileCustomizations.stylesheets'
pref_line="user_pref(\"$pref_name\", true);"
userjs="$profile/user.js"

if grep -Fq "$pref_line" "$userjs" 2>/dev/null; then
    echo "pref    already enabled in user.js"
elif grep -Fq "$pref_name" "$userjs" 2>/dev/null; then
    echo "pref    present but not true in $userjs -- fix that line by hand" >&2
else
    printf '%s\n' "$pref_line" >> "$userjs"
    echo "pref    enabled in user.js"
fi

echo
echo "Done. Restart Firefox to see it."
