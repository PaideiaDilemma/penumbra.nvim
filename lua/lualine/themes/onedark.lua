local c = require('penumbra.colors')
local cfg = vim.g.penumbra_config
local colors = {
    bg = c.bg,
    fg = c.fg,
    red = c.red,
    green = c.green,
    yellow = c.yellow,
    blue = c.blue,
    purple = c.purple,
    cyan = c.cyan,
    gray = c.sky
}

local one_dark = {
    inactive = {
        a = {fg = colors.gray, bg = colors.bg, gui = 'bold'},
        b = {fg = colors.gray, bg = colors.bg},
        c = {fg = colors.gray, bg = cfg.transparent and c.none or c.bg_p},
    },
    normal = {
        a = {fg = colors.bg, bg = colors.green, gui = 'bold'},
        b = {fg = colors.fg, bg = c.bg_m},
        c = {fg = colors.gray, bg = cfg.lualine.transparent and c.none or c.bg_p},
    },
    visual = {a = {fg = colors.bg, bg = colors.purple, gui = 'bold'}},
    replace = {a = {fg = colors.bg, bg = colors.red, gui = 'bold'}},
    insert = {a = {fg = colors.bg, bg = colors.blue, gui = 'bold'}},
    command = {a = {fg = colors.bg, bg = colors.yellow, gui = 'bold'}},
    terminal = {a = {fg = colors.bg, bg = colors.cyan, gui = 'bold'}},
}
return one_dark;
