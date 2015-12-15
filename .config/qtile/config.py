from glob import glob
from random import choice
from time import sleep
import os
import subprocess
import platform
import re

from libqtile import layout, widget, bar, hook
from libqtile.widget import base
from libqtile.manager import Screen, Drag, Click
from libqtile.command import lazy
from libqtile.config import Key, Screen, Group, Drag, Click, Match


mod = "mod4"

def is_running(process):
    s = subprocess.Popen(["ps", "axuw"], stdout=subprocess.PIPE)
    for x in s.stdout:
        if re.search(process, x):
            return True
        return False

def execute_once(process):
    if not is_running(process):
        return subprocess.Popen(process.split())

@hook.subscribe.client_new
def dialogs(window):
    if(window.window.get_wm_type() == 'dialog'
            or window.window.get_wm_transient_for()):
        window.floating = True

keys = [
        Key([mod], "Right", lazy.group.nextgroup()),
        Key([mod], "Left", lazy.group.prevgroup()),

        Key(
            [mod], "t", lazy.spawn("thunar")),

        # Switch between windows in current stack pane
        Key(
            [mod], "k",
            lazy.layout.down()
            ),
        Key(
            [mod], "j",
            lazy.layout.up()
            ),
        # Move windows up or down in current stack
        Key(
            [mod, "control"], "k",
            lazy.layout.shuffle_down()
            ),
        Key(
            [mod, "control"], "j",
            lazy.layout.shuffle_up()
            ),
        # Switch window focus to other pane(s) of stack
        Key(
            [mod], "space",
            lazy.layout.next()
            ),
        # Swap panes of split stack
        Key(
            [mod, "shift"], "space",
            lazy.layout.rotate()
            ),
        Key(
            [mod, "shift"], "m",
            lazy.group.setlayout('floating')
            ),
        Key(
            [mod], "m",
            lazy.group.setlayout('stack')
            ),
        Key(
            [mod], "n",
            lazy.layout.normalize()
            ),
        Key(
            [mod, "shift"], "n",
            lazy.layout.maximize()
            ),
        # Toggle between split and unsplit sides of stack.
        # Split = all windows displayed
        # Unsplit = 1 window displayed, like Max layout, but still with
        # multiple stack panes
        Key(
            [mod, "shift"], "Return",
            lazy.layout.toggle_split()
            ),
        Key([mod], "Return", lazy.spawn("terminal")),
        # Toggle between different layouts as defined below
        Key([mod], "Tab", lazy.nextlayout()),
        Key([mod], "w", lazy.window.kill()),
        Key([mod, "control"], "r", lazy.restart()),
        Key([mod, "control"], "q", lazy.shutdown()),
        Key([mod], "r", lazy.spawn("dmenu_run")),
        Key([mod, "shift"], "r", lazy.spawncmd()),
        ]



groups = [Group("a"),
    Group('s', spawn='firefox-bin', layout='max',
        matches=[Match(wm_class=['Firefox', 'google-chrome', 'Google-chrome'])]),
    Group('d'), Group('f'),
    Group('u', matches=[Match(wm_class=['conky', 'Conky'])]),
    Group('i'), Group('o'), Group('p', matches=[Match(wm_class=['rhythmbox', 'Rhythmbox'])])]

lazy.group['f'].setlayout('floating')
auto_fullscreen = False


for i in ['a', 's', 'd', 'f', 'u', 'i', 'o', 'p']:

    # mod1 + letter of group = switch to group
    keys.append(
        Key([mod], i, lazy.group[i].toscreen())
            )
    # mod1 + shift + letter of group = switch to & move focused window to group
    keys.append(
            Key([mod, "shift"], i, lazy.window.togroup(i))
            )
    widget_defaults = dict(
            font='Arial',
            fontsize=16,
            padding=3,
            )
    screens = [
            Screen(
                bottom=bar.Bar(
                    [
                        #widget.GroupBox(),
                        widget.Prompt(),
                        # widget.WindowName(),
                        widget.TextBox(platform.node(), name="default"),
                        widget.Systray(),
                        widget.Clock(format='%Y-%m-%d %a %I:%M %p'),
                        ],
                    30,
                    ),
                ),
            ]
    # Drag floating layouts.
    mouse = [
            Drag([mod], "Button1", lazy.window.set_position_floating(),
                start=lazy.window.get_position()),
            Drag([mod], "Button3", lazy.window.set_size_floating(),
                start=lazy.window.get_size()),
            Click([mod], "Button2", lazy.window.bring_to_front())
            ]
    dgroups_key_binder = None
    dgroups_app_rules = []
    main = None
    follow_mouse_focus = True
    bring_front_click = False
    cursor_warp = False
    floating_layout = layout.Floating()
    auto_fullscreen = True
    wmname = "qtile"

@hook.subscribe.changegroup
def change_group():

    return 0

# start the applications at Qtile startup
@hook.subscribe.startup_once
def startup_once():
    subprocess.Popen(["nm-applet"])
    subprocess.Popen(["pnmixer"])
    subprocess.Popen(["gnome-terminal --hide-menubar"])
    subprocess.Popen(["conky -c ~/.Conky/rings"])
    subprocess.Popen(["xcompmgr"])
    subprocess.Popen(["firefox"])
