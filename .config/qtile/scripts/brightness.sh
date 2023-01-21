#!/usr/bin/bash
# credits: https://code.badjware.dev/badjware/dotfiles/commit/9f56a7c74486e5a563dbbb3be9fbcec7c04e29ff?style=split&whitespace=ignore-eol
# modified by me

function get_brightness {
  brightnessctl -m | grep -o '[0-9]\+%' | head -c-2
}

function send_notification {
  icon=~/.config/qtile/icons/sun.png
  brightness=$(get_brightness)
  # Make the bar with the special character ─ (it's not dash -)
  # https://en.wikipedia.org/wiki/Box-drawing_character
  bar=$(seq -s "─" 0 $((brightness / 5)) | sed 's/[0-9]//g')
  # Send the notification
  dunstify -i "$icon" -r 5555 -u normal "  $bar"
}

case $1 in
  up)
    # increase the backlight by 5%
    brightnessctl set +5%
    send_notification
    ;;
  down)
    # decrease the backlight by 5%
    brightnessctl set 5%-
    send_notification
    ;;
esac
