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

local default_prog
local font
local default_cwd

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  default_prog = "powershell.exe"
  font = { "Cascadia Mono" }
  default_cwd = wezterm.home_dir .. "\\Coding"
else
  default_prog = "/bin/bash"
  font = { "Berkeley Mono Nerd Font", "Sarasa Mono SC Nerd" }
  default_cwd = wezterm.home_dir .. "/Coding"
end

local wsl_domains = wezterm.default_wsl_domains()

for _, dom in ipairs(wsl_domains) do
  if dom.name == 'WSL:Ubuntu-24.04' then
    dom.default_prog = { 'bash' }
  end
end

return {
	default_cwd = default_cwd,
	default_prog = { default_prog },
	font = wezterm.font_with_fallback(font),
	font_size = 11.0,

	-- xim_im_name = "fcitx5",
	enable_wayland = true,

	window_background_opacity = 0.9,
	color_scheme = "tokyonight_moon",
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
	-- dpi = 192.0,
  wsl_domains = wsl_domains,
}
