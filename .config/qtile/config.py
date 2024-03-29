import os
import socket
import subprocess
from typing import List
from libqtile import qtile, layout, bar, hook
from libqtile.config import (
    Click,
    Drag,
    DropDown,
    Group,
    KeyChord,
    Key,
    Match,
    ScratchPad,
    Screen,
)
from libqtile.lazy import lazy
from qtile_extras import widget
from qtile_extras.widget.decorations import RectDecoration
from scripts import colorscheme
from scripts.utils import show_keys, get_num_monitors


# keys
modkey = super = "mod4"  # check `xmodmap`
alt = "mod1"
left_click = "Button1"
middle_click = "Button2"
right_click = "Button3"


# apps
terminal = "kitty"
browser = "firefox"
app_launcher = "rofi -show drun -show-icons"
run_prompt = "rofi -show run"
power_menu = "rofi -show p -modi p:rofi-power-menu"
window_switcher = "rofi -show window"
gui_file_manager = "nautilus"
screen_locker = "i3lock-custom"  # funny, isn't it? --- looks good enough
keyboard_toggler = "toggle_keyboard_layout"
clipboard_history = "copyq menu"
vim = terminal + " -e /home/matheus/.local/share/bob/nvim-bin/nvim"
screenshooter = "flameshot gui"
sys_monitor = "bashtop"

HOME = os.path.expanduser("~")
scripts = f"{HOME}/.config/qtile/scripts"
brightness_up = f"bash {scripts}/brightness.sh up"
brightness_down = f"bash {scripts}/brightness.sh down"
volume_up = f"bash {scripts}/volume.sh up"
volume_down = f"bash {scripts}/volume.sh down"
volume_mute = f"bash {scripts}/volume.sh mute"


keys: list[Key | KeyChord] = [
    ### Window controls
    Key([modkey], "period", lazy.next_screen(), desc="Move focus to next monitor"),
    Key([modkey], "comma", lazy.prev_screen(), desc="Move focus to previous monitor"),
    Key([modkey], "semicolon", lazy.layout.next(), desc="Move focus to next window"),
    Key([modkey], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([modkey], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([modkey], "j", lazy.layout.down(), desc="Move focus down"),
    Key([modkey], "k", lazy.layout.up(), desc="Move focus up"),
    Key(
        [modkey, "shift"],
        "h",
        lazy.layout.shuffle_left(),
        desc="Move window to the left",
    ),
    Key(
        [modkey, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key(
        [modkey, "shift"],
        "j",
        lazy.layout.shuffle_down(),
        desc="Move window down",
    ),
    Key(
        [modkey, "shift"],
        "k",
        lazy.layout.shuffle_up(),
        desc="Move window up",
    ),
    Key(
        [modkey, "control"],
        "h",
        lazy.layout.grow_left(),
        desc="Grow pane to the left",
    ),
    Key(
        [modkey, "control"],
        "l",
        lazy.layout.grow_right(),
        desc="Grow pane to the right",
    ),
    Key(
        [modkey, "control"],
        "j",
        lazy.layout.grow_down(),
        desc="Grow pane downwards",
    ),
    Key([modkey, "control"], "k", lazy.layout.grow_up(), desc="Grow pane upwards"),
    Key([modkey], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key(
        [modkey],
        "m",
        lazy.layout.maximize(),
        desc="Toggle window between minimum and maximum sizes",
    ),
    Key(
        [modkey, "shift"],
        "space",
        lazy.layout.swap_column_left(),
        desc="Switch which side current pane occupies",
    ),
    Key(
        [modkey],
        "s",
        lazy.layout.toggle_split(),
        desc="Toggle stack/tab mode (Columns)",
    ),
    Key(
        [modkey, "shift"],
        "m",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen",
    ),
    Key(
        [modkey],
        "t",
        lazy.window.toggle_floating(),
        desc="Toggle tiling & floating",
    ),
    Key([modkey, "shift"], "c", lazy.window.kill(), desc="Kill focused window"),
    ### Desktop controls
    Key(
        [modkey],
        "space",
        lazy.spawn(keyboard_toggler),
        desc="Next keyboard layout",
    ),
    Key([], "XF86MonBrightnessDown", lazy.spawn(brightness_down)),
    Key([], "XF86MonBrightnessUp", lazy.spawn(brightness_up)),
    Key([], "XF86AudioMute", lazy.spawn(volume_mute)),
    Key([], "XF86AudioLowerVolume", lazy.spawn(volume_down)),
    Key([], "XF86AudioRaiseVolume", lazy.spawn(volume_up)),
    ### App launchers
    Key([modkey], "b", lazy.spawn(browser), desc="Launch browser"),
    Key([modkey], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key(
        [modkey, "shift"],
        "Return",
        lazy.spawn(run_prompt),
        desc="Launch run prompt",
    ),
    Key([modkey], "p", lazy.spawn(app_launcher), desc="Open app launcher"),
    Key(
        [modkey],
        "f",
        lazy.spawn(gui_file_manager),
        desc="Open graphical file manager",
    ),
    Key([modkey], "Tab", lazy.spawn(window_switcher), desc="Window switcher"),
    Key(
        [modkey, "shift"],
        "v",
        lazy.spawn(clipboard_history),
        desc="Shows clipboard history",
    ),
    Key([], "Print", lazy.spawn(screenshooter), desc="Take screenshot"),
    ### Qtile controls
    Key([modkey], "w", lazy.next_layout(), desc="Toggle between layouts"),
    Key([modkey, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([modkey, "shift"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([modkey, "shift"], "q", lazy.spawn(power_menu), desc="Show power menu"),
    Key([modkey], "q", lazy.spawn(screen_locker), desc="Lock screen"),
    Key(
        [modkey, "control"],
        "q",
        lazy.spawn("gnome-session-quit --logout"),
        desc="Log out of GNOME",
    ),
]

mouse = [
    Drag(
        [modkey],
        left_click,
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Click([modkey], middle_click, lazy.window.bring_to_front()),
    Drag(
        [modkey],
        right_click,
        lazy.window.set_size_floating(),
        start=lazy.window.get_size(),
    ),
]

colors = colorscheme.onedark()
BACKGROUND = colors[0]
FOREGROUND = colors[2]

layout_theme = {
    "border_focus": colors[8],
    "border_normal": colors[0],
    "border_width": 2,
}

layouts = [
    layout.Columns(
        **layout_theme,
        insert_position=1,
        border_on_single=True,
        margin=[8, 4, 8, 4],
        border_focus_stack=colors[4],
        border_normal_stack=colors[0],
    ),
    # layout.MonadThreeCol(**layout_theme, new_client_position="bottom"),
    layout.Max(**layout_theme),
    layout.Floating(**layout_theme, max_border_width=2),
]

groups = [
    Group(name="1", label="", layout="columns"),
    Group(name="2", label="", layout="columns"),
    Group(name="3", label="", layout="columns"),
    Group(name="4", label="拾", layout="columns"),
    Group(name="5", label="", layout="max", matches=[Match(wm_class="Wfica")]),
    Group(name="6", label="辶", layout="floating", matches=[Match(wm_class="zoom")]),
    Group(name="7", label="", layout="max"),
    Group(name="8", label="", layout="columns", matches=[Match(wm_class="discord")]),
    Group(name="9", label="", layout="columns"),
]

for workspace in groups:
    keys.extend(
        [
            Key(
                [modkey],
                workspace.name,
                lazy.group[workspace.name].toscreen(),
                desc=f"Move to workspace {workspace.name}",
            ),
            Key(
                [modkey, "shift"],
                workspace.name,
                lazy.window.togroup(workspace.name),
                desc=f"Move focused window to workspace {workspace.name}",
            ),
        ]
    )

popup_config = dict(width=0.5, height=0.7, x=0.25, y=0.1, opacity=0.9)

dropdown_wide = dict(
    width=0.67, height=0.4, x=0.16, y=0, opacity=0.9, on_focus_lost_hide=False
)

drop_sys_mon = dict(width=0.8, height=0.75, x=0.1, y=0, opacity=1)

dropdown_tall = dict(
    width=0.42, height=0.75, x=0.29, y=0, opacity=1, on_focus_lost_hide=False
)

groups.append(
    ScratchPad(
        "scratchpad",
        [
            DropDown("terminal 0", terminal, **dropdown_wide),
            DropDown("terminal 1", terminal, **dropdown_wide),
            DropDown("terminal 2", terminal, **dropdown_wide),
            DropDown("terminal 3", terminal, **dropdown_wide),
            DropDown("terminal center", terminal, **popup_config),
            DropDown("sys monitor", terminal + " -e " + sys_monitor, **drop_sys_mon),
            DropDown("calendar", terminal + " -e calcurse", **dropdown_tall),
            DropDown("notes", vim + " -c :VimwikiIndex", **popup_config),
        ],
    ),
)

keys.extend(
    [
        Key(
            [modkey],
            "F10",
            lazy.group["scratchpad"].dropdown_toggle("terminal 0"),
            desc="Dropdown terminal",
        ),
        Key(
            [modkey],
            "F11",
            lazy.group["scratchpad"].dropdown_toggle("terminal 1"),
            desc="Dropdown terminal",
        ),
        Key(
            [modkey],
            "F12",
            lazy.group["scratchpad"].dropdown_toggle("terminal 2"),
            desc="Dropdown terminal",
        ),
        Key(
            [super, alt],
            "Return",
            lazy.group["scratchpad"].dropdown_toggle("terminal center"),
            desc="Pop-up terminal",
        ),
        Key(
            [modkey],
            "F4",
            lazy.group["scratchpad"].dropdown_toggle("calendar"),
            desc="Dropdown calendar",
        ),
        Key(
            [modkey],
            "F9",
            lazy.group["scratchpad"].dropdown_toggle("notes"),
            desc="Notepad pop-up",
        ),
        Key(
            [modkey],
            "F3",
            lazy.group["scratchpad"].dropdown_toggle("sys monitor"),
            desc="System monitor",
        ),
    ]
)

keys.append(Key([modkey], "F1", lazy.spawn(), desc="Show keybindings"))
keys.append(
    Key(
        [modkey],
        "F1",
        lazy.spawn(
            "sh -c 'echo \""
            + show_keys(keys)
            + '" | rofi -dmenu -i -mesg "Keyboard shortcuts"\''
        ),
    )
)

prompt = f"{os.environ['USER']}@{socket.gethostname()}: "  # actually useless

widget_defaults = dict(
    font="JetBrains Mono Nerd Font",
    fontsize=13,
    padding=6,
    background="#ffffff" + "00",  # transparent
)
extension_defaults = widget_defaults.copy()


def widgets():
    return [
        widget.TextBox(
            text="  ",
            mouse_callbacks={
                left_click: lambda: qtile.cmd_spawn(app_launcher),
                right_click: lazy.group["scratchpad"].dropdown_toggle("terminal 3"),
            },
            decorations=[RectDecoration(colour=colors[0], radius=10, filled=True)],
            foreground=colors[2],
        ),
        widget.GroupBox(
            invert_mouse_wheel=True,
            margin=2,
            padding=1,
            rounded=True,
            active=colors[4],
            inactive=colors[1],
            highlight_method="line",
            highlight_color=BACKGROUND,
            # marks in the current screen's panel
            this_current_screen_border=colors[4],
            other_screen_border=colors[10],
            # marks in the other screens' panel
            other_current_screen_border=colors[9],
            this_screen_border=colors[5],
            decorations=[RectDecoration(colour=BACKGROUND, radius=4, filled=True)],
        ),
        widget.CurrentLayout(
            foreground=colors[0],
            decorations=[RectDecoration(colour=colors[8], radius=10, filled=True)],
        ),
        widget.TaskList(  # list of open windows
            margin=0,
            icon_size=16,
            padding=1,
            borderwidth=0,
            txt_floating="🗗 ",
            txt_maximized="🗖 ",
            txt_minimized="🗕 ",
            decorations=[RectDecoration(colour=colors[0], radius=4, filled=True)],
        ),
        widget.Spacer(length=bar.STRETCH),
        widget.Clock(
            format=" %a, %b %d - %H:%M ",
            mouse_callbacks={
                left_click: lazy.group["scratchpad"].dropdown_toggle("calendar"),
            },
            foreground=colors[0],
            decorations=[RectDecoration(colour=colors[2], radius=10, filled=True)],
        ),
        widget.Spacer(length=bar.STRETCH),
        widget.CPU(
            mouse_callbacks={
                left_click: lazy.group["scratchpad"].dropdown_toggle("sys monitor"),
            },
            format=" {load_percent:.0f}%",
            foreground=colors[0],
            decorations=[RectDecoration(colour=colors[4], radius=10, filled=True)],
        ),
        widget.ThermalSensor(
            foreground_alert=colors[9],
            threshold=75,
            format="🌡 {temp:.0f}{unit}",
            tag_sensor="Package id 0",  # this is to get the overall temperature
            mouse_callbacks={
                left_click: lazy.group["scratchpad"].dropdown_toggle("sys monitor")
            },
            decorations=[RectDecoration(colour=BACKGROUND, radius=10, filled=True)],
        ),
        widget.Memory(
            mouse_callbacks={
                left_click: lazy.group["scratchpad"].dropdown_toggle("sys monitor"),
            },
            measure_mem="G",
            format="﬙ {MemUsed:.1f}{mm}b",
            foreground=BACKGROUND,
            decorations=[RectDecoration(colour=colors[5], radius=10, filled=True)],
        ),
        widget.KeyboardLayout(
            fmt=" {}",
            foreground=colors[2],
            decorations=[RectDecoration(colour=colors[3], radius=10, filled=True)],
        ),
        widget.Backlight(
            fmt=" {}",
            backlight_name="intel_backlight",
            change_command=None,  # this just works with `brightnessctl` lol
            foreground=colors[0],
            decorations=[RectDecoration(colour=colors[10], radius=10, filled=True)],
        ),
        widget.Volume(
            fmt=" {}",
            padding=5,
            foreground=colors[0],
            decorations=[RectDecoration(colour=colors[8], radius=10, filled=True)],
        ),
        widget.Battery(
            foreground=colors[5],
            low_foreground=colors[9],
            format="{char}{percent:2.0%}",
            charge_char=" ",
            discharge_char=" ",
            empty_char=" ",
            full_char=" ",
            unknown_char=" ",
            low_percentage=0.35,
            show_short_text=False,
            notify_below=35,
            decorations=[RectDecoration(colour=BACKGROUND, radius=10, filled=True)],
        ),
        # widget.StatusNotifier(
        #     decorations=[RectDecoration(colour=colors[1], radius=10, filled=True)],
        # ),
        widget.Systray(),
        widget.Spacer(length=10),
    ]


panel_settings = dict(
    size=20,
    # background=BACKGROUND,
    background="#ffffff" + "00",
    opacity=0.95,
    margin=[4, 6, 0, 6],
)


def main_panel():
    return Screen(top=bar.Bar(widgets(), **panel_settings))


def panel():
    no_systray = widgets()
    del no_systray[-2]
    return Screen(top=bar.Bar(no_systray, **panel_settings))


screens = [main_panel()]
if get_num_monitors() == 2:
    screens = [panel(), main_panel()]


dgroups_app_rules: List = []  # this type hint is mandatory!
follow_mouse_focus = True
bring_front_click = True
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        # default_float_rules include: utility, notification, toolbar, splash, dialog,
        # file_progress, confirm, download and error.
        *layout.Floating.default_float_rules,
        Match(title="Confirmation"),  # tastyworks exit box
        Match(wm_class="gnome-calculator"),
        Match(wm_class="kdenlive"),
        Match(wm_class="pinentry-gtk-2"),  # GPG key password entry
        Match(wm_class="copyq"),
        Match(wm_class="kdeconnect-app"),
        Match(wm_class="blueman-manager"),
        Match(wm_class="blueman-services"),
        Match(wm_class="nm-connection-editor"),
    ]
)


@hook.subscribe.startup_once
def start_once():
    subprocess.run([f"{HOME}/.config/qtile/scripts/autostart.sh"])


@hook.subscribe.startup
def dbus_register():
    id = os.environ.get("DESKTOP_AUTOSTART_ID")
    if not id:
        return
    subprocess.Popen(
        [
            "dbus-send",
            "--session",
            "--print-reply",
            "--dest=org.gnome.SessionManager",
            "/org/gnome/SessionManager",
            "org.gnome.SessionManager.RegisterClient",
            "string:qtile",
            "string:" + id,
        ]
    )


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
