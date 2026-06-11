local terminal = "kitty"
local launcher = "wofi --show drun"
local fileManager = " kitty --hold yazi"
local editor = "eclipse"
local browser = "zen-browser"
local activityManager = "kitty btop"
local music = "spotify-launcher"
local bluetooth = "kitty bluetui"
local wifi = "kitty impala"
local wallpaper_changer = "kitty change_wallpaper "

hl.bind("SUPER + return", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + ALT + return", hl.dsp.exec_cmd(terminal, {float = true, size = { 840, 500},center = true}))
hl.bind("SUPER + SHIFT + return", hl.dsp.exec_cmd("~/.config/hypr/open_partial_terminal.sh"))
hl.bind("SUPER + SHIFT + SPACE", hl.dsp.exec_cmd(launcher))
hl.bind("SUPER + d", hl.dsp.exec_cmd(fileManager, {float = true, size = { 1200, 600},center = true}))
hl.bind("SUPER + e", hl.dsp.exec_cmd(editor))
hl.bind("SUPER + w", hl.dsp.exec_cmd(browser))
hl.bind("CTRL + ALT + escape", hl.dsp.exec_cmd(activityManager, {float = true, size = { 1100, 700},move = {810, 40}}))
hl.bind("SUPER + m", hl.dsp.exec_cmd(music, {float = true, size = { 1820, 1100},center = true}))
hl.bind("SUPER + b", hl.dsp.exec_cmd(bluetooth, {float = true, size = { 1000, 600},center = true}))
hl.bind("SUPER + ALT + w", hl.dsp.exec_cmd(wifi, {float = true, size = { 1000, 600},center = true}))
hl.bind("SUPER + SHIFT + w", hl.dsp.exec_cmd(wallpaper_changer, {float = true, size = { 400, 450},move = {10, 40}}))

hl.bind("CTRL + ALT + r", hl.dsp.exec_cmd("~/.config/quickshell/reload_qs.sh"))

hl.bind("SUPER + p", hl.dsp.exec_cmd("playerctl play-pause"), {locked = true})
hl.bind("SUPER + n", hl.dsp.exec_cmd("playerctl next"), {locked = true})
hl.bind("SUPER + SHIFT + n", hl.dsp.exec_cmd("playerctl previous"), {locked = true})

hl.bind("print", hl.dsp.exec_cmd("hyprcap -n -z -c -t 2000 -o ~/Pictures/Screenshots/ shot region"))
hl.bind("SUPER + print", hl.dsp.exec_cmd("hyprcap -n -z -c -t 2000 -o ~/Pictures/Screenshots/ shot monitor:active"))
hl.bind("SUPER + SHIFT + r", hl.dsp.exec_cmd("hyprcap -n -z -c -t 2000 -o ~/Video/Captures rec monitor:active"))

hl.bind("SUPER + ALT + l", hl.dsp.exec_cmd("hyprlock"))

hl.bind("CTRL + ALT + p", hl.dsp.exec_cmd("shutdown now"))
