local M = {}

M.styles_list = {
	"balanced_dark",
	"contrast_dark",
	"more_contrast_dark",
	"balanced_light",
	"contrast_light",
	"more_contrast_light",
}

---Change penumbra option (vim.g.penumbra_config.option)
---It can't be changed directly by modifing that field due to a Neovim lua bug with global variables (penumbra_config is a global variable)
---@param opt string: option name
---@param value any: new value
function M.set_options(opt, value)
	local cfg = vim.g.penumbra_config
	cfg[opt] = value
	vim.g.penumbra_config = cfg
end

---Apply the colorscheme (same as ':colorscheme penumbra')
function M.colorscheme()
	vim.cmd("hi clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end
	vim.o.termguicolors = true
	vim.g.colors_name = "penumbra"
	require("penumbra.highlights").setup()
	require("penumbra.terminal").setup()
end

---Toggle between penumbra styles
function M.toggle()
	local index = vim.g.penumbra_config.toggle_style_index + 1
	if index > #vim.g.penumbra_config.toggle_style_list then
		index = 1
	end
	M.set_options("style", vim.g.penumbra_config.toggle_style_list[index])
	M.set_options("toggle_style_index", index)
	vim.api.nvim_command("colorscheme penumbra")
	--M.colorscheme()
end

local default_config = {
	-- Main options --
	style = nil,
	flavor = "balanced",
	toggle_style_key = nil,
	toggle_style_list = M.styles_list,
	transparent = false, -- don't set background
	term_colors = false, -- if true enable the terminal
	ending_tildes = false, -- show the end-of-buffer tildes
	cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

	-- Changing Formats --
	code_style = {
		comments = "italic",
		keywords = "none",
		functions = "none",
		strings = "none",
		variables = "none",
	},

	-- Lualine options --
	lualine = {
		transparent = false, -- center bar (c) transparency
	},

	-- Custom Highlights --
	colors = {}, -- Override default colors
	highlights = {}, -- Override highlight groups

	-- Plugins Related --
	diagnostics = {
		darker = true, -- darker colors for diagnostic
		undercurl = true, -- use undercurl for diagnostics
		background = true, -- use background color for virtual text
	},
}

---Setup penumbra.nvim options, without applying colorscheme
---@param opts table: a table containing options
function M.setup(opts)
	if not vim.g.penumbra_config or not vim.g.penumbra_config.loaded then -- if it's the first time setup() is called
		vim.g.penumbra_config = vim.tbl_deep_extend("keep", vim.g.penumbra_config or {}, default_config)
		M.set_options("loaded", true)
		M.set_options("toggle_style_index", 0)

		-- Override vim.o.background if style is set
		-- Otherwise style will be inferred via penumbra_config.flavor from vim.o.background
		if vim.g.penumbra_config.style then
			if vim.g.penumbra_config.style == "light" then
				vim.o.background = "light"
			else
				vim.o.background = "dark"
			end
		end

		-- Without this MatchParen will be inverted twice causing it to be broken
		vim.g.matchparen_disable_cursor_hl = true
	end
	if opts then
		vim.g.penumbra_config = vim.tbl_deep_extend("force", vim.g.penumbra_config, opts)
		if opts.toggle_style_list then -- this table cannot be extended, it has to be replaced
			M.set_options("toggle_style_list", opts.toggle_style_list)
		end
	end
	if vim.g.penumbra_config.toggle_style_key then
		vim.api.nvim_set_keymap(
			"n",
			vim.g.penumbra_config.toggle_style_key,
			'<cmd>lua require("penumbra").toggle()<cr>',
			{ noremap = true, silent = true }
		)
	end
end

function M.load()
	vim.api.nvim_command("colorscheme penumbra")
	--M.colorscheme()
end

return M
