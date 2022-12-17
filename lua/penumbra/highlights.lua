local c = require('penumbra.colors')
local cfg = vim.g.penumbra_config
local util = require("penumbra.util")

local M = {}
local hl = {langs = {}, plugins = {}}

local function vim_highlights(highlights)
    for group_name, group_settings in pairs(highlights) do
        vim.api.nvim_command(string.format("highlight %s guifg=%s guibg=%s guisp=%s gui=%s", group_name,
            group_settings.fg or "none",
            group_settings.bg or "none",
            group_settings.sp or "none",
            group_settings.fmt or "none"))
    end
end

local colors = {
    Fg = {fg = c.fg},
    LightGrey = {fg = c.sky_p},
    Grey = {fg = c.sky_m},
    Red = {fg = c.red},
    Cyan = {fg = c.cyan},
    Yellow = {fg = c.yellow},
    Orange = {fg = c.orange},
    Green = {fg = c.green},
    Blue = {fg = c.blue},
    Purple = {fg = c.purple}
}
hl.common = {
    Normal = {fg = c.fg, bg = cfg.transparent and c.none or c.bg},
    Terminal = {fg = c.fg, bg = cfg.transparent and c.none or c.bg},
    EndOfBuffer = {fg = cfg.ending_tildes and c.bg_m or c.bg, bg = cfg.transparent and c.none or c.bg},
    FoldColumn = {fg = c.fg, bg = cfg.transparent and c.none or c.bg_p},
    Folded = {fg = c.fg, bg = cfg.transparent and c.none or c.bg_p},
    SignColumn = {fg = c.fg, bg = cfg.transparent and c.none or c.bg},
    ToolbarLine = {fg = c.fg},
    Cursor = {fmt = "reverse"},
    vCursor = {fmt = "reverse"},
    iCursor = {fmt = "reverse"},
    lCursor = {fmt = "reverse"},
    CursorIM = {fmt = "reverse"},
    CursorColumn = {bg = c.bg_p},
    CursorLine = {bg = c.bg_p},
    ColorColumn = {bg = c.bg_p},
    CursorLineNr = {fg = c.fg},
    LineNr = {fg = c.sky_m},
    Conceal = {fg = c.sky_m, bg = c.bg_p},
    DiffAdd = {fg = c.none, bg = c.yellow},
    DiffChange = {fg = c.none, bg = c.orange},
    DiffDelete = {fg = c.none, bg = c.purple},
    DiffText = {fg = c.none, bg = c.fg_m},
    DiffAdded = colors.Green,
    DiffRemoved = colors.Red,
    DiffFile = colors.Cyan,
    DiffIndexLine = colors.Grey,
    Directory = {fg = c.blue},
    ErrorMsg = {fg = c.red, fmt = "bold"},
    WarningMsg = {fg = c.yellow, fmt = "bold"},
    MoreMsg = {fg = c.blue, fmt = "bold"},
    IncSearch = {fg = c.bg, bg = c.orange},
    Search = {fg = c.bg, bg = c.green},
    Substitute = {fg = c.bg, bg = c.green},
    MatchParen = {fg = c.none, bg = c.sky_m},
    NonText = {fg = c.sky_m},
    Whitespace = {fg = c.sky_m},
    SpecialKey = {fg = c.sky_m},
    Pmenu = {fg = c.fg, bg = c.bg_p},
    PmenuSbar = {fg = c.none, bg = c.bg_p},
    PmenuSel = {fg = c.bg, bg = c.blue},
    WildMenu = {fg = c.bg, bg = c.blue},
    PmenuThumb = {fg = c.none, bg = c.sky_m},
    Question = {fg = c.yellow},
    SpellBad = {fg = c.red, fmt = "underline", sp = c.red},
    SpellCap = {fg = c.yellow, fmt = "underline", sp = c.yellow},
    SpellLocal = {fg = c.blue, fmt = "underline", sp = c.blue},
    SpellRare = {fg = c.purple, fmt = "underline", sp = c.purple},
    StatusLine = {fg = c.fg, bg = c.bg_m},
    StatusLineTerm = {fg = c.fg, bg = c.bg_m},
    StatusLineNC = {fg = c.sky_m, bg = c.bg_p},
    StatusLineTermNC = {fg = c.sky_m, bg = c.bg_p},
    TabLine = {fg = c.fg, bg = c.bg_p},
    TabLineFill = {fg = c.sky_m, bg = c.bg_p},
    TabLineSel =  {fg = c.bg, bg = c.fg},
    VertSplit = {fg = c.bg_p},
    Visual = {bg = c.bg_p},
    VisualNOS = {fg = c.none, bg = c.bg_m, fmt = "underline"},
    QuickFixLine = {fg = c.blue, fmt = "underline"},
    Debug = {fg = c.yellow},
    debugPC = {fg = c.bg, bg = c.green},
    debugBreakpoint = {fg = c.bg, bg = c.red},
    ToolbarButton = {fg = c.bg, bg = c.blue},
    FloatBorder = {fg = c.sky_m, bg = c.bg_p},
    NormalFloat = {fg = c.fg, bg = c.bg_p},
}

hl.syntax = {
    String = {fg = c.green, fmt = cfg.code_style.strings},
    Character = colors.Orange,
    Number = colors.Orange,
    Float = colors.Orange,
    Boolean = colors.Orange,
    Type = colors.Yellow,
    Structure = colors.Yellow,
    StorageClass = colors.Purple,
    Identifier = {fg = c.red, fmt = cfg.code_style.variables},
    Constant = colors.Cyan,
    PreProc = colors.Purple,
    PreCondit = colors.Purple,
    Include = colors.Purple,
    Keyword = {fg = c.purple, fmt = cfg.code_style.keywords},
    Define = colors.Purple,
    Typedef = colors.Purple,
    Exception = colors.Purple,
    Conditional = {fg = c.purple, fmt = cfg.code_style.keywords},
    Repeat = {fg = c.purple, fmt = cfg.code_style.keywords},
    Statement = colors.Purple,
    Macro = colors.Red,
    Error = colors.Purple,
    Label = colors.Purple,
    Special = colors.Red,
    SpecialChar = colors.Red,
    Function = {fg = c.blue, fmt = cfg.code_style.functions},
    Operator = colors.Purple,
    Title = colors.Cyan,
    Tag = colors.Green,
    Delimiter = colors.LightGrey,
    Comment = {fg = c.sky_m, fmt = cfg.code_style.comments},
    SpecialComment = {fg = c.sky_m, fmt = cfg.code_style.comments},
    Todo = {fg = c.red, fmt = cfg.code_style.comments}
}

if vim.api.nvim_call_function("has", { "nvim-0.8" }) == 1 then
    hl.treesitter = {
        ["@annotation"] = colors.Fg,
        ["@attribute"] = colors.Cyan,
        ["@boolean"] = colors.Orange,
        ["@character"] = colors.Orange,
        ["@comment"] = {fg = c.sky_m, fmt = cfg.code_style.comments},
        ["@conditional"] = {fg = c.purple, fmt = cfg.code_style.keywords},
        ["@constant"] = colors.Orange,
        ["@constant.builtin"] = colors.Orange,
        ["@constant.macro"] = colors.Orange,
        ["@constructor"] = {fg = c.yellow, fmt = "bold"},
        ["@error"] = colors.Fg,
        ["@exception"] = colors.Purple,
        ["@field"] = colors.Cyan,
        ["@float"] = colors.Orange,
        ["@function"] = {fg = c.blue, fmt = cfg.code_style.functions},
        ["@function.builtin"] = {fg = c.cyan, fmt = cfg.code_style.functions},
        ["@function.macro"] = {fg = c.cyan, fmt = cfg.code_style.functions},
        ["@include"] = colors.Purple,
        ["@keyword"] = {fg = c.purple, fmt = cfg.code_style.keywords},
        ["@keyword.function"] = {fg = c.purple, fmt = cfg.code_style.functions},
        ["@keyword.operator"] =  {fg = c.purple, fmt = cfg.code_style.keywords},
        ["@label"] = colors.Red,
        ["@method"] = colors.Blue,
        ["@namespace"] = colors.Yellow,
        ["@none"] = colors.Fg,
        ["@number"] = colors.Orange,
        ["@operator"] = colors.Fg,
        ["@parameter"] = colors.Red,
        ["@parameter.reference"] = colors.Fg,
        ["@property"] = colors.Cyan,
        ["@punctuation.delimiter"] = colors.LightGrey,
        ["@punctuation.bracket"] = colors.LightGrey,
        ["@punctuation.special"] = colors.Red,
        ["@repeat"] = {fg = c.purple, fmt = cfg.code_style.keywords},
        ["@string"] = {fg = c.green, fmt = cfg.code_style.strings},
        ["@string.regex"] = {fg = c.orange, fmt = cfg.code_style.strings},
        ["@string.escape"] = {fg = c.red, fmt = cfg.code_style.strings},
        ["@symbol"] = colors.Cyan,
        ["@tag"] = colors.Red,
        ["@tag.delimiter"] = colors.Red,
        ["@text"] = colors.Fg,
        ["@text.strong"] = {fg = c.fg, fmt = 'bold'},
        ["@text.emphasis"] = {fg = c.fg, fmt = 'italic'},
        ["@text.underline"] = {fg = c.fg, fmt = 'underline'},
        ["@text.strike"] = {fg = c.fg, fmt = 'strikethrough'},
        ["@text.title"] = {fg = c.orange, fmt = 'bold'},
        ["@text.literal"] = colors.Green,
        ["@text.uri"] = {fg = c.cyan, fmt = 'underline'},
        ["@text.math"] = colors.Fg,
        ["@text.reference"] = colors.Blue,
        ["@text.enviroment"] = colors.Fg,
        ["@text.enviroment.name"] = colors.Fg,
        ["@note"] = colors.Fg,
        ["@warning"] = colors.Fg,
        ["@danger"] = colors.Fg,
        ["@type"] = colors.Yellow,
        ["@type.builtin"] = colors.Orange,
        ["@storageclass"] = colors.Purple,
        ["@variable"] = {fg = c.fg, fmt = cfg.code_style.variables},
        ["@variable.builtin"] = {fg = c.red, fmt = cfg.code_style.variables},
    }
else
    hl.treesitter = {
        TSAnnotation = colors.Fg,
        TSAttribute = colors.Cyan,
        TSBoolean = colors.Orange,
        TSCharacter = colors.Orange,
        TSComment = {fg = c.sky_m, fmt = cfg.code_style.comments},
        TSConditional = {fg = c.purple, fmt = cfg.code_style.keywords},
        TSConstant = colors.Orange,
        TSConstBuiltin = colors.Orange,
        TSConstMacro = colors.Orange,
        TSConstructor = {fg = c.yellow, fmt = "bold"},
        TSError = colors.Fg,
        TSException = colors.Purple,
        TSField = colors.Cyan,
        TSFloat = colors.Orange,
        TSFunction = {fg = c.blue, fmt = cfg.code_style.functions},
        TSFuncBuiltin = {fg = c.cyan, fmt = cfg.code_style.functions},
        TSFuncMacro = {fg = c.cyan, fmt = cfg.code_style.functions},
        TSInclude = colors.Purple,
        TSKeyword = {fg = c.purple, fmt = cfg.code_style.keywords},
        TSKeywordFunction = {fg = c.purple, fmt = cfg.code_style.functions},
        TSKeywordOperator =  {fg = c.purple, fmt = cfg.code_style.keywords},
        TSLabel = colors.Red,
        TSMethod = colors.Blue,
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
        TSRepeat = {fg = c.purple, fmt = cfg.code_style.keywords},
        TSString = {fg = c.green, fmt = cfg.code_style.strings},
        TSStringRegex = {fg = c.orange, fmt = cfg.code_style.strings},
        TSStringEscape = {fg = c.red, fmt = cfg.code_style.strings},
        TSSymbol = colors.Cyan,
        TSTag = colors.Red,
        TSTagDelimiter = colors.Red,
        TSText = colors.Fg,
        TSStrong = {fg = c.fg, fmt = 'bold'},
        TSEmphasis = {fg = c.fg, fmt = 'italic'},
        TSUnderline = {fg = c.fg, fmt = 'underline'},
        TSStrike = {fg = c.fg, fmt = 'strikethrough'},
        TSTitle = {fg = c.orange, fmt = 'bold'},
        TSLiteral = colors.Green,
        TSURI = {fg = c.cyan, fmt = 'underline'},
        TSMath = colors.Fg,
        TSTextReference = colors.Blue,
        TSEnviroment = colors.Fg,
        TSEnviromentName = colors.Fg,
        TSNote = colors.Fg,
        TSWarning = colors.Fg,
        TSDanger = colors.Fg,
        TSType = colors.Yellow,
        TSTypeBuiltin = colors.Orange,
        TSVariable = {fg = c.fg, fmt = cfg.code_style.variables},
        TSVariableBuiltin = {fg = c.red, fmt = cfg.code_style.variables},
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

    DiagnosticError = {fg = c.red},
    DiagnosticHint = {fg = c.purple},
    DiagnosticInfo = {fg = c.cyan},
    DiagnosticWarn = {fg = c.yellow},

    DiagnosticVirtualTextError = { bg = cfg.diagnostics.background and util.darken(diagnostics_error_color, 0.1, c.bg) or c.none,
                                   fg = diagnostics_error_color },
    DiagnosticVirtualTextWarn = { bg = cfg.diagnostics.background and util.darken(diagnostics_warn_color, 0.1, c.bg) or c.none,
                                  fg = diagnostics_warn_color },
    DiagnosticVirtualTextInfo = { bg = cfg.diagnostics.background and util.darken(diagnostics_info_color, 0.1, c.bg) or c.none,
                                  fg = diagnostics_info_color },
    DiagnosticVirtualTextHint = { bg = cfg.diagnostics.background and util.darken(diagnostics_hint_color, 0.1, c.bg) or c.none,
                                  fg = diagnostics_hint_color },

    DiagnosticUnderlineError = {fmt = cfg.diagnostics.undercurl and "undercurl" or "underline", sp = c.red},
    DiagnosticUnderlineHint = {fmt = cfg.diagnostics.undercurl and "undercurl" or "underline", sp = c.purple},
    DiagnosticUnderlineInfo = {fmt = cfg.diagnostics.undercurl and "undercurl" or "underline", sp = c.blue},
    DiagnosticUnderlineWarn = {fmt = cfg.diagnostics.undercurl and "undercurl" or "underline", sp = c.yellow},

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
    WhichKeySeperator = colors.Green
}

hl.plugins.gitgutter = {
    GitGutterAdd = {fg = c.green},
    GitGutterChange = {fg = c.blue},
    GitGutterDelete = {fg = c.red},
}

hl.plugins.hop = {
    HopNextKey = {fg = c.red, fmt = "bold"},
    HopNextKey1 = {fg = c.cyan, fmt = "bold"},
    HopNextKey2 = {fg = util.darken(c.blue, 0.7)},
    HopUnmatched = colors.Grey,
}

-- comment
hl.plugins.diffview = {
    DiffviewFilePanelTitle = {fg = c.blue, fmt = "bold"},
    DiffviewFilePanelCounter = {fg = c.purple, fmt = "bold"},
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
    DiffviewStatusBroken = colors.Red
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
    GitSignsDeleteNr = colors.Red
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
    TelescopeSelection =  { bg =c.bg_m },
    TelescopeSelectionCaret = colors.Yellow
}

hl.plugins.dashboard = {
    DashboardShortCut = colors.Blue,
    DashboardHeader = colors.Yellow,
    DashboardCenter = colors.Cyan,
    DashboardFooter = { fg = c.red_c, fmt = "italic"}
}

hl.plugins.outline = {
    FocusedSymbol = { fg = c.purple, bg = c.bg_m, fmt = "bold" },
    AerialLine = { fg = c.purple, bg = c.bg_m, fmt = "bold" },
}

hl.plugins.ts_rainbow = {
    rainbowcol1 = colors.Grey,
    rainbowcol2 = colors.Yellow,
    rainbowcol3 = colors.Blue,
    rainbowcol4 = colors.Orange,
    rainbowcol5 = colors.Purple,
    rainbowcol6 = colors.Green,
    rainbowcol7 = colors.Red
}

hl.plugins.indent_blankline = {
    IndentBlankLineIndent1 = colors.Blue,
    IndentBlankLineIndent2 = colors.Green,
    IndentBlankLineIndent3 = colors.Cyan,
    IndentBlankLineIndent4 = colors.LightGrey,
    IndentBlankLineIndent5 = colors.Purple,
    IndentBlankLineIndent6 = colors.Red,
    IndentBlankLineContext = { fg = c.orange, bg = c.bg3, bold = true },
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

hl.langs.c = {
    cInclude = colors.Blue,
    cStorageClass = colors.Purple,
    cTypedef = colors.Purple,
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
    markdownBold = {fg = c.none, fmt = "bold"},
    markdownBoldDelimiter = colors.Grey,
    markdownCode = colors.Green,
    markdownCodeBlock = colors.Green,
    markdownCodeDelimiter = colors.Yellow,
    markdownH1 = {fg = c.red, fmt = "bold"},
    markdownH2 = {fg = c.purple, fmt = "bold"},
    markdownH3 = {fg = c.orange, fmt = "bold"},
    markdownH4 = {fg = c.red, fmt = "bold"},
    markdownH5 = {fg = c.purple, fmt = "bold"},
    markdownH6 = {fg = c.orange, fmt = "bold"},
    markdownHeadingDelimiter = colors.Grey,
    markdownHeadingRule = colors.Grey,
    markdownId = colors.Yellow,
    markdownIdDeclaration = colors.Red,
    markdownItalic = {fg = c.none, fmt = "italic"},
    markdownItalicDelimiter = {fg = c.sky_m, fmt = "italic"},
    markdownLinkDelimiter = colors.Grey,
    markdownLinkText = colors.Red,
    markdownLinkTextDelimiter = colors.Grey,
    markdownListMarker = colors.Red,
    markdownOrderedListMarker = colors.Red,
    markdownRule = colors.Purple,
    markdownUrl = {fg = c.blue, fmt = "underline"},
    markdownUrlDelimiter = colors.Grey,
    markdownUrlTitleDelimiter = colors.Green
}

hl.langs.php = {
    phpFunctions = {fg = c.fg, fmt = cfg.code_style.functions},
    phpMethods = colors.Cyan,
    phpStructure = colors.Purple,
    phpOperator = colors.Purple,
    phpMemberSelector = colors.Fg,
    phpVarSelector = {fg = c.orange, fmt = cfg.code_style.variables},
    phpIdentifier = {fg = c.orange, fmt = cfg.code_style.variables},
    phpBoolean = colors.Cyan,
    phpNumber = colors.Orange,
    phpHereDoc = colors.Green,
    phpNowDoc = colors.Green,
    phpSCKeyword = {fg = c.purple, fmt = cfg.code_style.keywords},
    phpFCKeyword = {fg = c.purple, fmt = cfg.code_style.keywords},
    phpRegion = colors.Blue
}

hl.langs.scala = {
    scalaNameDefinition = colors.Fg,
    scalaInterpolationBoundary = colors.Purple,
    scalaInterpolation = colors.Purple,
    scalaTypeOperator = colors.Red,
    scalaOperator = colors.Red,
    scalaKeywordModifier = {fg = c.red, fmt = cfg.code_style.keywords},
}

hl.langs.tex = {
    latexTSInclude = colors.Blue,
    latexTSFuncMacro = {fg = c.fg, fmt = cfg.code_style.functions},
    latexTSEnvironment = { fg = c.cyan, fmt = "bold" },
    latexTSEnvironmentName = colors.Yellow,
    texCmdEnv = colors.Cyan,
    texEnvArgName = colors.Yellow,
    latexTSTitle = colors.Green,
    latexTSType = colors.Blue,
    latexTSMath   = colors.Orange,
    texMathZoneX  = colors.Orange,
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
    vimVar = {fg = c.fg, fmt = cfg.code_style.variables},
    vimCommentTitle = {fg = c.sky_p, fmt = cfg.code_style.comments},
}

local lsp_kind_icons_color = {
    Default = c.purple,
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
    Keyword = c.cyan,
    Method = c.blue,
    Module = c.orange,
    Operator = c.red,
    Property = c.cyan,
    Reference = c.orange,
    Snippet = c.red,
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
    end

    vim_highlights(hl.common)
    vim_highlights(hl.syntax)
    vim_highlights(hl.treesitter)
    for _, group in pairs(hl.langs) do vim_highlights(group) end
    for _, group in pairs(hl.plugins) do vim_highlights(group) end

    -- user defined highlights: vim_highlights function cannot be used because it sets an attribute to none if not specified
    local function replace_color(prefix, color_name)
        if not color_name then return "" end
        if color_name:sub(1, 1) == '$' then
            local name = color_name:sub(2, -1)
            color_name = c[name]
            if not color_name then
                vim.schedule(function()
                    vim.notify('penumbra.nvim: unknown color "' .. name .. '"', vim.log.levels.ERROR, { title = "penumbra.nvim" })
                end)
                return ""
            end
        end
        return prefix .. "=" .. color_name
    end

    for group_name, group_settings in pairs(vim.g.penumbra_config.highlights) do
        vim.api.nvim_command(string.format("highlight %s %s %s %s %s", group_name,
            replace_color("guifg", group_settings.fg),
            replace_color("guibg", group_settings.bg),
            replace_color("guisp", group_settings.sp),
            replace_color("gui", group_settings.fmt)))
    end
end

return M
