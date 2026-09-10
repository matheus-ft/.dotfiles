def widgets():
    sys_monitor_color = colors[0]
    sys_config_color = colors[0]
    return [
        widget.TextBox(
            text="",
            fontsize=12,
            mouse_callbacks={
                left_click: lambda: qtile.cmd_spawn(app_launcher),
                right_click: lambda: qtile.cmd_spawn(terminal),
            },
            decorations=[RectDecoration(colour=colors[2], radius=10, filled=True)],
            foreground=colors[0],
        ),
        widget.GroupBox(
            fontsize=14,
            disable_drag=True,
            invert_mouse_wheel=True,
            margin=2,
            padding=0,
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
            decorations=[RectDecoration(colour=colors[0], radius=10, filled=True)],
        ),
        widget.CurrentLayout(
            foreground=colors[0],
            decorations=[RectDecoration(colour=colors[2], radius=10, filled=True)],
        ),
        widget.TaskList(  # actually a list of open windows
            margin=0,
            icon_size=16,
            padding=1,
            borderwidth=0,
            txt_floating="🗗 ",
            txt_maximized="🗖 ",
            txt_minimized="🗕 ",
            decorations=[RectDecoration(colour=colors[0], radius=10, filled=True)],
        ),
        widget.Spacer(length=50),
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
                left_click: lazy.group["scratchpad"].dropdown_toggle("htop"),
            },
            format=" {load_percent}%",
            foreground=colors[4],
            decorations=[
                RectDecoration(
                    colour=sys_monitor_color, radius=[10, 0, 0, 10], filled=True
                )
            ],
        ),
        widget.ThermalSensor(
            foreground_alert=colors[9],
            threshold=75,
            fmt="🌡 {}",
            tag_sensor="Core 0",
            mouse_callbacks={
                left_click: lazy.group["scratchpad"].dropdown_toggle("htop")
            },
            decorations=[
                RectDecoration(colour=sys_monitor_color, radius=0, filled=True)
            ],
        ),
        widget.Memory(
            mouse_callbacks={
                left_click: lazy.group["scratchpad"].dropdown_toggle("htop"),
            },
            measure_mem="G",
            format="﬙ {MemUsed:.1f}{mm}/{MemTotal:.1f}{mm}",
            foreground=colors[8],
            decorations=[
                RectDecoration(
                    colour=sys_monitor_color, radius=[0, 10, 10, 0], filled=True
                )
            ],
        ),
        widget.KeyboardLayout(
            fmt=" {}",
            foreground=colors[4],
            decorations=[
                RectDecoration(
                    colour=sys_config_color, radius=[10, 0, 0, 10], filled=True
                )
            ],
        ),
        widget.Volume(
            fmt=" {}",
            padding=5,
            foreground=colors[7],
            decorations=[
                RectDecoration(colour=sys_config_color, radius=0, filled=True)
            ],
        ),
        widget.Backlight(
            fmt=" {}",
            backlight_name="intel_backlight",
            change_command=None,  # this just works with `brightnessctl` lol
            foreground=colors[10],
            decorations=[
                RectDecoration(colour=sys_config_color, radius=0, filled=True)
            ],
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
            decorations=[
                RectDecoration(
                    colour=sys_config_color, radius=[0, 10, 10, 0], filled=True
                )
            ],
        ),
        # widget.Systray(icon_size=12),
        widget.StatusNotifier(
            decorations=[
                RectDecoration(colour=sys_config_color, radius=10, filled=True)
            ],
        ),
        widget.Spacer(length=10),
    ]


