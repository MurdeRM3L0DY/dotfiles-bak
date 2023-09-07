---@diagnostic disable: undefined-global

local lush = require('lush')
local hsl = lush.hsl

local C = R('utils.palette') ---@module 'utils.palette'

-- local colorblind = {
--   subtext1 = hsl(228, 41, 79),
--   subtext0 = hsl(227, 29, 71),
--   surface2 = hsl(233, 13, 39), -- Surface2 (hsl '#565970'),
--   surface1 = hsl(232, 15, 31), -- Surface1 (hsl '#43465A'),
--   surface0 = hsl(237, 16, 23), -- Surface0 (hsl '#313244'),
--
--   flamingo = hsl(0, 100, 85),
--   foreground = hsl(230, 65, 85),
--   background = hsl(230, 30, 5),
--
--   red = hsl(345, 80, 50),
--   pink = hsl(330, 100, 50),
--   peach = hsl(5, 100, 70),
--
--   blue = hsl(230, 100, 60),
--   purple = hsl(270, 100, 50),
--
--   green = hsl(160, 100, 60),
--   yellow = hsl(60, 100, 85),
--
--   sky = hsl(220, 100, 75),
--   lavender = hsl(260, 80, 70),
-- }

-- local catppuccin = {
--   overlay2 = hsl(229, 20, 63), -- Overlay2 (hsl '#8E95B3'),
--   overlay1 = hsl(229, 15, 55), -- Overlay1 (hsl '#7B819D'),
--   overlay0 = hsl(232, 12, 47), -- Overlay0 (hsl '#696D86'),
--   surface2 = hsl(233, 13, 39), -- Surface2 (hsl '#565970'),
--   surface1 = hsl(232, 15, 31), -- Surface1 (hsl '#43465A'),
--   surface0 = hsl(237, 16, 23), -- Surface0 (hsl '#313244'),
--
--   base = hsl(240, 21, 15), -- Base (hsl '#1E1E2E'),
--   mantle = hsl(240, 21, 12), -- Mantle (hsl '#181825'),
--   crust = hsl(240, 23, 9), -- Crust (hsl '#11111B'),
-- }

-- local C = {
--   BASE00 = hsl(270, 30, 5),
--   BASE01 = hsl(240, 21, 15),
--   BASE02 = hsl(243, 35, 20),
--   BASE03 = hsl(229, 15, 55), -- Overlay1 (hsl '#7B819D'),
--   BASE04 = hsl(229, 20, 63), -- Overlay2 (hsl '#8E95B3'),
--   -- BASE04 = hsl(232, 15, 31), -- Surface1 (hsl '#43465A'),
--   BASE05 = hsl(230, 65, 85),
--   BASE06 = hsl(220, 100, 75),
--   BASE07 = hsl(260, 80, 70),
--
--   BASE08 = hsl(0, 100, 85),
--   BASE09 = hsl(5, 100, 70),
--   BASE0A = hsl(60, 100, 85),
--   BASE0B = hsl(160, 100, 60),
--   BASE0C = hsl(345, 80, 50),
--   BASE0D = hsl(230, 100, 60),
--   BASE0E = hsl(270, 100, 50),
--   BASE0F = hsl(330, 100, 50),
-- }

vim.g.colors_name = 'lush'
vim.opt.termguicolors = true

vim.g.terminal_color_0 = C.BASE00.hex
vim.g.terminal_color_8 = C.BASE03.hex -- suggestions

vim.g.terminal_color_1 = C.BASE08.hex -- error
vim.g.terminal_color_9 = C.BASE09.hex

vim.g.terminal_color_2 = C.BASE0B.hex -- ok
vim.g.terminal_color_10 = C.BASE01.hex

vim.g.terminal_color_3 = C.BASE0A.hex -- warn
vim.g.terminal_color_11 = C.BASE02.hex

vim.g.terminal_color_4 = C.BASE0D.hex
vim.g.terminal_color_12 = C.BASE04.hex

vim.g.terminal_color_5 = C.BASE0E.hex -- strings
vim.g.terminal_color_13 = C.BASE06.hex

vim.g.terminal_color_6 = C.BASE0C.hex -- dashed args
vim.g.terminal_color_14 = C.BASE0F.hex

vim.g.terminal_color_7 = C.BASE05.hex
vim.g.terminal_color_15 = C.BASE07.hex

local e = lush(function(utils)
  local sym = utils.sym

  return {
    Normal { fg = C.BASE05, bg = C.BASE00 },
    ColorColumn { bg = C.BASE03 },
    Conceal { fg = C.BASE03 },
    Cursor { bg = C.BASE00, fg = C.BASE08 },
    CursorColumn { bg = C.BASE01 },
    CursorLine { bg = C.BASE01 },
    CursorLineNr { fg = C.BASE04 },
    Directory { fg = C.BASE0D },
    ErrorMsg { fg = C.BASE0C, bold = true, italic = true },
    FloatBorder { fg = C.BASE07 },
    FoldColumn { fg = C.BASE03, italic = true },
    Folded { bg = C.BASE03 },
    IncSearch { fg = C.BASE00, bg = C.BASE08 },
    LineNr { CursorLineNr },
    MatchParen { bg = C.BASE02, underline = true },
    NonText { fg = C.BASE04 },
    NormalFloat { bg = C.BASE00 },
    OnYank { bg = C.BASE02, bold = true },
    Pmenu { fg = C.BASE04, bg = C.BASE01 },
    PmenuSel { bg = C.BASE05, fg = C.BASE02, bold = true },
    PmenuSbar { bg = C.BASE06 },
    PmenuThumb { fg = C.BASE00, bg = C.BASE07 },
    Question { fg = C.BASE0E },
    QuickFixLine { bg = C.BASE0B, fg = C.BASE00, bold = true },
    Search { IncSearch },
    SignColumn { bg = C.BASE00 },
    SpecialKey { fg = C.BASE03 },
    SpellBad { sp = C.BASE0C, undercurl = true },
    SpellRare { sp = C.BASE0B, undercurl = true },
    SpellCap { sp = C.BASE0A, undercurl = true },
    SpellLocal { sp = C.BASE07, undercurl = true },
    StatusLine { fg = C.BASE05, bg = C.BASE02 },
    StatusLineNC { fg = C.BASE03, bg = C.BASE02 },
    Substitute { IncSearch },
    TabLine { fg = C.BASE04, bg = C.BASE01 },
    TabLineFill { TabLine },
    TabLineSel { bg = C.BASE06, fg = C.BASE00 },
    Title { fg = C.BASE0D },
    VertSplit { fg = C.BASE02 },
    Visual { bg = C.BASE02, bold = true },
    -- Visualnos { Visual },
    WarningMsg { fg = C.BASE0C },
    WildMenu { bg = C.BASE01, fg = C.BASE0B },
    WinSeparator { VertSplit, bold = true },

    -- git diff
    DiffAdd { bg = C.BASE0B.da(85) },
    DiffChange { bg = C.BASE0D.da(80) },
    DiffDelete { bg = C.BASE0F.da(80) },
    DiffText { bg = C.BASE0D.da(90) },

    -- vim.diagnostic
    DiagnosticError { fg = C.BASE0C.li(10), bold = true, italic = true },
    DiagnosticHint { fg = C.BASE0B.li(30).sa(50), bold = true, italic = true },
    DiagnosticInfo { fg = C.BASE0D.da(20), bold = true, italic = true },
    DiagnosticWarn { fg = C.BASE0A.sa(50), bold = true, italic = true },
    DiagnosticSignError { DiagnosticError },
    DiagnosticSignHint { DiagnosticHint },
    DiagnosticSignInfo { DiagnosticInfo },
    DiagnosticSignWarn { DiagnosticWarn },
    DiagnosticFloatingError { DiagnosticError },
    DiagnosticFloatingHint { DiagnosticHint },
    DiagnosticFloatingInfo { DiagnosticInfo },
    DiagnosticFloatingWarn { DiagnosticWarn },
    DiagnosticVirtualTextError { DiagnosticError, bg = C.BASE0C.da(80) },
    DiagnosticVirtualTextHint { DiagnosticHint, bg = C.BASE0B.da(85) },
    DiagnosticVirtualTextInfo { DiagnosticInfo, bg = C.BASE0D.da(85) },
    DiagnosticVirtualTextWarn { DiagnosticWarn, bg = C.BASE0A.da(90) },
    DiagnosticUnderlineError { sp = DiagnosticError.fg, undercurl = true },
    DiagnosticUnderlineHint { sp = DiagnosticHint.fg, undercurl = true },
    DiagnosticUnderlineInfo { sp = DiagnosticInfo.fg, undercurl = true },
    DiagnosticUnderlineWarn { sp = DiagnosticWarn.fg, undercurl = true },
    DiagnosticUnnecessary { DiagnosticUnderlineHint },

    -- vim.lsp
    LspReferenceText { bg = C.BASE08, fg = C.BASE00 },
    LspReferenceRead { bg = C.BASE07, fg = C.BASE00 },
    LspReferenceWrite { bg = C.BASE05, fg = C.BASE00 },
    LspCodeLens { fg = C.BASE04, bg = C.BASE01 },
    LspCodeLensSeparator { fg = C.BASE03 },
    LspSignatureActiveParameter { bg = C.BASE06, fg = C.BASE00, bold = true, italic = true },
  }
end)

local treesitter = lush(function(utils)
  local sym = utils.sym

  return {
    sym('@variable') { fg = C.BASE05 },
    sym('@variable.builtin') { fg = C.BASE05 },
    sym('@variable.parameter') { fg = C.BASE0F },
    sym('@variable.member') { fg = C.BASE0C, italic = true },

    sym('@constant') { fg = C.BASE09 },
    sym('@constant.builtin') { fg = C.BASE09, italic = true },
    sym('@constant.macro') { fg = C.BASE09, italic = true },

    sym('@module') { fg = C.BASE06, bold = true, italic = true },
    sym('@module.builtin') { fg = C.BASE06, bold = true, italic = true },
    sym('@label') { fg = C.BASE0C, italic = true },

    sym('@string') { fg = C.BASE0B },
    sym('@string.documentation') { fg = C.BASE0B },
    sym('@string.regexp') { fg = C.BASE0B },
    sym('@string.escape') { fg = C.BASE0B },
    sym('@string.special') { fg = C.BASE0B },
    sym('@string.special.symbol') { fg = C.BASE0B },
    sym('@string.special.url') { fg = C.BASE0B },
    sym('@string.special.path') { fg = C.BASE0B },

    sym('@character') { fg = C.BASE0B },
    sym('@character.special') { fg = C.BASE0B },

    sym('@boolean') { fg = C.BASE09 },
    sym('@number') { fg = C.BASE09 },
    sym('@number.float') { fg = C.BASE09 },

    sym('@type') { fg = C.BASE0A, bold = true, italic = true },
    sym('@type.builtin') { fg = C.BASE0A, bold = true, italic = true },
    sym('@type.definition') { fg = C.BASE0A, bold = true, italic = true },
    sym('@type.qualifier') { fg = C.BASE0A, bold = true, italic = true },

    sym('@attribute') { fg = C.BASE06, bold = true, italic = true },
    sym('@property') { fg = C.BASE0C, italic = true },

    sym('@function') { fg = C.BASE0D, italic = true },
    sym('@function.builtin') { fg = C.BASE0D, italic = true },
    sym('@function.call') { fg = C.BASE0D, italic = true },
    sym('@function.macro') { fg = C.BASE0D, italic = true },

    sym('@function.method') { fg = C.BASE0D, italic = true },
    sym('@function.method.call') { fg = C.BASE0D, italic = true },

    sym('@constructor') { fg = C.BASE0A },
    sym('@operator') { fg = C.BASE08 },

    sym('@keyword') { fg = C.BASE0E },
    sym('@keyword.function') { fg = C.BASE0E },
    sym('@keyword.coroutine') { fg = C.BASE0E },
    sym('@keyword.operator') { fg = C.BASE0E },
    sym('@keyword.import') { fg = C.BASE0E },
    sym('@keyword.storage') { fg = C.BASE0A, italic = true },
    sym('@keyword.repeat') { fg = C.BASE0E },
    sym('@keyword.return') { fg = C.BASE0E },
    -- sym('@keyword.debug') { fg = C.BASE0A, bold = true, italic = true },
    -- sym('@keyword.exception') { fg = C.BASE0A, bold = true, italic = true },

    sym('@keyword.conditional') { fg = C.BASE0E },
    sym('@keyword.conditional.ternary') { fg = C.BASE0E },

    sym('@keyword.directive') { fg = C.BASE0E },
    sym('@keyword.directive.define') { fg = C.BASE0E },

    sym('@punctuation.delimiter') { fg = C.BASE08 },
    sym('@punctuation.bracket') { fg = C.BASE08 },
    sym('@punctuation.special') { fg = C.BASE0A },

    sym('@comment') { fg = C.BASE03, italic = true },
    -- sym('@comment.documentation') { fg = C.BASE03, italic = true },

    -- sym('@comment.error') { fg = C.BASE03, italic = true },
    -- sym('@comment.warning') { fg = C.BASE03, italic = true },
    -- sym('@comment.hint') { fg = C.BASE03, italic = true },
    -- sym('@comment.info') { fg = C.BASE03, italic = true },
    -- sym('@comment.todo') { fg = C.BASE03, italic = true },

    -- sym('@markup.strong') {},
    -- sym('@markup.italic') {},
    -- sym('@markup.strikethrough') {},
    -- sym('@markup.underline') {},

    -- sym('@markup.heading') {},

    -- sym('@markup.quote') {},
    -- sym('@markup.math') {},
    -- sym('@markup.environment') {},

    -- sym('@markup.link') {},
    -- sym('@markup.link.label') {},
    -- sym('@markup.link.url') {},

    -- sym('@markup.raw') {},
    -- sym('@markup.raw.block') {},

    sym('@markup.list') { fg = C.BASE08 },
    -- sym('@markup.list.checked') { fg = C.BASE08 },
    -- sym('@markup.list.unchecked') { fg = C.BASE08 },

    -- sym('@diff.plus') {}
    -- sym('@diff.minus') {}
    -- sym('@diff.delta') {}

    sym('@tag') { fg = C.BASE0A, bold = true, italic = true },
    sym('@tag.attribute') { fg = C.BASE0C, italic = true },
    sym('@tag.delimiter') { fg = C.BASE0A, italic = true },

    sym('@namespace.builtin') { fg = C.BASE06, bold = true, italic = true },

    -- sym('@none') { fg = C.BASE0A, italic = true },
    -- sym('@conceal') { fg = C.BASE0A, italic = true },

    -- sym('@spell') { fg = C.BASE0A, italic = true },
    -- sym('@nospell') { fg = C.BASE0A, italic = true },

    -- sym('@annotation') { fg = C.BASE06, bold = true, italic = true },

    -- sym('@definition.parameter') { fg = C.BASE0F },
  }
end)

local lsp_semantic_tokens = lush(function(utils)
  local sym = utils.sym

  return {
    sym('@lsp.type.namespace') { fg = C.BASE06, bold = true, italic = true },
    -- sym '@lsp.type.interface' { fg = C.BASE0C, bold = true, italic = true },
    sym('@lsp.type.variable') { fg = C.BASE05 },
    sym('@lsp.type.parameter') { fg = C.BASE0F },
    sym('@lsp.type.label') { fg = C.BASE0C },
    sym('@lsp.type.string') { fg = C.BASE0B },
    sym('@lsp.type.keyword') { fg = C.BASE0E },
    sym('@lsp.type.lifetime') { fg = C.BASE0A, bold = true, italic = true },
    sym('@lsp.type.builtinType') { fg = C.BASE0A, bold = true, italic = true },
    sym('@lsp.type.macro') { fg = C.BASE07, italic = true },
    sym('@lsp.type.function') { fg = C.BASE0D, italic = true },
    sym('@lsp.type.number') { fg = C.BASE05 },
    sym('@lsp.type.method') { fg = C.BASE0D, italic = true },
    sym('@lsp.type.operator') { fg = C.BASE08 },
    sym('@lsp.type.punctuation') { fg = C.BASE08 },
    sym('@lsp.typemod.keyword.documentation') { fg = C.BASE0E },
    sym('@lsp.typemod.function.library') { fg = C.BASE0D, italic = true },
    sym('@lsp.typemod.macro.library') { fg = C.BASE07, italic = true },
    sym('@lsp.typemod.variable.constant') { fg = C.BASE09, italic = true },
    sym('@lsp.typemod.method.library') { fg = C.BASE0D, italic = true },
    sym('@lsp.typemod.generic.macro') { fg = C.BASE05 },
    sym('@lsp.typemod.struct.library') { fg = C.BASE0A, italic = true },
    sym('@lsp.typemod.enum.library') { fg = C.BASE0A, italic = true },
    sym('@lsp.typemod.selfKeyword.reference') { fg = C.BASE09, italic = true },
    sym('@lsp.typemod.enumMember.library') { fg = C.BASE09 },
    -- sym('@lsp.mod.attribute') { fg = C.BASE0C, italic = true },
    -- sym('@lsp.mod.library') { fg = C.BASE06, italic = true },
  }
end)

local builtin_syntax = lush(function(utils)
  local sym = utils.sym

  return {
    Error {},

    Comment { fg = C.BASE04, italic = true },

    Character { fg = C.BASE0B },
    String { fg = C.BASE0B },

    Boolean { fg = C.BASE09 },
    Constant { fg = C.BASE09 },
    Float { fg = C.BASE09 },
    Number { fg = C.BASE09 },

    Operator { fg = C.BASE08 },

    Function { fg = C.BASE0D, italic = true },

    Macro { fg = C.BASE07, italic = true },

    Exception { fg = C.BASE0C },
    Identifier { fg = C.BASE0C, italic = true },
    Label { fg = C.BASE0C },

    Conditional { fg = C.BASE0E },
    Define { fg = C.BASE0E },
    Include { fg = C.BASE0E },
    Keyword { fg = C.BASE0E },
    PreProc { fg = C.BASE0E },
    Repeat { fg = C.BASE0E },

    Tag { fg = C.BASE0A, bold = true, italic = true },
    Todo { fg = C.BASE0A },
    Type { fg = C.BASE0A, bold = true, italic = true },
    Typedef { fg = C.BASE0A, bold = true, italic = true },

    -- Ignore {},
    -- PreCondit {},
    Special { fg = C.BASE07 },
    -- SpecialChar { fg = C.BASE0F },
    Statement { fg = C.BASE06, italic = true },

    -- Underlined {},
  }
end)

local telescope = lush(function()
  return {
    TelescopeSelection { fg = C.BASE08, bold = true, italic = true },
    TelescopeSelectionCaret { TelescopeSelection },
    TelescopeMatching { fg = C.BASE0F, bold = true, italic = true },

    -- TelescopeMultiSelection {},

    TelescopePreviewNormal { e.Normal },
    TelescopePreviewTitle {
      bg = C.BASE06,
      fg = C.BASE00,
      bold = true,
      italic = true,
    },
    TelescopePreviewBorder { fg = TelescopePreviewTitle.bg },

    TelescopePromptNormal { bold = true, italic = true },
    TelescopePromptTitle {
      bg = C.BASE07,
      fg = C.BASE00,
      bold = true,
      italic = true,
    },
    TelescopePromptBorder { fg = TelescopePromptTitle.bg },
    -- TelescopePromptPrefix {},

    TelescopeResultsNormal { builtin_syntax.Comment },
    TelescopeResultsTitle {
      bg = C.BASE0B,
      fg = C.BASE00,
      bold = true,
      italic = true,
    },
    TelescopeResultsBorder { fg = TelescopeResultsTitle.bg },
  }
end)

local fzf = lush(function()
  return {
    FzfLuaSearch { fg = C.BASE08, bold = true, italic = true },
    FzfLuaTitle { bg = C.BASE07, fg = C.BASE00, bold = true, italic = true },
    FzfLuaBorder { e.FloatBorder },
    FzfLuaCursor { fg = C.BASE00, bg = C.BASE08 },
  }
end)

local cmp = lush(function()
  return {
    CmpItemAbbr { builtin_syntax.Comment },
    CmpItemAbbrDeprecated { fg = C.BASE04, strikethrough = true },
    CmpItemAbbrMatch { fg = C.BASE0F, bold = true, italic = true },
    CmpItemAbbrMatchFuzzy { fg = C.BASE08, bold = true, italic = true },
    CmpItemKind { fg = C.BASE0D },
    CmpItemMenu { fg = C.BASE06 },
  }
end)

local gitsigns = lush(function()
  return {
    GitSignsAdd { fg = C.BASE0B.da(20).sa(40), bold = true, italic = true },
    GitSignsChange { fg = C.BASE0A.da(20).sa(40), bold = true, italic = true },
    GitSignsDelete { fg = C.BASE0F.da(20).sa(40), bold = true, italic = true },
  }
end)

local noice = lush(function()
  return {
    NoicePopup { e.Normal },
    NoicePopupBorder { e.FloatBorder },
    NoiceCursor { fg = C.BASE00, bg = C.BASE08 },
  }
end)

local lsp_inlayhints = lush(function()
  return {
    LspInlayHint { fg = C.BASE04, bg = C.BASE02 },
  }
end)

local leap = lush(function()
  return {
    LeapLabelPrimary { bg = C.BASE0F, fg = C.BASE05 },
    LeapBackdrop { fg = C.BASE04 },
    LeapMatch { fg = C.BASE08, bg = C.BASE00 },
    -- LeapLabelSecondary {},
    -- LeapLabelSelected {},
  }
end)

local mini = lush(function()
  return {
    -- mini.indentscope
    MiniIndentscopeSymbol { fg = C.BASE08 },

    -- mini.pick
    MiniPickNormal { bg = C.BASE00 },
    MiniPickBorder { e.FloatBorder },
    MiniPickMatchRanges { fg = C.BASE08, bold = true, italic = true },
  }
end)

local lazy = lush(function()
  return {
    LazyNormal { e.Normal },
  }
end)

local flash = lush(function()
  return {
    FlashBackdrop { fg = C.BASE04 },
    -- FlashCursor { fg = C.BASE08, bg = C.BASE00 },
    -- FlashCurrent { bg = C.BASE0F, fg = C.BASE00 },
    FlashLabel { bg = C.BASE0F, fg = C.BASE05 },
    FlashMatch { bg = C.BASE0B, fg = C.BASE00 },
    -- FlashPromptIcon { e.Cursor },
  }
end)

local window_picker = lush(function()
  return {
    WindowPickerStatusLineNC { bg = C.BASE0F, fg = C.BASE05 },
  }
end)

return lush(lush.merge {
  e,
  builtin_syntax,
  treesitter,
  lsp_semantic_tokens,
  telescope,
  fzf,
  cmp,
  gitsigns,
  lsp_inlayhints,
  noice,
  leap,
  mini,
  lazy,
  flash,
  window_picker,
})
