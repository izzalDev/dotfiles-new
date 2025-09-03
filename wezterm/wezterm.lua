local wezterm = require("wezterm")

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Mocha"
	else
		return "Catppuccin Latte"
	end
end

local appearance = wezterm.gui.get_appearance()

return {
	color_scheme = scheme_for_appearance(appearance),
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 5,
	},
	hide_tab_bar_if_only_one_tab = true,
	default_prog = { "pwsh", "-NoLogo" },
	font = wezterm.font("JetBrainsMono Nerd Font"),
	font_size = 10,
	window_decorations = "RESIZE",
	use_resize_increments = true,
	adjust_window_size_when_changing_font_size = false,
	window_content_alignment = {
		horizontal = "Center",
		vertical = "Center",
	},
	mux_enable_ssh_agent = false,
}
