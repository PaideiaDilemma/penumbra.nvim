local colors = require("penumbra.palette")

local function select_colors()
	local selected = { none = "none" }

	if vim.g.penumbra_config.style then
		selected = vim.tbl_extend("force", selected, colors[vim.g.penumbra_config.style])
	elseif vim.o.background == "light" then
		selected = vim.tbl_extend("force", selected, colors[vim.g.penumbra_config.flavor .. "_light"])
	elseif vim.o.background == "dark" then
		selected = vim.tbl_extend("force", selected, colors[vim.g.penumbra_config.flavor .. "_dark"])
	end

	selected = vim.tbl_extend("force", selected, vim.g.penumbra_config.colors)
	return selected
end

return select_colors()
