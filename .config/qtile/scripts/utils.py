from Xlib import display as xdisplay


def show_keys(keys):
    """Print current keybindings in a pretty way for a rofi/dmenu window.

    Courtesy of LaurentOngaro
    (https://github.com/qtile/qtile/issues/1329)
    """
    key_help = ""
    keys_ignored = (
        "XF86AudioMute",
        "XF86AudioLowerVolume",
        "XF86AudioRaiseVolume",
        "XF86AudioPlay",
        "XF86AudioNext",
        "XF86AudioPrev",
        "XF86AudioStop",
        "XF86MonBrightnessDown",
        "XF86MonBrightnessUp",
    )
    text_replaced = {
        "mod4": "[Super]",
        "control": "[Ctrl]",
        "mod1": "[Alt]",
        "shift": "[Shift]",
        "twosuperior": "²",
        "less": "<",
        "ampersand": "&",
        "Escape": "Esc",
        "Return": "Enter",
    }
    for k in keys:
        if k.key in keys_ignored:
            continue

        mods = ""
        key = ""
        desc = k.desc.title()
        for m in k.modifiers:
            if m in text_replaced.keys():
                mods += text_replaced[m] + " + "
            else:
                mods += m.capitalize() + " + "

        if len(k.key) > 1:
            if k.key in text_replaced.keys():
                key = text_replaced[k.key]
            else:
                key = k.key.title()
        else:
            key = k.key

        key_line = "{:<30} {}".format(mods + key, desc + "\n")
        key_help += key_line
    return key_help


def get_num_monitors():
    """Get the number of monitors connected.

    https://github.com/qtile/qtile/wiki/screens#setup-multiple-screens-dynamically
    """
    num_monitors = 0
    try:
        display = xdisplay.Display()
        screen = display.screen()
        resources = screen.root.xrandr_get_screen_resources()

        for output in resources.outputs:
            monitor = display.xrandr_get_output_info(output, resources.config_timestamp)
            preferred = False
            if hasattr(monitor, "preferred"):
                preferred = monitor.preferred
            elif hasattr(monitor, "num_preferred"):
                preferred = monitor.num_preferred
            if preferred:
                num_monitors += 1
    except Exception as e:
        # always setup at least one monitor
        return 1
    else:
        return num_monitors
