local wezterm = require("wezterm")

wezterm.on("update-right-status", function(window, pane)
	local date = "  " .. wezterm.strftime("%a %b %-d %H:%M  ")

	window:set_right_status(wezterm.format({
		{ Attribute = { Underline = "Single" } },
		{ Attribute = { Italic = true } },
		{ Foreground = { Color = "Cyan" } },
		{ Text = date },
	}))
end)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	if tab.is_active then
		return {
			{ Foreground = { Color = "Colour231" } },
			{ Background = { Color = "#24283B" } },
			{ Attribute = { Italic = true } },
			{ Text = " ﲵ : " .. tab.active_pane.title .. " " },
		}
	end
	return tab.actvie_pane.id .. tab.active_pane.title
end)

return {
	default_cwd = "/home/yuchanns/Coding",
	font_rules = {
		{
			italic = true,
			font = wezterm.font("Operator Mono Medium", { italic = true }),
		},
	},
	font = wezterm.font_with_fallback({ "JetBrains Mono", "Sarasa Mono SC Nerd" }),
	font_size = 12.0,

	use_ime = true,
	xim_im_name = "fcitx5",
	enable_wayland = true,

	window_background_opacity = 0.9,
	color_scheme = "tokyonight",
	window_padding = {
		left = 5,
		right = 0,
		top = 0,
		bottom = 0,
	},
	foreground_text_hsb = {
		hue = 1.0,
		saturation = 1.0,
	},
	use_ime = true,
	hide_tab_bar_if_only_one_tab = true,
	window_frame = {
		font_size = 14.0,
		border_bottom_height = "0cell",
	},
	term = "xterm-256color",
}
