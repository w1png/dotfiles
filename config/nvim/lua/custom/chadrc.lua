-- First read our docs (completely) then check the example_config repo

local M = {}

M.plugins = require "custom.plugins"
M.mappings = require "custom.mappings"

M.ui = {
  theme = "catppuccin",
}

return M
