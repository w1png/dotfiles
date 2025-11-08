local wezterm = require("wezterm")

local config = wezterm.config_builder()

local paddingX = 32
local opacity = 0.7
local blur = 14

local gruvbox = "Gruvbox dark, medium (base16)"
local rose_pine = "rose-pine-moon"
local gruber = "Gruber (base16)"

config.color_scheme = gruvbox

local JETBRAINS_MONO_NL = "JetBrainsMonoNL Nerd Font"
local FIRA_CODE = "FiraCode Nerd Font Mono"
local GEIST_MONO = "Geist Mono"

local font = {
	face = FIRA_CODE,
	size = 16,
}

config.window_padding = {
	top = 56,
	right = paddingX,
	bottom = 0,
	left = paddingX,
}

config.window_background_opacity = opacity
config.macos_window_background_blur = blur
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

config.font = wezterm.font(font.face)
config.font_size = font.size

return config
