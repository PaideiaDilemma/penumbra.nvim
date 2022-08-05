local M = {}
local cfg = vim.g.penumbra_config
local c = require 'penumbra.colors'

function M.setup()
    if not cfg.term_colors then return end
    vim.g.terminal_color_0 = c.bg
    vim.g.terminal_color_1 = c.red
    vim.g.terminal_color_2 = c.orange
    vim.g.terminal_color_3 = c.yellow
    vim.g.terminal_color_4 = c.green
    vim.g.terminal_color_5 = c.blue
    vim.g.terminal_color_6 = c.cyan
    vim.g.terminal_color_7 = c.fg
    vim.g.terminal_color_8 = c.sky
    vim.g.terminal_color_9 = c.magenta
    vim.g.terminal_color_10 = c.green
    vim.g.terminal_color_11 = c.yellow
    vim.g.terminal_color_12 = c.blue
    vim.g.terminal_color_13 = c.purple
    vim.g.terminal_color_14 = c.cyan
    vim.g.terminal_color_15 = c.fg_p
end

return M
