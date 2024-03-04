local c = require("penumbra.colors")
local cfg = vim.g.penumbra_config
local util = require("penumbra.util")

local M = {}
local hl = { langs = {}, plugins = {} }

local function vim_highlights(highlights)
	for group_name, group_settings in pairs(highlights) do
		vim.api.nvim_command(
			string.format(
				"highlight %s guifg=%s guibg=%s guisp=%s gui=%s",
				group_name,
				group_settings.fg or "none",
				group_settings.bg or "none",
				group_settings.sp or "none",
				group_settings.fmt or "none"
			)
		)
	end
end

local colors = {
	Fg = { fg = c.fg },
	LightGrey = { fg = c.sky_p },
	Grey = { fg = c.sky_m },
	Red = { fg = c.red },
	Cyan = { fg = c.cyan },
	Yellow = { fg = c.yellow },
	Orange = { fg = c.orange },
	Green = { fg = c.green },
	Blue = { fg = c.blue },
	Purple = { fg = c.purple },
}
hl.common = {
	Normal = { fg = c.fg, bg = cfg.transparent and c.none or c.bg },
	Terminal = { fg = c.fg, bg = cfg.transparent and c.none or c.bg },
	EndOfBuffer = { fg = cfg.ending_tildes and c.bg_m or c.bg, bg = cfg.transparent and c.none or c.bg },
	FoldColumn = { fg = c.fg, bg = cfg.transparent and c.none or c.bg_p },
	Folded = { fg = c.fg, bg = cfg.transparent and c.none or c.bg_p },
	SignColumn = { fg = c.fg, bg = cfg.transparent and c.none or c.bg },
	ToolbarLine = { fg = c.fg },
	Cursor = { fmt = "reverse" },
	vCursor = { fmt = "reverse" },
	iCursor = { fmt = "reverse" },
	lCursor = { fmt = "reverse" },
	CursorIM = { fmt = "reverse" },
	CursorColumn = { bg = c.bg_p },
	CursorLine = { bg = c.bg_p },
	ColorColumn = { bg = c.bg_p },
	CursorLineNr = { fg = c.fg },
	LineNr = { fg = c.sky_m },
	Conceal = { fg = c.sky_m, bg = c.bg_p },
	DiffAdd = { fg = c.none, bg = c.yellow },
	DiffChange = { fg = c.none, bg = c.orange },
	DiffDelete = { fg = c.none, bg = c.purple },
	DiffText = { fg = c.none, bg = c.fg_m },
	DiffAdded = colors.Green,
	DiffRemoved = colors.Red,
	DiffFile = colors.Cyan,
	DiffIndexLine = colors.Grey,
	Directory = { fg = c.blue },
	ErrorMsg = { fg = c.red, fmt = "bold" },
	WarningMsg = { fg = c.yellow, fmt = "bold" },
	MoreMsg = { fg = c.blue, fmt = "bold" },
	CurSearch = { fg = c.bg, bg = c.orange },
	IncSearch = { fg = c.bg, bg = c.orange },
	Search = { fg = c.bg, bg = c.green },
	Substitute = { fg = c.bg, bg = c.green },
	MatchParen = { fg = c.none, bg = c.sky_m },
	NonText = { fg = c.sky_m },
	Whitespace = { fg = c.sky_m },
	SpecialKey = { fg = c.sky_m },
	Pmenu = { fg = c.fg, bg = c.bg_p },
	PmenuSbar = { fg = c.none, bg = c.bg_p },
	PmenuSel = { fg = c.bg, bg = c.blue },
	WildMenu = { fg = c.bg, bg = c.blue },
	PmenuThumb = { fg = c.none, bg = c.sky_m },
	Question = { fg = c.yellow },
	SpellBad = { fg = c.none, fmt = "undercurl", sp = c.red },
	SpellCap = { fg = c.none, fmt = "undercurl", sp = c.yellow },
	SpellLocal = { fg = c.none, fmt = "undercurl", sp = c.blue },
	SpellRare = { fg = c.none, fmt = "undercurl", sp = c.purple },
	StatusLine = { fg = c.fg, bg = c.bg_m },
	StatusLineTerm = { fg = c.fg, bg = c.bg_m },
	StatusLineNC = { fg = c.sky_m, bg = c.bg_p },
	StatusLineTermNC = { fg = c.sky_m, bg = c.bg_p },
	TabLine = { fg = c.fg, bg = c.bg_p },
	TabLineFill = { fg = c.sky_m, bg = c.bg_p },
	TabLineSel = { fg = c.bg, bg = c.fg },
	WinSeparator = { fg = c.bg3 },
	Visual = { bg = c.bg_p },
	VisualNOS = { fg = c.none, bg = c.bg_m, fmt = "underline" },
	QuickFixLine = { fg = c.blue, fmt = "underline" },
	Debug = { fg = c.yellow },
	debugPC = { fg = c.bg, bg = c.green },
	debugBreakpoint = { fg = c.bg, bg = c.red },
	ToolbarButton = { fg = c.bg, bg = c.blue },
	FloatBorder = { fg = c.sky_m, bg = c.bg_p },
	NormalFloat = { fg = c.fg, bg = c.bg_p },
}

hl.syntax = {
	String = { fg = c.green, fmt = cfg.code_style.strings },
	Character = colors.Orange,
	Number = colors.Orange,
	Float = colors.Orange,
	Boolean = colors.Orange,
	Type = colors.Yellow,
	Structure = colors.Yellow,
	StorageClass = colors.Purple,
	Identifier = { fg = c.red, fmt = cfg.code_style.variables },
	Constant = colors.Cyan,
	PreProc = colors.Purple,
	PreCondit = colors.Purple,
	Include = colors.Purple,
	Keyword = { fg = c.purple, fmt = cfg.code_style.keywords },
	Define = colors.Purple,
	Typedef = colors.Purple,
	Exception = colors.Purple,
	Conditional = { fg = c.purple, fmt = cfg.code_style.keywords },
	Repeat = { fg = c.purple, fmt = cfg.code_style.keywords },
	Statement = colors.Purple,
	Macro = colors.Red,
	Error = colors.Purple,
	Label = colors.Purple,
	Special = colors.Red,
	SpecialChar = colors.Red,
	Function = { fg = c.blue, fmt = cfg.code_style.functions },
	Operator = colors.Purple,
	Title = colors.Cyan,
	Tag = colors.Green,
	Delimiter = colors.LightGrey,
	Comment = { fg = c.sky_m, fmt = cfg.code_style.comments },
	SpecialComment = { fg = c.sky_m, fmt = cfg.code_style.comments },
	Todo = { fg = c.red, fmt = cfg.code_style.comments },
}

if vim.api.nvim_call_function("has", { "nvim-0.8" }) == 1 then
	hl.treesitter = {
		["@annotation"] = colors.Fg,
		["@attribute"] = colors.Cyan,
		["@attribute.typescript"] = colors.Blue,
		["@boolean"] = colors.Orange,
		["@character"] = colors.Orange,
		["@comment"] = { fg = c.sky_m, fmt = cfg.code_style.comments },
		["@comment.todo"] = { fg = c.red, fmt = cfg.code_style.comments },
		["@comment.todo.checked"] = { fg = c.green, fmt = cfg.code_style.comments },
		["@comment.todo.unchecked"] = { fg = c.red, fmt = cfg.code_style.comments },
		["@constant"] = { fg = c.orange, fmt = cfg.code_style.constants },
		["@constant.builtin"] = { fg = c.orange, fmt = cfg.code_style.constants },
		["@constant.macro"] = { fg = c.orange, fmt = cfg.code_style.constants },
		["@constructor"] = { fg = c.yellow, fmt = "bold" },
		["@danger"] = colors.Fg,
		["@diff.add"] = colors.Green,
		["@diff.delete"] = colors.Red,
		["@error"] = colors.Fg,
		["@function"] = { fg = c.blue, fmt = cfg.code_style.functions },
		["@function.builtin"] = { fg = c.cyan, fmt = cfg.code_style.functions },
		["@function.macro"] = { fg = c.cyan, fmt = cfg.code_style.functions },
		["@function.method"] = { fg = c.blue, fmt = cfg.code_style.functions },
		["@keyword"] = { fg = c.purple, fmt = cfg.code_style.keywords },
		["@keyword.conditional"] = { fg = c.purple, fmt = cfg.code_style.keywords },
		["@keyword.directive"] = colors.Purple,
		["@keyword.exception"] = colors.Purple,
		["@keyword.function"] = { fg = c.purple, fmt = cfg.code_style.functions },
		["@keyword.import"] = colors.Purple,
		["@keyword.operator"] = { fg = c.purple, fmt = cfg.code_style.keywords },
		["@keyword.repeat"] = { fg = c.purple, fmt = cfg.code_style.keywords },
		["@label"] = colors.Red,
		["@markup.emphasis"] = { fg = c.fg, fmt = "italic" },
		["@markup.environment"] = colors.Fg,
		["@markup.environment.name"] = colors.Fg,
		["@markup.heading"] = { fg = c.orange, fmt = "bold" },
		["@markup.heading.1.markdown"] = { fg = c.red, fmt = "bold" },
		["@markup.heading.2.markdown"] = { fg = c.purple, fmt = "bold" },
		["@markup.heading.3.markdown"] = { fg = c.orange, fmt = "bold" },
		["@markup.heading.4.markdown"] = { fg = c.red, fmt = "bold" },
		["@markup.heading.5.markdown"] = { fg = c.purple, fmt = "bold" },
		["@markup.heading.6.markdown"] = { fg = c.orange, fmt = "bold" },
		["@markup.heading.1.marker.markdown"] = { fg = c.red, fmt = "bold" },
		["@markup.heading.2.marker.markdown"] = { fg = c.purple, fmt = "bold" },
		["@markup.heading.3.marker.markdown"] = { fg = c.orange, fmt = "bold" },
		["@markup.heading.4.marker.markdown"] = { fg = c.red, fmt = "bold" },
		["@markup.heading.5.marker.markdown"] = { fg = c.purple, fmt = "bold" },
		["@markup.heading.6.marker.markdown"] = { fg = c.orange, fmt = "bold" },
		["@markup.link"] = colors.Blue,
		["@markup.link.url"] = { fg = c.cyan, fmt = "underline" },
		["@markup.list"] = colors.Red,
		["@markup.math"] = colors.Fg,
		["@markup.raw"] = colors.Green,
		["@markup.strike"] = { fg = c.fg, fmt = "strikethrough" },
		["@markup.strong"] = { fg = c.fg, fmt = "bold" },
		["@markup.todo"] = { fg = c.red, fmt = cfg.code_style.comments },
		["@markup.todo.checked"] = { fg = c.green, fmt = cfg.code_style.comments },
		["@markup.todo.unchecked"] = { fg = c.red, fmt = cfg.code_style.comments },
		["@markup.underline"] = { fg = c.fg, fmt = "underline" },
		["@module"] = colors.Yellow,
		["@none"] = colors.Fg,
		["@note"] = colors.Fg,
		["@number"] = colors.Orange,
		["@number.float"] = colors.Orange,
		["@operator"] = colors.Fg,
		["@parameter.reference"] = colors.Fg,
		["@property"] = colors.Cyan,
		["@punctuation.bracket"] = colors.LightGrey,
		["@punctuation.delimiter"] = colors.LightGrey,
		["@storageclass"] = colors.Purple,
		["@string"] = { fg = c.green, fmt = cfg.code_style.strings },
		["@string.escape"] = { fg = c.red, fmt = cfg.code_style.strings },
		["@string.regexp"] = { fg = c.orange, fmt = cfg.code_style.strings },
		["@string.special.symbol"] = colors.Cyan,
		["@tag"] = colors.Purple,
		["@tag.attribute"] = colors.Yellow,
		["@tag.delimiter"] = colors.Purple,
		["@text"] = colors.Fg,
		["@type"] = colors.Yellow,
		["@type.builtin"] = colors.Orange,
		["@variable"] = { fg = c.fg, fmt = cfg.code_style.variables },
		["@variable.builtin"] = { fg = c.red, fmt = cfg.code_style.variables },
		["@variable.member"] = colors.Fg,
		["@variable.parameter"] = colors.Red,
		["@warning"] = colors.Fg,

		-- Old configuration for nvim-treesiter@0.9.1 and below
		["@conditional"] = { fg = c.purple, fmt = cfg.code_style.keywords },
		["@exception"] = colors.Purple,
		["@field"] = colors.Cyan,
		["@float"] = colors.Orange,
		["@include"] = colors.Purple,
		["@method"] = { fg = c.blue, fmt = cfg.code_style.functions },
		["@namespace"] = colors.Yellow,
		["@parameter"] = colors.Red,
		["@preproc"] = colors.Purple,
		["@punctuation.special"] = colors.Red,
		["@repeat"] = { fg = c.purple, fmt = cfg.code_style.keywords },
		["@string.regex"] = { fg = c.orange, fmt = cfg.code_style.strings },
		["@text.strong"] = { fg = c.fg, fmt = "bold" },
		["@text.emphasis"] = { fg = c.fg, fmt = "italic" },
		["@text.underline"] = { fg = c.fg, fmt = "underline" },
		["@text.strike"] = { fg = c.fg, fmt = "strikethrough" },
		["@text.title"] = { fg = c.orange, fmt = "bold" },
		["@text.literal"] = colors.Green,
		["@text.uri"] = { fg = c.cyan, fmt = "underline" },
		["@text.todo"] = { fg = c.red, fmt = cfg.code_style.comments },
		["@text.todo.unchecked"] = { fg = c.red, fmt = cfg.code_style.comments },
		["@text.todo.checked"] = { fg = c.green, fmt = cfg.code_style.comments },
		["@text.math"] = colors.Fg,
		["@text.reference"] = colors.Blue,
		["@text.environment"] = colors.Fg,
		["@text.environment.name"] = colors.Fg,
		["@text.diff.add"] = colors.Green,
		["@text.diff.delete"] = colors.Red,
	}

	if vim.api.nvim_call_function("has", { "nvim-0.9" }) == 1 then
		hl.lsp = {
			["@lsp.type.comment"] = hl.treesitter["@comment"],
			["@lsp.type.enum"] = hl.treesitter["@type"],
			["@lsp.type.enumMember"] = hl.treesitter["@constant.builtin"],
			["@lsp.type.interface"] = hl.treesitter["@type"],
			["@lsp.type.typeParameter"] = hl.treesitter["@type"],
			["@lsp.type.keyword"] = hl.treesitter["@keyword"],
			["@lsp.type.namespace"] = hl.treesitter["@module"],
			["@lsp.type.parameter"] = hl.treesitter["@variable.parameter"],
			["@lsp.type.property"] = hl.treesitter["@property"],
			["@lsp.type.variable"] = hl.treesitter["@variable"],
			["@lsp.type.macro"] = hl.treesitter["@function.macro"],
			["@lsp.type.method"] = hl.treesitter["@function.method"],
			["@lsp.type.number"] = hl.treesitter["@number"],
			["@lsp.type.generic"] = hl.treesitter["@text"],
			["@lsp.type.builtinType"] = hl.treesitter["@type.builtin"],
			["@lsp.typemod.method.defaultLibrary"] = hl.treesitter["@function"],
			["@lsp.typemod.function.defaultLibrary"] = hl.treesitter["@function"],
			["@lsp.typemod.operator.injected"] = hl.treesitter["@operator"],
			["@lsp.typemod.string.injected"] = hl.treesitter["@string"],
			["@lsp.typemod.variable.defaultLibrary"] = hl.treesitter["@variable.builtin"],
			["@lsp.typemod.variable.injected"] = hl.treesitter["@variable"],
			["@lsp.typemod.variable.static"] = hl.treesitter["@constant"],
		}
	end
else
	hl.treesitter = {
		TSAnnotation = colors.Fg,
		TSAttribute = colors.Cyan,
		TSBoolean = colors.Orange,
		TSCharacter = colors.Orange,
		TSComment = { fg = c.sky_m, fmt = cfg.code_style.comments },
		TSConditional = { fg = c.purple, fmt = cfg.code_style.keywords },
		TSConstant = colors.Orange,
		TSConstBuiltin = colors.Orange,
		TSConstMacro = colors.Orange,
		TSConstructor = { fg = c.yellow, fmt = "bold" },
		TSError = colors.Fg,
		TSException = colors.Purple,
		TSField = colors.Cyan,
		TSFloat = colors.Orange,
		TSFunction = { fg = c.blue, fmt = cfg.code_style.functions },
		TSFuncBuiltin = { fg = c.cyan, fmt = cfg.code_style.functions },
		TSFuncMacro = { fg = c.cyan, fmt = cfg.code_style.functions },
		TSInclude = colors.Purple,
		TSKeyword = { fg = c.purple, fmt = cfg.code_style.keywords },
		TSKeywordFunction = { fg = c.purple, fmt = cfg.code_style.functions },
		TSKeywordOperator = { fg = c.purple, fmt = cfg.code_style.keywords },
		TSLabel = colors.Red,
		TSMethod = { fg = c.blue, fmt = cfg.code_style.functions },
		TSNamespace = colors.Yellow,
		TSNone = colors.Fg,
		TSNumber = colors.Orange,
		TSOperator = colors.Fg,
		TSParameter = colors.Red,
		TSParameterReference = colors.Fg,
		TSProperty = colors.Cyan,
		TSPunctDelimiter = colors.LightGrey,
		TSPunctBracket = colors.LightGrey,
		TSPunctSpecial = colors.Red,
		TSRepeat = { fg = c.purple, fmt = cfg.code_style.keywords },
		TSString = { fg = c.green, fmt = cfg.code_style.strings },
		TSStringRegex = { fg = c.orange, fmt = cfg.code_style.strings },
		TSStringEscape = { fg = c.red, fmt = cfg.code_style.strings },
		TSSymbol = colors.Cyan,
		TSTag = colors.Purple,
		TSTagDelimiter = colors.Purple,
		TSText = colors.Fg,
		TSStrong = { fg = c.fg, fmt = "bold" },
		TSEmphasis = { fg = c.fg, fmt = "italic" },
		TSUnderline = { fg = c.fg, fmt = "underline" },
		TSStrike = { fg = c.fg, fmt = "strikethrough" },
		TSTitle = { fg = c.orange, fmt = "bold" },
		TSLiteral = colors.Green,
		TSURI = { fg = c.cyan, fmt = "underline" },
		TSMath = colors.Fg,
		TSTextReference = colors.Blue,
		TSEnvironment = colors.Fg,
		TSEnvironmentName = colors.Fg,
		TSNote = colors.Fg,
		TSWarning = colors.Fg,
		TSDanger = colors.Fg,
		TSType = colors.Yellow,
		TSTypeBuiltin = colors.Orange,
		TSVariable = { fg = c.fg, fmt = cfg.code_style.variables },
		TSVariableBuiltin = { fg = c.red, fmt = cfg.code_style.variables },
	}
end

local diagnostics_error_color = cfg.diagnostics.darker and c.red_c or c.red
local diagnostics_hint_color = cfg.diagnostics.darker and c.purple_c or c.purple
local diagnostics_warn_color = cfg.diagnostics.darker and c.yellow_c or c.yellow
local diagnostics_info_color = cfg.diagnostics.darker and c.cyan_c or c.cyan
hl.plugins.lsp = {
	LspCxxHlGroupEnumConstant = colors.Orange,
	LspCxxHlGroupMemberVariable = colors.Orange,
	LspCxxHlGroupNamespace = colors.Blue,
	LspCxxHlSkippedRegion = colors.Grey,
	LspCxxHlSkippedRegionBeginEnd = colors.Red,

	DiagnosticError = { fg = c.red },
	DiagnosticHint = { fg = c.purple },
	DiagnosticInfo = { fg = c.cyan },
	DiagnosticWarn = { fg = c.yellow },

	DiagnosticVirtualTextError = {
		bg = cfg.diagnostics.background and util.darken(diagnostics_error_color, 0.1, c.bg) or c.none,
		fg = diagnostics_error_color,
	},
	DiagnosticVirtualTextWarn = {
		bg = cfg.diagnostics.background and util.darken(diagnostics_warn_color, 0.1, c.bg) or c.none,
		fg = diagnostics_warn_color,
	},
	DiagnosticVirtualTextInfo = {
		bg = cfg.diagnostics.background and util.darken(diagnostics_info_color, 0.1, c.bg) or c.none,
		fg = diagnostics_info_color,
	},
	DiagnosticVirtualTextHint = {
		bg = cfg.diagnostics.background and util.darken(diagnostics_hint_color, 0.1, c.bg) or c.none,
		fg = diagnostics_hint_color,
	},

	DiagnosticUnderlineError = { fmt = cfg.diagnostics.undercurl and "undercurl" or "underline", sp = c.red },
	DiagnosticUnderlineHint = { fmt = cfg.diagnostics.undercurl and "undercurl" or "underline", sp = c.purple },
	DiagnosticUnderlineInfo = { fmt = cfg.diagnostics.undercurl and "undercurl" or "underline", sp = c.blue },
	DiagnosticUnderlineWarn = { fmt = cfg.diagnostics.undercurl and "undercurl" or "underline", sp = c.yellow },

	LspReferenceText = { bg = c.bg_m },
	LspReferenceWrite = { bg = c.bg_m },
	LspReferenceRead = { bg = c.bg_m },

	LspCodeLens = { fg = c.sky_m, fmt = cfg.code_style.comments },
	LspCodeLensSeparator = { fg = c.sky_m },
}

hl.plugins.lsp.LspDiagnosticsDefaultError = hl.plugins.lsp.DiagnosticError
hl.plugins.lsp.LspDiagnosticsDefaultHint = hl.plugins.lsp.DiagnosticHint
hl.plugins.lsp.LspDiagnosticsDefaultInformation = hl.plugins.lsp.DiagnosticInfo
hl.plugins.lsp.LspDiagnosticsDefaultWarning = hl.plugins.lsp.DiagnosticWarn
hl.plugins.lsp.LspDiagnosticsUnderlineError = hl.plugins.lsp.DiagnosticUnderlineError
hl.plugins.lsp.LspDiagnosticsUnderlineHint = hl.plugins.lsp.DiagnosticUnderlineHint
hl.plugins.lsp.LspDiagnosticsUnderlineInformation = hl.plugins.lsp.DiagnosticUnderlineInfo
hl.plugins.lsp.LspDiagnosticsUnderlineWarning = hl.plugins.lsp.DiagnosticUnderlineWarn
hl.plugins.lsp.LspDiagnosticsVirtualTextError = hl.plugins.lsp.DiagnosticVirtualTextError
hl.plugins.lsp.LspDiagnosticsVirtualTextWarning = hl.plugins.lsp.DiagnosticVirtualTextWarn
hl.plugins.lsp.LspDiagnosticsVirtualTextInformation = hl.plugins.lsp.DiagnosticVirtualTextInfo
hl.plugins.lsp.LspDiagnosticsVirtualTextHint = hl.plugins.lsp.DiagnosticVirtualTextHint

hl.plugins.ale = {
	ALEErrorSign = hl.plugins.lsp.DiagnosticError,
	ALEInfoSign = hl.plugins.lsp.DiagnosticInfo,
	ALEWarningSign = hl.plugins.lsp.DiagnosticWarn,
}

hl.plugins.barbar = {
	BufferCurrent = { fmt = "bold" },
	BufferCurrentMod = { fg = c.orange, fmt = "bold,italic" },
	BufferCurrentSign = { fg = c.purple },
	BufferInactiveMod = { fg = c.sky_p, bg = c.bg_p, fmt = "italic" },
	BufferVisible = { fg = c.sky_p, bg = c.bg },
	BufferVisibleMod = { fg = c.yellow, bg = c.bg, fmt = "italic" },
	BufferVisibleIndex = { fg = c.sky_p, bg = c.bg },
	BufferVisibleSign = { fg = c.sky_p, bg = c.bg },
	BufferVisibleTarget = { fg = c.sky_p, bg = c.bg },
}

hl.plugins.cmp = {
	CmpItemAbbr = colors.Fg,
	CmpItemAbbrDeprecated = { fg = c.sky_p, fmt = "strikethrough" },
	CmpItemAbbrMatch = colors.Cyan,
	CmpItemAbbrMatchFuzzy = { fg = c.cyan, fmt = "underline" },
	CmpItemMenu = colors.LightGrey,
	CmpItemKind = { fg = c.purple, fmt = cfg.cmp_itemkind_reverse and "reverse" },
}

hl.plugins.coc = {
	CocErrorSign = hl.plugins.lsp.DiagnosticError,
	CocHintSign = hl.plugins.lsp.DiagnosticHint,
	CocInfoSign = hl.plugins.lsp.DiagnosticInfo,
	CocWarningSign = hl.plugins.lsp.DiagnosticWarn,
}

hl.plugins.whichkey = {
	WhichKey = colors.Red,
	WhichKeyDesc = colors.Blue,
	WhichKeyGroup = colors.Orange,
	WhichKeySeparator = colors.Green,
}

hl.plugins.gitgutter = {
	GitGutterAdd = { fg = c.green },
	GitGutterChange = { fg = c.blue },
	GitGutterDelete = { fg = c.red },
}

hl.plugins.hop = {
	HopNextKey = { fg = c.red, fmt = "bold" },
	HopNextKey1 = { fg = c.cyan, fmt = "bold" },
	HopNextKey2 = { fg = util.darken(c.blue, 0.7) },
	HopUnmatched = colors.Grey,
}

-- comment
hl.plugins.diffview = {
	DiffviewFilePanelTitle = { fg = c.blue, fmt = "bold" },
	DiffviewFilePanelCounter = { fg = c.purple, fmt = "bold" },
	DiffviewFilePanelFileName = colors.Fg,
	DiffviewNormal = hl.common.Normal,
	DiffviewCursorLine = hl.common.CursorLine,
	DiffviewVertSplit = hl.common.VertSplit,
	DiffviewSignColumn = hl.common.SignColumn,
	DiffviewStatusLine = hl.common.StatusLine,
	DiffviewStatusLineNC = hl.common.StatusLineNC,
	DiffviewEndOfBuffer = hl.common.EndOfBuffer,
	DiffviewFilePanelRootPath = colors.Grey,
	DiffviewFilePanelPath = colors.Grey,
	DiffviewFilePanelInsertions = colors.Green,
	DiffviewFilePanelDeletions = colors.Red,
	DiffviewStatusAdded = colors.Green,
	DiffviewStatusUntracked = colors.Blue,
	DiffviewStatusModified = colors.Blue,
	DiffviewStatusRenamed = colors.Blue,
	DiffviewStatusCopied = colors.Blue,
	DiffviewStatusTypeChange = colors.Blue,
	DiffviewStatusUnmerged = colors.Blue,
	DiffviewStatusUnknown = colors.Red,
	DiffviewStatusDeleted = colors.Red,
	DiffviewStatusBroken = colors.Red,
}

hl.plugins.gitsigns = {
	GitSignsAdd = colors.Green,
	GitSignsAddLn = colors.Green,
	GitSignsAddNr = colors.Green,
	GitSignsChange = colors.Blue,
	GitSignsChangeLn = colors.Blue,
	GitSignsChangeNr = colors.Blue,
	GitSignsDelete = colors.Red,
	GitSignsDeleteLn = colors.Red,
	GitSignsDeleteNr = colors.Red,
}

hl.plugins.neo_tree = {
	NeoTreeNormal = { fg = c.fg, bg = cfg.transparent and c.none or c.bg_d },
	NeoTreeNormalNC = { fg = c.fg, bg = cfg.transparent and c.none or c.bg_d },
	NeoTreeVertSplit = { fg = c.bg_m, bg = cfg.transparent and c.none or c.bg_d },
	NeoTreeWinSeparator = { fg = c.bg_m, bg = cfg.transparent and c.none or c.bg_d },
	NeoTreeEndOfBuffer = { fg = cfg.ending_tildes and c.bg2 or c.bg_d, bg = cfg.transparent and c.none or c.bg_d },
	NeoTreeRootName = { fg = c.orange, fmt = "bold" },
	NeoTreeGitAdded = colors.Green,
	NeoTreeGitDeleted = colors.Red,
	NeoTreeGitModified = colors.Yellow,
	NeoTreeGitConflict = { fg = c.red, fmt = "bold,italic" },
	NeoTreeGitUntracked = { fg = c.red, fmt = "italic" },
	NeoTreeIndentMarker = colors.Grey,
	NeoTreeSymbolicLinkTarget = colors.Purple,
}

hl.plugins.neotest = {
	NeotestAdapterName = { fg = c.purple, fmt = "bold" },
	NeotestDir = colors.Cyan,
	NeotestExpandMarker = colors.Grey,
	NeotestFailed = colors.Red,
	NeotestFile = colors.Cyan,
	NeotestFocused = { fmt = "bold,italic" },
	NeotestIndent = colors.Grey,
	NeotestMarked = { fg = c.orange, fmt = "bold" },
	NeotestNamespace = colors.Blue,
	NeotestPassed = colors.Green,
	NeotestRunning = colors.Yellow,
	NeotestWinSelect = { fg = c.cyan, fmt = "bold" },
	NeotestSkipped = colors.LightGrey,
	NeotestTarget = colors.Purple,
	NeotestTest = colors.Fg,
	NeotestUnknown = colors.LightGrey,
}

hl.plugins.nvim_tree = {
	NvimTreeNormal = { fg = c.fg, bg = cfg.transparent and c.none or c.bg_d },
	NvimTreeVertSplit = { fg = c.bg_d, bg = cfg.transparent and c.none or c.bg_d },
	NvimTreeEndOfBuffer = { fg = cfg.ending_tildes and c.bg_m or c.bg_d, bg = cfg.transparent and c.none or c.bg_d },
	NvimTreeRootFolder = { fg = c.orange, fmt = "bold" },
	NvimTreeGitDirty = colors.Yellow,
	NvimTreeGitNew = colors.Green,
	NvimTreeGitDeleted = colors.Red,
	NvimTreeSpecialFile = { fg = c.yellow, fmt = "underline" },
	NvimTreeIndentMarker = colors.Fg,
	NvimTreeImageFile = { fg = c.purple_c },
	NvimTreeSymlink = colors.Purple,
	NvimTreeFolderName = colors.Blue,
}

hl.plugins.telescope = {
	TelescopeBorder = colors.Red,
	TelescopePromptBorder = colors.Cyan,
	TelescopeResultsBorder = colors.Cyan,
	TelescopePreviewBorder = colors.Cyan,
	TelescopeMatching = { fg = c.orange, fmt = "bold" },
	TelescopePromptPrefix = colors.Green,
	TelescopeSelection = { bg = c.bg_m },
	TelescopeSelectionCaret = colors.Yellow,
}

hl.plugins.dashboard = {
	DashboardShortCut = colors.Blue,
	DashboardHeader = colors.Yellow,
	DashboardCenter = colors.Cyan,
	DashboardFooter = { fg = c.red_c, fmt = "italic" },
}

hl.plugins.outline = {
	FocusedSymbol = { fg = c.purple, bg = c.bg_m, fmt = "bold" },
	AerialLine = { fg = c.purple, bg = c.bg_m, fmt = "bold" },
}

hl.plugins.navic = {
	NavicText = { fg = c.fg },
	NavicSeparator = { fg = c.light_grey },
}

hl.plugins.ts_rainbow = {
	rainbowcol1 = colors.LightGrey,
	rainbowcol2 = colors.Yellow,
	rainbowcol3 = colors.Blue,
	rainbowcol4 = colors.Orange,
	rainbowcol5 = colors.Purple,
	rainbowcol6 = colors.Green,
	rainbowcol7 = colors.Red,
}

hl.plugins.rainbow_delimiters = {
	RainbowDelimiterRed = colors.Red,
	RainbowDelimiterYellow = colors.Yellow,
	RainbowDelimiterBlue = colors.Blue,
	RainbowDelimiterOrange = colors.Orange,
	RainbowDelimiterGreen = colors.Green,
	RainbowDelimiterViolet = colors.Purple,
	RainbowDelimiterCyan = colors.Cyan,
}

hl.plugins.indent_blankline = {
	IndentBlankLineIndent1 = colors.Blue,
	IndentBlankLineIndent2 = colors.Green,
	IndentBlankLineIndent3 = colors.Cyan,
	IndentBlankLineIndent4 = colors.LightGrey,
	IndentBlankLineIndent5 = colors.Purple,
	IndentBlankLineIndent6 = colors.Red,
	IndentBlanklineChar = { fg = c.bg3, gui = "nocombine" },
	IndentBlankLineContext = { fg = c.orange, bg = c.bg3, bold = true },
	IndentBlanklineContextStart = { sp = c.sky, gui = "underline" },
	IndentBlanklineContextSpaceChar = { gui = "nocombine" },

	-- Ibl v3
	IblIndent = { fg = c.bg3, fmt = "nocombine" },
	IblWhitespace = { fg = c.sky_m, fmt = "nocombine" },
	IblScope = { fg = c.grey, fmt = "nocombine" },
}

hl.plugins.mini = {
	MiniCompletionActiveParameter = { fmt = "underline" },

	MiniCursorword = { fmt = "underline" },
	MiniCursorwordCurrent = { fmt = "underline" },

	MiniIndentscopeSymbol = { fg = c.sky_p },
	MiniIndentscopePrefix = { fmt = "nocombine" }, -- Make it invisible

	MiniJump = { fg = c.purple, fmt = "underline", sp = c.purple },

	MiniJump2dSpot = { fg = c.red, fmt = "bold,nocombine" },

	MiniStarterCurrent = { fmt = "nocombine" },
	MiniStarterFooter = { fg = c.red_c, fmt = "italic" },
	MiniStarterHeader = colors.Yellow,
	MiniStarterInactive = { fg = c.sky_m, fmt = cfg.code_style.comments },
	MiniStarterItem = { fg = c.fg, bg = cfg.transparent and c.none or c.bg },
	MiniStarterItemBullet = { fg = c.sky_m },
	MiniStarterItemPrefix = { fg = c.yellow },
	MiniStarterSection = colors.LightGrey,
	MiniStarterQuery = { fg = c.cyan },

	MiniStatuslineDevinfo = { fg = c.fg, bg = c.bg_m },
	MiniStatuslineFileinfo = { fg = c.fg, bg = c.bg_m },
	MiniStatuslineFilename = { fg = c.sky_m, bg = c.bg_p },
	MiniStatuslineInactive = { fg = c.sky_m, bg = c.bg },
	MiniStatuslineModeCommand = { fg = c.bg, bg = c.yellow, fmt = "bold" },
	MiniStatuslineModeInsert = { fg = c.bg, bg = c.blue, fmt = "bold" },
	MiniStatuslineModeNormal = { fg = c.bg, bg = c.green, fmt = "bold" },
	MiniStatuslineModeOther = { fg = c.bg, bg = c.cyen, fmt = "bold" },
	MiniStatuslineModeReplace = { fg = c.bg, bg = c.red, fmt = "bold" },
	MiniStatuslineModeVisual = { fg = c.bg, bg = c.purple, fmt = "bold" },

	MiniSurround = { fg = c.bg, bg = c.orange },

	MiniTablineCurrent = { fmt = "bold" },
	MiniTablineFill = { fg = c.sky_m, bg = c.bg_p },
	MiniTablineHidden = { fg = c.fg, bg = c.bg_p },
	MiniTablineModifiedCurrent = { fg = c.orange, fmt = "bold,italic" },
	MiniTablineModifiedHidden = { fg = c.sky_p, bg = c.bg_p, fmt = "italic" },
	MiniTablineModifiedVisible = { fg = c.yellow, bg = c.bg, fmt = "italic" },
	MiniTablineTabpagesection = { fg = c.bg, bg = c.yellow },
	MiniTablineVisible = { fg = c.sky_p, bg = c.bg },

	MiniTestEmphasis = { fmt = "bold" },
	MiniTestFail = { fg = c.red, fmt = "bold" },
	MiniTestPass = { fg = c.green, fmt = "bold" },

	MiniTrailspace = { bg = c.red },
}

hl.plugins.noice = {
	NoiceCmdlinePopupBorder = { bg = c.none, fg = c.cyan },
	NoiceCmdlinePopupBorderSearch = { bg = c.none, fg = c.cyan },
	NoiceCmdlineIcon = { bg = c.bg, fg = c.yellow },
	NoiceCmdlinePopup = { bg = c.bg, fg = c.fg, bold = true },
	NoiceCmdline = { bg = c.bg, fg = c.cyan },
}

hl.plugins.notify = {
	NotifyERRORBorder = { bg = c.none, fg = c.red },
	NotifyWARNBorder = { bg = c.none, fg = c.yellow },
	NotifyINFOBorder = { bg = c.none, fg = c.green },
	NotifyDEBUGBorder = { bg = c.none, fg = c.purple },
	NotifyTRACEBorder = { bg = c.none, fg = c.purple },
	NotifyERRORIcon = { bg = c.none, fg = c.red },
	NotifyWARNIcon = { bg = c.none, fg = c.yellow },
	NotifyINFOIcon = { bg = c.none, fg = c.green },
	NotifyDEBUGIcon = { bg = c.none, fg = c.purple },
	NotifyTRACEIcon = { bg = c.none, fg = c.purple },
	NotifyERRORTitle = { bg = c.none, fg = c.sky_p },
	NotifyWARNTitle = { bg = c.none, fg = c.sky_p },
	NotifyINFOTitle = { bg = c.none, fg = c.sky_p },
	NotifyDEBUGTitle = { bg = c.none, fg = c.sky_p },
	NotifyTRACETitle = { bg = c.none, fg = c.sky_p },
}

hl.langs.c = {
	cInclude = colors.Blue,
	cStorageClass = colors.Purple,
	cTypedef = colors.Yellow,
	cDefine = colors.Cyan,
	cTSInclude = colors.Blue,
	cTSConstant = colors.Cyan,
	cTSConstMacro = colors.Purple,
	cTSOperator = colors.Purple,
}

hl.langs.cpp = {
	cppStatement = { fg = c.purple, fmt = "bold" },
	cppTSInclude = colors.Blue,
	cppTSConstant = colors.Cyan,
	cppTSConstMacro = colors.Purple,
	cppTSOperator = colors.Purple,
}

hl.langs.markdown = {
	markdownBlockquote = colors.Grey,
	markdownBold = { fg = c.none, fmt = "bold" },
	markdownBoldDelimiter = colors.Grey,
	markdownCode = colors.Green,
	markdownCodeBlock = colors.Green,
	markdownCodeDelimiter = colors.Yellow,
	markdownH1 = { fg = c.red, fmt = "bold" },
	markdownH2 = { fg = c.purple, fmt = "bold" },
	markdownH3 = { fg = c.orange, fmt = "bold" },
	markdownH4 = { fg = c.red, fmt = "bold" },
	markdownH5 = { fg = c.purple, fmt = "bold" },
	markdownH6 = { fg = c.orange, fmt = "bold" },
	markdownHeadingDelimiter = colors.Grey,
	markdownHeadingRule = colors.Grey,
	markdownId = colors.Yellow,
	markdownIdDeclaration = colors.Red,
	markdownItalic = { fg = c.none, fmt = "italic" },
	markdownItalicDelimiter = { fg = c.sky_m, fmt = "italic" },
	markdownLinkDelimiter = colors.Grey,
	markdownLinkText = colors.Red,
	markdownLinkTextDelimiter = colors.Grey,
	markdownListMarker = colors.Red,
	markdownOrderedListMarker = colors.Red,
	markdownRule = colors.Purple,
	markdownUrl = { fg = c.blue, fmt = "underline" },
	markdownUrlDelimiter = colors.Grey,
	markdownUrlTitleDelimiter = colors.Green,
}

hl.langs.php = {
	phpFunctions = { fg = c.fg, fmt = cfg.code_style.functions },
	phpMethods = colors.Cyan,
	phpStructure = colors.Purple,
	phpOperator = colors.Purple,
	phpMemberSelector = colors.Fg,
	phpVarSelector = { fg = c.orange, fmt = cfg.code_style.variables },
	phpIdentifier = { fg = c.orange, fmt = cfg.code_style.variables },
	phpBoolean = colors.Cyan,
	phpNumber = colors.Orange,
	phpHereDoc = colors.Green,
	phpNowDoc = colors.Green,
	phpSCKeyword = { fg = c.purple, fmt = cfg.code_style.keywords },
	phpFCKeyword = { fg = c.purple, fmt = cfg.code_style.keywords },
	phpRegion = colors.Blue,
}

hl.langs.scala = {
	scalaNameDefinition = colors.Fg,
	scalaInterpolationBoundary = colors.Purple,
	scalaInterpolation = colors.Purple,
	scalaTypeOperator = colors.Red,
	scalaOperator = colors.Red,
	scalaKeywordModifier = { fg = c.red, fmt = cfg.code_style.keywords },
}

hl.langs.tex = {
	latexTSInclude = colors.Blue,
	latexTSFuncMacro = { fg = c.fg, fmt = cfg.code_style.functions },
	latexTSEnvironment = { fg = c.cyan, fmt = "bold" },
	latexTSEnvironmentName = colors.Yellow,
	texCmdEnv = colors.Cyan,
	texEnvArgName = colors.Yellow,
	latexTSTitle = colors.Green,
	latexTSType = colors.Blue,
	latexTSMath = colors.Orange,
	texMathZoneX = colors.Orange,
	texMathZoneXX = colors.Orange,
	texMathDelimZone = colors.LightGrey,
	texMathDelim = colors.Purple,
	texMathOper = colors.Red,
	texCmd = colors.Purple,
	texCmdPart = colors.Blue,
	texCmdPackage = colors.Blue,
	texPgfType = colors.Yellow,
}

hl.langs.vim = {
	vimOption = colors.Red,
	vimSetEqual = colors.Yellow,
	vimMap = colors.Purple,
	vimMapModKey = colors.Orange,
	vimNotation = colors.Red,
	vimMapLhs = colors.Fg,
	vimMapRhs = colors.Blue,
	vimVar = { fg = c.fg, fmt = cfg.code_style.variables },
	vimCommentTitle = { fg = c.sky_p, fmt = cfg.code_style.comments },
}

local lsp_kind_icons_color = {
	Default = c.purple,
	Array = c.yellow,
	Boolean = c.orange,
	Class = c.yellow,
	Color = c.green,
	Constant = c.orange,
	Constructor = c.blue,
	Enum = c.purple,
	EnumMember = c.yellow,
	Event = c.yellow,
	Field = c.purple,
	File = c.blue,
	Folder = c.orange,
	Function = c.blue,
	Interface = c.green,
	Key = c.cyan,
	Keyword = c.cyan,
	Method = c.blue,
	Module = c.orange,
	Namespace = c.red,
	Null = c.grey,
	Number = c.orange,
	Object = c.red,
	Operator = c.red,
	Package = c.yellow,
	Property = c.cyan,
	Reference = c.orange,
	Snippet = c.red,
	String = c.green,
	Struct = c.purple,
	Text = c.sky_p,
	TypeParameter = c.red,
	Unit = c.green,
	Value = c.orange,
	Variable = c.purple,
}

function M.setup()
	-- define cmp and aerial kind highlights with lsp_kind_icons_color
	for kind, color in pairs(lsp_kind_icons_color) do
		hl.plugins.cmp["CmpItemKind" .. kind] = { fg = color, fmt = cfg.cmp_itemkind_reverse and "reverse" }
		hl.plugins.outline["Aerial" .. kind .. "Icon"] = { fg = color }
		hl.plugins.navic["NavicIcons" .. kind] = { fg = color }
	end

	vim_highlights(hl.common)
	vim_highlights(hl.syntax)
	vim_highlights(hl.treesitter)
	if hl.lsp then
		vim_highlights(hl.lsp)
	end
	for _, group in pairs(hl.langs) do
		vim_highlights(group)
	end
	for _, group in pairs(hl.plugins) do
		vim_highlights(group)
	end

	-- user defined highlights: vim_highlights function cannot be used because it sets an attribute to none if not specified
	local function replace_color(prefix, color_name)
		if not color_name then
			return ""
		end
		if color_name:sub(1, 1) == "$" then
			local name = color_name:sub(2, -1)
			color_name = c[name]
			if not color_name then
				vim.schedule(function()
					vim.notify(
						'penumbra.nvim: unknown color "' .. name .. '"',
						vim.log.levels.ERROR,
						{ title = "penumbra.nvim" }
					)
				end)
				return ""
			end
		end
		return prefix .. "=" .. color_name
	end

	for group_name, group_settings in pairs(vim.g.penumbra_config.highlights) do
		vim.api.nvim_command(
			string.format(
				"highlight %s %s %s %s %s",
				group_name,
				replace_color("guifg", group_settings.fg),
				replace_color("guibg", group_settings.bg),
				replace_color("guisp", group_settings.sp),
				replace_color("gui", group_settings.fmt)
			)
		)
	end

	-- globally disable semanticTokens set by the language server
	for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
		vim.api.nvim_set_hl(0, group, {})
	end
end

return M
