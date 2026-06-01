hl.config({
	general = {
		gaps_in  = 0,
		gaps_out = 0,
		border_size = 1,
		col = {
			active_border   = { colors = {"rgb(33ccff)", "rgb(00ff99)"}, angle = 45 },
			inactive_border = "rgb(595959)",
		},
		layout = "dwindle",
	},

	decoration = {
		rounding       = 0,
		rounding_power = 2,

		-- Change transparency of focused and unfocused windows
		active_opacity   = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled      = false,
		},

		blur = {
			enabled   = false,
		},
	},
	animations = {
		enabled = true,
	},
	dwindle = {
		preserve_split = true, -- You probably want this
	},
})
