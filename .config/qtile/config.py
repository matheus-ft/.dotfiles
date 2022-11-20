import os
import socket
import subprocess
from typing import List
from libqtile import qtile
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
from libqtile import layout, bar, hook
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
app_launcher = "rofi -show drun"
run_prompt = "rofi -show run"
power_menu = "rofi -show p -modi p:rofi-power-menu"
window_switcher = "rofi -show windowcd"
workspace_switcher = "rofi -show window"
gui_file_manager = "nautilus"  # because I already had it
screen_locker = "i3lock-custom"  # funny, isn't it? --- looks good enough
keyboard_toggler = "toggle_keyboard_layout"
clipboard_history = "copyq menu"

HOME = os.path.expanduser("~")
scripts = f"{HOME}/.config/qtile/scripts"
brightness_up = f"bash {scripts}/brightness.sh up"
brightness_down = f"bash {scripts}/brightness.sh down"
volume_up = f"bash {scripts}/volume.sh up"
volume_down = f"bash {scripts}/volume.sh down"
volume_mute = f"bash {scripts}/volume.sh mute"


keys = [
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
        lazy.layout.swap_left(),  # monadtall
        lazy.layout.shuffle_left(),  # columns
        desc="Move window to the left",
    ),
    Key(
        [modkey, "shift"],
        "l",
        lazy.layout.swap_right(),  # monadtall
        lazy.layout.shuffle_right(),  # columns
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
        lazy.layout.shrink_main(),  # monadtall
        lazy.layout.grow_left(),  # columns
        desc="Grow pane to the left",
    ),
    Key(
        [modkey, "control"],
        "l",
        lazy.layout.grow_main(),  # monadtall
        lazy.layout.grow_right(),  # columns
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
        lazy.layout.flip(),  # monadtall
        lazy.layout.swap_column_left(),  # using only two columns, this works for both panes
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
    Key([alt], "F11", lazy.spawn(brightness_down)),
    Key([alt], "F12", lazy.spawn(brightness_up)),
    Key([alt], "F1", lazy.spawn(volume_mute)),
    Key([alt], "F2", lazy.spawn(volume_down)),
    Key([alt], "F3", lazy.spawn(volume_up)),
    ### App launchers
    Key([modkey], "b", lazy.spawn(browser), desc="Launch browser"),
    Key([modkey], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key(
        [modkey, "shift"],
        "Return",
        lazy.spawn(run_prompt),
        desc="Launch run prompt",
    ),
    Key([modkey], "r", lazy.spawn(app_launcher), desc="Open app launcher"),
    Key(
        [modkey],
        "f",
        lazy.spawn(gui_file_manager),
        desc="Open graphical file manager",
    ),
    Key([alt], "Tab", lazy.spawn(window_switcher), desc="Launch window switcher"),
    Key(
        [super],
        "Tab",
        lazy.spawn(workspace_switcher),
        desc="Launch workspace switcher",
    ),
    Key([modkey], "v", lazy.spawn(clipboard_history), desc="Shows clipboard history"),
    ### Qtile controls
    Key([modkey], "w", lazy.next_layout(), desc="Toggle between layouts"),
    Key([modkey, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([modkey, "shift"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([modkey, "shift"], "q", lazy.spawn(power_menu), desc="Show power menu"),
    Key([modkey], "q", lazy.spawn(screen_locker), desc="Lock screen"),
]

mouse = [
    Drag(
        [modkey],
        left_click,
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [modkey],
        right_click,
        lazy.window.set_size_floating(),
        start=lazy.window.get_size(),
    ),
    Click([modkey], middle_click, lazy.window.bring_to_front()),
]

colors = colorscheme.onedark()

layout_theme = {
    "border_width": 2,
    "margin": 4,
    "border_focus": colors["purple"],
    "border_normal": colors["dark_grey"],
    "border_focus_stack": colors["cyan"],
    "border_normal_stack": colors["dark_grey"],
}

layouts = [
    layout.Columns(**layout_theme, insert_position=1),
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
    layout.Floating(**layout_theme),
]

groups = [
    Group(name="1", label="", layout="columns"),
    Group(name="2", label="", layout="columns"),
    Group(name="3", label="拾", layout="columns"),
    Group(name="4", label="", layout="columns"),
    Group(name="5", label="", layout="max", matches=[Match(wm_class="Wfica")]),
    Group(name="6", label="辶", layout="max", matches=[Match(wm_class="zoom")]),
    Group(name="7", label="", layout="floating"),
    Group(name="8", label="", layout="columns"),
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

groups.append(
    ScratchPad(
        "scratchpad",
        [
            DropDown("terminal 0", terminal),
            DropDown("terminal 1", terminal),
            DropDown("terminal 2", terminal),
            DropDown("terminal 3", terminal),
        ],
    ),
)

keys.extend(
    [
        Key(
            [super],
            "F10",
            lazy.group["scratchpad"].dropdown_toggle("terminal 0"),
            desc="Dropdown terminal",
        ),
        Key(
            [super],
            "F11",
            lazy.group["scratchpad"].dropdown_toggle("terminal 1"),
            desc="Dropdown terminal",
        ),
        Key(
            [super],
            "F12",
            lazy.group["scratchpad"].dropdown_toggle("terminal 2"),
            desc="Dropdown terminal",
        ),
        Key(
            [super, alt],
            "Return",
            lazy.group["scratchpad"].dropdown_toggle("terminal 3"),
            desc="Dropdown terminal",
        ),
    ]
)

keys.append(
    Key(
        [modkey],
        "F1",
        lazy.spawn(
            "sh -c 'echo \""
            + show_keys(keys)
            + '" | rofi -dmenu -i -mesg "Keyboard shortcuts"\''
        ),
        desc="Show keybindings",
    )
)

prompt = f"{os.environ['USER']}@{socket.gethostname()}: "  # actually useless

widget_defaults = dict(
    font="JetBrainsMono Nerd Font",
    fontsize=12,
    padding=6,
    background=colors["white"] + "00",  # transparent
)
extension_defaults = widget_defaults.copy()


def widgets():
    sys_monitor_color = colors["dark_grey"]
    sys_configs_color = colors["dark_grey"]
    return [
        widget.TextBox(
            text="",
            foreground=colors["black"],
            fontsize=12,
            mouse_callbacks={
                left_click: lambda: qtile.cmd_spawn(app_launcher),
                right_click: lambda: qtile.cmd_spawn(terminal),
            },
            decorations=[
                RectDecoration(colour=colors["light_grey"], radius=10, filled=True)
            ],
        ),
        widget.GroupBox(
            fontsize=14,
            disable_drag=True,
            invert_mouse_wheel=True,
            margin=2,
            padding=0,
            rounded=True,
            active=colors["white"],
            inactive=colors["grey"],
            highlight_method="line",
            highlight_color=colors["dark_grey"],
            # marks in the current screen's panel
            this_current_screen_border=colors["blue"],
            other_screen_border=colors["yellow"],
            # marks in the other screens' panel
            other_current_screen_border=colors["magenta"],
            this_screen_border=colors["green"],
            decorations=[
                RectDecoration(colour=colors["dark_grey"], radius=10, filled=True)
            ],
        ),
        widget.CurrentLayout(
            foreground=colors["black"],
            decorations=[
                RectDecoration(colour=colors["light_grey"], radius=10, filled=True)
            ],
        ),
        widget.TaskList(
            margin=0,
            icon_size=16,
            padding=1,
            borderwidth=0,
            decorations=[
                RectDecoration(colour=colors["dark_grey"], radius=10, filled=True)
            ],
        ),
        widget.Spacer(lenght=bar.STRETCH),
        widget.Clock(
            format="%a, %b %d - %H:%M ",
            padding=3,
            mouse_callbacks={
                left_click: lambda: qtile.cmd_spawn(
                    browser + " https://calendar.google.com/calendar/u/0/r"
                ),
            },
            foreground=colors["white"],
            decorations=[
                RectDecoration(colour=colors["dark_grey"], radius=10, filled=True)
            ],
        ),
        widget.Spacer(lenght=bar.STRETCH),
        widget.WidgetBox(
            close_button_location="right",
            text_closed="  ",
            text_open="  ",
            widgets=[widget.Systray(icon_size=12)],
        ),
        widget.CPU(
            mouse_callbacks={
                left_click: lambda: qtile.cmd_spawn(terminal + " -e htop"),
            },
            format=" {load_percent}%",
            foreground=colors["blue"],
            decorations=[
                RectDecoration(
                    colour=sys_monitor_color, radius=[10, 0, 0, 10], filled=True
                )
            ],
        ),
        widget.ThermalSensor(
            foreground_alert=colors["magenta"],
            threshold=75,
            fmt="🌡 {}",
            tag_sensor="Core 0",
            mouse_callbacks={
                left_click: lambda: qtile.cmd_spawn(terminal + " -e htop")
            },
            decorations=[
                RectDecoration(colour=sys_monitor_color, radius=0, filled=True)
            ],
        ),
        widget.Memory(
            mouse_callbacks={
                left_click: lambda: qtile.cmd_spawn(terminal + " -e htop")
            },
            measure_mem="G",
            format="﬙ {MemUsed:.2f}{mm}/{MemTotal:.1f}{mm}",
            foreground=colors["green"],
            decorations=[
                RectDecoration(
                    colour=sys_monitor_color, radius=[0, 10, 10, 0], filled=True
                )
            ],
        ),
        widget.KeyboardLayout(
            fmt=" {}",
            foreground=colors["cyan"],
            decorations=[
                RectDecoration(
                    colour=sys_configs_color, radius=[10, 0, 0, 10], filled=True
                )
            ],
        ),
        widget.Volume(
            fmt=" {}",
            padding=5,
            foreground=colors["purple"],
            decorations=[
                RectDecoration(colour=sys_configs_color, radius=0, filled=True)
            ],
        ),
        widget.Backlight(
            fmt=" {}",
            backlight_name="intel_backlight",
            change_command=None,  # this just works with `brightnessctl` lol
            foreground=colors["yellow"],
            decorations=[
                RectDecoration(colour=sys_configs_color, radius=0, filled=True)
            ],
        ),
        widget.Battery(
            foreground=colors["green"],
            low_foreground=colors["red"],
            format="{char}{percent:2.0%}",
            charge_char=" ",
            discharge_char=" ",
            empty_char=" ",
            full_char=" ",
            unknown_char=" ",
            low_percentage=0.35,
            show_short_text=False,
            notify_below=35,
            decorations=[
                RectDecoration(colour=sys_configs_color, radius=0, filled=True)
            ],
        ),
        # widget.StatusNotifier(),
    ]


def main_panel():
    return Screen(top=bar.Bar(widgets(), size=20, background=colors["white"] + "00"))


def panel():
    no_systray = widgets()
    del no_systray[7]
    return Screen(top=bar.Bar(no_systray, size=18, background=colors["white"] + "00"))


screens = [main_panel()]
n_monitors = get_num_monitors()
if n_monitors == 2:
    screens = [panel(), main_panel()]


dgroups_app_rules: List = []  # this type hint is mandatory!
follow_mouse_focus = True
bring_front_click = False
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
        Match(title="Qalculate!"),  # qalculate-gtk
        Match(wm_class="kdenlive"),  # kdenlive
        Match(wm_class="pinentry-gtk-2"),  # GPG key password entry
        Match(wm_class="zoom"),  # bc it is a pain - shows notifications as windows
        Match(wm_class="copyq"),
    ]
)


@hook.subscribe.startup_once
def start_once():
    subprocess.run([f"{HOME}/.config/qtile/scripts/autostart.sh"])


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
