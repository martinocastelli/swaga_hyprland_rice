hl.config({
	input = {
		kb_layout  = "ch",
		follow_mouse = 1,
		touchpad = {
			natural_scroll = true,
		},
	},
	misc = {
		force_default_wallpaper = -1,
		disable_hyprland_logo   = false,
	},
})
hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace"
})

