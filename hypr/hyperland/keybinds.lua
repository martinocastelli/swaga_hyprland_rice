hl.bind("SUPER + q", hl.dsp.window.close())
hl.bind("SUPER + SHIFT + q", hl.dsp.window.kill())

hl.bind("SUPER + ALT + space", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + t", hl.dsp.layout("togglesplit"))    -- dwindle only

hl.bind("SUPER + h", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + l", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + k", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + j", hl.dsp.focus({ direction = "down" }))

hl.bind("SUPER + SHIFT + h",  hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + SHIFT + l",  hl.dsp.window.move({ direction = "right" }))
hl.bind("SUPER + SHIFT + k",  hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + SHIFT + j",  hl.dsp.window.move({ direction = "down" }))

for i = 1, 9 do
	hl.bind("SUPER + " .. i, hl.dsp.focus({ workspace = i}))
	hl.bind("SUPER + ALT + " .. i, hl.dsp.window.move({ workspace = i }))
end
hl.bind("SUPER + CTRL + h", hl.dsp.focus({ workspace = "-1"}))
hl.bind("SUPER + CTRL + l", hl.dsp.focus({ workspace = "+1"}))
hl.bind("SUPER + tab", hl.dsp.focus({ last = true }))

hl.bind("SUPER + CTRL + SHIFT + h", hl.dsp.window.move({ workspace = "-1"}))
hl.bind("SUPER + CTRL + SHIFT + l", hl.dsp.window.move({ workspace = "+1"}))

hl.bind("SUPER + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind("SUPER + y", hl.dsp.window.drag(),   { mouse = true })
hl.bind("SUPER + x", hl.dsp.window.resize(), { mouse = true })
hl.bind("SUPER + f", hl.dsp.window.fullscreen({action = "toggle"}))

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

