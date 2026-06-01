
-- workspace = r[1-3],monitor:eDP-1
-- workspace = r[4-6],monitor:DP-1
-- workspace = s[true], gapsout:10, gapsin:0
-- windowrule = match:workspace s[true], match:focus true, border_color rgb(cc0055)

hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name  = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name  = "fix-xwayland-drags",
	match = {
		class      = "^$",
		title      = "^$",
		xwayland   = true,
		float      = true,
		fullscreen = false,
		pin        = false,
	},

	no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
	name  = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move  = "20 monitor_h-120",
	float = true,
})

hl.window_rule({
	match = { workspace = "special:magic"},

	border_size = 10,
})
