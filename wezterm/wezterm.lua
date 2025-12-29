local wezterm = require("wezterm")

local config = wezterm.config_builder()

local paddingX = 32
local paddingY = 16
local opacity = 1
local blur = 8

local catppuccin = "Catppuccin Mocha"
local gruvbox = "Gruvbox dark, medium (base16)"
local rose_pine = "rose-pine-moon"
local gruber = "Gruber (base16)"
local apple_classic = "Apple Classic"
local tokyonight = "Tokyo Night (Gogh)"

config.color_scheme = gruvbox

local JETBRAINS_MONO_NL = "JetBrainsMonoNL Nerd Font"
local FIRA_CODE = "FiraCode Nerd Font Mono"
local GEIST_MONO = "Geist Mono"
local IOSEVKA = "IosevkaTerm Nerd Font Mono"
local COZETTE = "CozetteCrossedSevenVector"
local GOOGLE_SANS = "Google Sans Code"

local font = {
	face = GOOGLE_SANS,
	size = 16,
}

config.window_padding = {
	top = paddingY + 48,
	right = paddingX,
	bottom = paddingY,
	left = paddingX,
}

config.window_background_opacity = opacity
config.macos_window_background_blur = blur
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

config.font = wezterm.font(font.face)
config.font_size = font.size

return config
