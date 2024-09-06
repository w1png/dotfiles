local wezterm = require("wezterm")

local config = wezterm.config_builder()

local padding = 40
local opacity = 0.6
local blur = 20
-- local colorscheme = "rose-pine-moon"
local colorscheme = "Gruvbox dark, medium (base16)"

local JETBRAINS_MONO_NL = "JetBrainsMonoNL Nerd Font"
local FIRA_CODE = "Fira Code"
local GEIST_MONO = "Geist Mono"

local font = {
	face = GEIST_MONO,
	size = 14,
}

config.window_padding = {
	top = padding,
	right = padding,
	bottom = padding,
	left = padding,
}

config.color_scheme = colorscheme
config.window_background_opacity = opacity
config.macos_window_background_blur = blur
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"

config.font = wezterm.font(font.face)
config.font_size = font.size

return config
