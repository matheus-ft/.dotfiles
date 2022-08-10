import os
import socket
import subprocess
from libqtile import qtile
from libqtile.config import Click, Drag, Group, KeyChord, Key, Match, Screen
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.lazy import lazy
from typing import List
from libqtile.dgroups import simple_key_binder

super = "mod4"
alt = "mod1"
modkey = super
terminal = "kitty"
browser = "firefox"
app_launcher = "rofi -show drun"
run_prompt = "rofi -show run"
power_menu = "rofi -show p -modi p:rofi-power-menu"
window_switcher = "rofi -show windowcd"
workspace_switcher = "rofi -show window"
gui_file_manager = "nautilus"  # because I already had it

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
        lazy.layout.swap_left(),
        lazy.layout.shuffle_left(),
        desc="Move window to the left",
    ),
    Key(
        [modkey, "shift"],
        "l",
        lazy.layout.swap_right(),
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
    Key([modkey, "control"], "j", lazy.layout.grow_down(), desc="Grow pane downwards"),
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
    Key([modkey], "t", lazy.window.toggle_floating(), desc="Toggle tiling & floating"),
    Key([modkey, "shift"], "c", lazy.window.kill(), desc="Kill focused window"),
    ### Desktop controls
    Key(
        [modkey],
        "space",
        lazy.widget["keyboardlayout"].next_keyboard(),
        desc="Next keyboard layout.",
    ),
    Key(
        [],
        "XF86MonBrightnessUp",
        lazy.spawn("brightnessctl s +5%"),
        desc="Increase brightness",
    ),
    Key(
        [],
        "XF86MonBrightnessDown",
        lazy.spawn("brightnessctl s 5%-", desc="Decrease brightness"),
    ),
    Key([], "XF86AudioMute", lazy.spawn("amixer -q sset Master 0%")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -q sset Master 5%+")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -q sset Master 5%-")),
    ### App launchers
    Key([modkey], "b", lazy.spawn(browser), desc="Launch browser"),
    Key([modkey], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key(
        [modkey, "shift"],
        "Return",
        lazy.spawn(app_launcher),
        desc="Open app launcher",
    ),
    Key([modkey], "r", lazy.spawn(run_prompt), desc="Launch run prompt"),
    Key(
        [modkey],
        "f",
        lazy.spawn(gui_file_manager),
        desc="Open graphical file manager",
    ),
    Key([alt], "Tab", lazy.spawn(window_switcher), desc="Launch window switcher"),
    Key(
        [alt, "shift"],
        "Tab",
        lazy.spawn(workspace_switcher),
        desc="Launch workspace switcher",
    ),
    ### Qtile controls
    Key([modkey], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([modkey, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([modkey, "shift"], "r", lazy.restart(), desc="Restart Qtile"),
    # Key([modkey, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([modkey, "shift"], "q", lazy.spawn(power_menu), desc="Show power menu"),
]

# Allow MODKEY+[1 through 8] to bind to groups, see https://docs.qtile.org/en/stable/manual/config/groups.html
# MODKEY + index Number : Switch to Group[index]
# MODKEY + shift + index Number : Send active window to Group[index]
dgroups_key_binder = simple_key_binder(modkey)

mouse = [
    Drag(
        [modkey],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [modkey],
        "Button3",
        lazy.window.set_size_floating(),
        start=lazy.window.get_size(),
    ),
    Click([modkey], "Button2", lazy.window.bring_to_front()),
]

colors = {
    "black": "#282c34",
    "red": "#e06c75",
    "green": "#98c379",
    "yellow": "#e5c07b",
    "blue": "#61afef",
    "magenta": "#be5046",
    "cyan": "#56b6c2",
    "white": "#e6e6e6",
    "light_grey": "#abb2bf",
    "dark_grey": "#393e48",
    "orange": "#d19a66",
    "purple": "#c678dd",
}

layout_theme = {
    "border_width": 2,
    "margin": 4,
    "border_focus": colors["purple"],
    "border_normal": colors["dark_grey"],
    "border_focus_stack": colors["cyan"],
    "border_normal_stack": colors["dark_grey"],
}

layouts = [
    layout.MonadTall(**layout_theme),
    layout.Columns(**layout_theme, insert_position=1),
    layout.Max(**layout_theme),
    layout.Floating(**layout_theme),
]

groups = [
    Group("", layout="monadtall"),
    Group("", layout="monadtall"),
    Group("拾", layout="monadtall"),
    Group("", layout="monadtall"),
    Group("", layout="max"),
    Group("辶", layout="max", matches=[Match(wm_class="zoom")]),
    Group("", layout="floating"),
    Group("", layout="monadtall"),
]

prompt = f"{os.environ['USER']}@{socket.gethostname()}: "

##### DEFAULT WIDGET SETTINGS #####
widget_defaults = dict(
    font="JetBrainsMono Nerd Font",
    fontsize=12,
    padding=6,
    background=colors["black"],
    foreground=colors["white"],
)
extension_defaults = widget_defaults.copy()


def panel_widgets():
    return [
        widget.Sep(linewidth=0),
        widget.Image(
            filename="~/.config/qtile/icons/python.png",
            scale="True",
            mouse_callbacks={
                "Button1": lambda: qtile.cmd_spawn(app_launcher),
                "Button3": lambda: qtile.cmd_spawn(terminal),
            },
        ),
        widget.Sep(linewidth=0),
        widget.GroupBox(
            fontsize=14,
            disable_drag=True,
            invert_mouse_wheel=True,
            margin=2,
            padding=0,
            rounded=True,
            ###
            # # design 1 #
            # highlight_method="text",
            # active=colors["white"],
            # inactive=colors["dark_grey"],
            # this_current_screen_border=colors["purple"],
            ###
            # design 2 #
            highlight_method="line",
            highlight_color=colors["black"],
            # marks in the current screen's panel
            this_current_screen_border=colors["blue"],
            other_screen_border=colors["yellow"],
            # marks in the other screens' panel
            other_current_screen_border=colors["magenta"],
            this_screen_border=colors["green"],
        ),
        widget.Sep(linewidth=1),
        widget.CurrentLayout(),
        widget.Sep(linewidth=1),
        widget.WindowName(foreground=colors["cyan"]),
        widget.Spacer(lenght=1),  # this way the clock gets centralized
        widget.Clock(
            format="%a, %b %d - %H:%M ",
            padding=3,
            mouse_callbacks={
                "Button1": lambda: qtile.cmd_spawn(
                    browser + " https://calendar.google.com/calendar/u/0/r"
                )
            },
        ),
        widget.Spacer(lenght=1),
        widget.CPU(
            foreground=colors["green"],
            mouse_callbacks={
                "Button1": lambda: qtile.cmd_spawn(terminal + " -e htop"),
            },
            format=" {load_percent}%",
        ),
        widget.Sep(linewidth=1),
        widget.ThermalSensor(
            foreground=colors["white"],
            foreground_alert=colors["red"],
            threshold=80,
            fmt="🌡 {}",
            tag_sensor="Core 0",
            mouse_callbacks={"Button1": lambda: qtile.cmd_spawn(terminal + " -e htop")},
        ),
        widget.Sep(linewidth=1),
        widget.Memory(
            foreground=colors["blue"],
            mouse_callbacks={"Button1": lambda: qtile.cmd_spawn(terminal + " -e htop")},
            measure_mem="G",
            format="﬙ {MemUsed:.2f}{mm}/{MemTotal:.1f}{mm}",
        ),
        widget.Sep(linewidth=1),
        widget.KeyboardLayout(
            foreground=colors["cyan"],
            fmt=" {}",
            configured_layouts=["us", "br"],  # but this sh*t doesn't work
        ),
        widget.Sep(linewidth=1),
        widget.Volume(foreground=colors["purple"], fmt=" {}", padding=5),
        widget.Sep(linewidth=1),
        widget.Backlight(
            foreground=colors["yellow"],
            fmt=" {}",
            backlight_name="intel_backlight",
            change_command=None,  # this just works with `brightnessctl` lol
        ),
        widget.Sep(linewidth=1),
        widget.Battery(
            foreground=colors["green"],
            low_foreground=colors["orange"],
            format="{char}{percent:2.0%}",
            charge_char=" ",
            discharge_char=" ",
            empty_char=" ",
            full_char=" ",
            unknown_char=" ",
            low_percentage=0.15,
            show_short_text=False,
            notify_below=15,
        ),
        widget.Sep(linewidth=1),
        widget.Systray(
            icon_size=12,
        ),
        widget.Sep(linewidth=0),
    ]


def panel_without_systray():
    no_systray = panel_widgets()[:-2]
    no_systray.append(
        widget.Wlan(
            format=" {essid} {percent:2.0%}",
            interface="wlo1",
        ),
    )
    return no_systray


def init_screens():
    return [
        Screen(top=bar.Bar(widgets=panel_widgets(), opacity=1.0, size=20)),
        Screen(top=bar.Bar(widgets=panel_without_systray(), opacity=1.0, size=20)),
    ]


screens = init_screens()

dgroups_app_rules: List = []
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
    ]
)


@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser("~")
    subprocess.run([home + "/.config/qtile/autostart.sh"])


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
