local p = {
  fg              = '#e1e4e8',
  cursor_line     = '#1d2024',
  selected        = '#32353a',
  search          = '#543f5e',
  doc_highlight   = '#18243d',
  doc_highlight_w = '#3b414d',
  border          = '#272a2f',
  window_border   = '#FFFFFF',
  line_nr         = '#4f5158',
  line_nr_active  = '#e1e4e8',
  invisible       = '#555a63',
  text_muted      = '#838994',
  text_accent     = '#74ade8',

  error           = '#d07277',
  warning         = '#dec184',
  info            = '#74ade8',
  hint            = '#5a6f89',
  success         = '#a1c181',

  created         = '#34d058',
  created_bg      = '#222e1d',
  modified        = '#79b8ff',
  modified_bg     = '#41321d',
  deleted         = '#ea4a5a',
  deleted_bg      = '#301b1b',

  red             = '#f97583',
  enum            = '#d07277',
  purple          = '#b392f0',
  blue            = '#79b8ff',
  sky             = '#74ade8',
  orange          = '#bf956a',
  punct_special   = '#b1574b',
  comment         = '#6a737d',
  punct           = '#acb2be',
  bracket         = '#b2b9c6',
  escape          = '#878e98',
  preproc         = '#c8ccd4',
}

local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

local function apply()
  hl('Normal',         { fg = p.fg, bg = 'NONE' })
  hl('NormalNC',       { fg = p.fg, bg = 'NONE' })
  hl('NormalFloat',    { fg = p.fg, bg = 'NONE' })
  hl('FloatBorder',    { fg = p.window_border, bg = 'NONE' })
  hl('FloatTitle',     { fg = p.fg, bg = 'NONE' })
  hl('WinSeparator',   { fg = p.window_border, bg = 'NONE' })
  hl('VertSplit',      { fg = p.window_border, bg = 'NONE' })
  hl('EndOfBuffer',    { fg = p.fg, bg = 'NONE' })

  hl('LineNr',         { fg = p.line_nr, bg = 'NONE' })
  hl('CursorLineNr',   { fg = p.line_nr_active, bg = 'NONE', bold = true })
  hl('CursorLine',     { bg = p.cursor_line })
  hl('CursorColumn',   { bg = p.cursor_line })
  hl('ColorColumn',    { bg = p.cursor_line })
  hl('SignColumn',     { bg = 'NONE' })
  hl('Folded',         { fg = p.text_muted, bg = 'NONE' })
  hl('FoldColumn',     { fg = p.text_muted, bg = 'NONE' })

  hl('Visual',         { bg = p.selected })
  hl('VisualNOS',      { bg = p.selected })
  hl('Search',         { bg = p.search, fg = p.fg })
  hl('IncSearch',      { bg = p.search, fg = p.fg })
  hl('CurSearch',      { bg = p.search, fg = p.fg, bold = true })
  hl('MatchParen',     { fg = p.orange, bold = true })

  hl('NonText',        { fg = p.invisible })
  hl('Whitespace',     { fg = p.invisible })
  hl('SpecialKey',     { fg = p.invisible })
  hl('Conceal',        { fg = p.text_muted })
  hl('Directory',      { fg = p.blue })
  hl('Title',          { fg = p.purple, bold = true })
  hl('Question',       { fg = p.blue })
  hl('MoreMsg',        { fg = p.blue })
  hl('ModeMsg',        { fg = p.fg })
  hl('WarningMsg',     { fg = p.warning })
  hl('ErrorMsg',       { fg = p.error })

  hl('Pmenu',          { fg = p.fg, bg = 'NONE' })
  hl('PmenuSel',       { fg = p.fg, bg = p.selected, bold = true })
  hl('PmenuSbar',      { bg = 'NONE' })
  hl('PmenuThumb',     { bg = p.border })
  hl('PmenuKind',      { fg = p.purple, bg = 'NONE' })
  hl('PmenuKindSel',   { fg = p.purple, bg = p.selected })
  hl('PmenuExtra',     { fg = p.text_muted, bg = 'NONE' })
  hl('PmenuExtraSel',  { fg = p.text_muted, bg = p.selected })
  hl('WildMenu',       { fg = p.fg, bg = p.selected })

  hl('StatusLine',     { fg = p.fg, bg = 'NONE' })
  hl('StatusLineNC',   { fg = p.text_muted, bg = 'NONE' })
  hl('TabLine',        { fg = p.text_muted, bg = 'NONE' })
  hl('TabLineSel',     { fg = p.fg, bg = 'NONE' })
  hl('TabLineFill',    { bg = 'NONE' })
  hl('WinBar',         { fg = p.fg, bg = 'NONE' })
  hl('WinBarNC',       { fg = p.text_muted, bg = 'NONE' })

  hl('DiffAdd',        { fg = p.created, bg = p.created_bg })
  hl('DiffChange',     { fg = p.modified, bg = p.modified_bg })
  hl('DiffDelete',     { fg = p.deleted, bg = p.deleted_bg })
  hl('DiffText',       { fg = p.fg, bg = p.modified_bg, bold = true })

  hl('SpellBad',       { sp = p.error, undercurl = true })
  hl('SpellCap',       { sp = p.warning, undercurl = true })
  hl('SpellLocal',     { sp = p.info, undercurl = true })
  hl('SpellRare',      { sp = p.hint, undercurl = true })

  hl('DiagnosticError',          { fg = p.error })
  hl('DiagnosticWarn',           { fg = p.warning })
  hl('DiagnosticInfo',           { fg = p.info })
  hl('DiagnosticHint',           { fg = p.hint })
  hl('DiagnosticOk',             { fg = p.success })
  hl('DiagnosticUnderlineError', { sp = p.error, undercurl = true })
  hl('DiagnosticUnderlineWarn',  { sp = p.warning, undercurl = true })
  hl('DiagnosticUnderlineInfo',  { sp = p.info, undercurl = true })
  hl('DiagnosticUnderlineHint',  { sp = p.hint, undercurl = true })
  hl('DiagnosticUnderlineOk',    { sp = p.success, undercurl = true })
  hl('DiagnosticSignError',      { fg = p.error })
  hl('DiagnosticSignWarn',       { fg = p.warning })
  hl('DiagnosticSignInfo',       { fg = p.info })
  hl('DiagnosticSignHint',       { fg = p.hint })
  hl('DiagnosticVirtualTextError', { fg = p.error })
  hl('DiagnosticVirtualTextWarn',  { fg = p.warning })
  hl('DiagnosticVirtualTextInfo',  { fg = p.info })
  hl('DiagnosticVirtualTextHint',  { fg = p.hint })

  hl('LspReferenceText',  { bg = p.doc_highlight })
  hl('LspReferenceRead',  { bg = p.doc_highlight })
  hl('LspReferenceWrite', { bg = p.doc_highlight_w })

  hl('GitSignsAdd',    { fg = p.created })
  hl('GitSignsChange', { fg = p.modified })
  hl('GitSignsDelete', { fg = p.deleted })

  hl('TelescopeNormal',        { fg = p.fg, bg = 'NONE' })
  hl('TelescopeBorder',        { fg = p.window_border, bg = 'NONE' })
  hl('TelescopePromptNormal',  { fg = p.fg, bg = 'NONE' })
  hl('TelescopePromptBorder',  { fg = p.window_border, bg = 'NONE' })
  hl('TelescopeResultsBorder', { fg = p.window_border, bg = 'NONE' })
  hl('TelescopePreviewBorder', { fg = p.window_border, bg = 'NONE' })
  hl('TelescopePromptTitle',   { fg = p.purple, bold = true })
  hl('TelescopePreviewTitle',  { fg = p.blue, bold = true })
  hl('TelescopeResultsTitle',  { fg = p.purple, bold = true })
  hl('TelescopeSelection',     { bg = p.selected })
  hl('TelescopeMatching',      { fg = p.orange, bold = true })
  hl('TelescopePromptPrefix',  { fg = p.red })

  hl('NeoTreeNormal',           { fg = p.fg, bg = 'NONE' })
  hl('NeoTreeNormalNC',         { fg = p.fg, bg = 'NONE' })
  hl('NeoTreeEndOfBuffer',      { fg = p.fg, bg = 'NONE' })
  hl('NeoTreeWinSeparator',     { fg = p.window_border, bg = 'NONE' })
  hl('NeoTreeVertSplit',        { fg = p.window_border, bg = 'NONE' })
  hl('NeoTreeFloatBorder',      { fg = p.window_border, bg = 'NONE' })
  hl('NeoTreeFloatTitle',       { fg = p.fg, bg = 'NONE' })
  hl('NeoTreeTitleBar',         { fg = p.fg, bg = 'NONE' })
  hl('NeoTreeStatusLine',       { fg = p.fg, bg = 'NONE' })
  hl('NeoTreeStatusLineNC',     { fg = p.text_muted, bg = 'NONE' })
  hl('NeoTreeCursorLine',       { bg = p.cursor_line })
  hl('NeoTreeSignColumn',       { bg = 'NONE' })
  hl('NeoTreeRootName',         { fg = p.purple, bold = true })
  hl('NeoTreeDirectoryName',    { fg = p.fg })
  hl('NeoTreeDirectoryIcon',    { fg = '#FFFFFF' })
  hl('NeoTreeFileName',         { fg = p.fg })
  hl('NeoTreeFileNameOpened',   { fg = p.fg })
  hl('NeoTreeFileIcon',         { fg = '#FFFFFF' })
  hl('NeoTreeIndentMarker',     { fg = p.invisible })
  hl('NeoTreeExpander',         { fg = '#FFFFFF' })
  hl('NeoTreeDotfile',          { fg = p.text_muted })
  hl('NeoTreeHiddenByName',     { fg = p.text_muted })
  hl('NeoTreeWindowsHidden',    { fg = p.text_muted })
  hl('NeoTreeDimText',          { fg = p.text_muted })
  hl('NeoTreeFilterTerm',       { fg = p.orange })
  hl('NeoTreeSymbolicLinkTarget', { fg = p.sky })
  hl('NeoTreeGitAdded',         { fg = p.created })
  hl('NeoTreeGitModified',      { fg = p.modified })
  hl('NeoTreeGitDeleted',       { fg = p.deleted })
  hl('NeoTreeGitConflict',      { fg = p.warning })
  hl('NeoTreeGitUntracked',     { fg = p.info })
  hl('NeoTreeGitIgnored',       { fg = p.text_muted })
  hl('NeoTreeGitStaged',        { fg = p.success })
  hl('NeoTreeGitUnstaged',      { fg = p.warning })

  hl('CmpItemAbbr',             { fg = p.fg })
  hl('CmpItemAbbrDeprecated',   { fg = p.text_muted, strikethrough = true })
  hl('CmpItemAbbrMatch',        { fg = p.orange, bold = true })
  hl('CmpItemAbbrMatchFuzzy',   { fg = p.orange, bold = true })
  hl('CmpItemMenu',             { fg = p.text_muted })
  hl('CmpItemKindFunction',     { fg = p.purple })
  hl('CmpItemKindMethod',       { fg = p.purple })
  hl('CmpItemKindConstructor',  { fg = p.blue })
  hl('CmpItemKindVariable',     { fg = p.fg })
  hl('CmpItemKindField',        { fg = p.blue })
  hl('CmpItemKindProperty',     { fg = p.blue })
  hl('CmpItemKindClass',        { fg = p.red })
  hl('CmpItemKindStruct',       { fg = p.red })
  hl('CmpItemKindInterface',    { fg = p.red })
  hl('CmpItemKindEnum',         { fg = p.enum })
  hl('CmpItemKindEnumMember',   { fg = p.blue })
  hl('CmpItemKindModule',       { fg = p.fg })
  hl('CmpItemKindKeyword',      { fg = p.red })
  hl('CmpItemKindText',         { fg = p.fg })
  hl('CmpItemKindSnippet',      { fg = p.orange })

  hl('IblIndent',     { fg = p.invisible })
  hl('IblWhitespace', { fg = p.invisible })

  hl('Comment',       { fg = p.comment })
  hl('Constant',      { fg = p.blue })
  hl('String',        { fg = p.blue })
  hl('Character',     { fg = p.blue })
  hl('Number',        { fg = p.blue })
  hl('Boolean',       { fg = p.orange })
  hl('Float',         { fg = p.blue })
  hl('Identifier',    { fg = p.fg })
  hl('Function',      { fg = p.purple })
  hl('Statement',     { fg = p.red })
  hl('Conditional',   { fg = p.red })
  hl('Repeat',        { fg = p.red })
  hl('Label',         { fg = p.sky })
  hl('Operator',      { fg = p.fg })
  hl('Keyword',       { fg = p.red })
  hl('Exception',     { fg = p.red })
  hl('PreProc',       { fg = p.preproc })
  hl('Include',       { fg = p.red })
  hl('Define',        { fg = p.red })
  hl('Macro',         { fg = p.purple })
  hl('PreCondit',     { fg = p.red })
  hl('Type',          { fg = p.red })
  hl('StorageClass',  { fg = p.red })
  hl('Structure',     { fg = p.red })
  hl('Typedef',       { fg = p.red })
  hl('Special',       { fg = p.orange })
  hl('SpecialChar',   { fg = p.escape })
  hl('Tag',           { fg = p.fg })
  hl('Delimiter',     { fg = p.bracket })
  hl('SpecialComment',{ fg = p.comment })
  hl('Debug',         { fg = p.red })
  hl('Underlined',    { underline = true })
  hl('Ignore',        { fg = p.text_muted })
  hl('Error',         { fg = p.error })
  hl('Todo',          { fg = p.warning, bold = true })

  hl('@variable',           { fg = p.fg })
  hl('@variable.parameter', { fg = p.fg })
  hl('@operator',           { fg = p.fg })
  hl('@tag',                { fg = p.fg })

  hl('@keyword',            { fg = p.red })
  hl('@type',               { fg = p.red })
  hl('@type.builtin',       { fg = p.red })
  hl('@keyword.type',       { fg = p.red })
  hl('@type.enum',          { fg = p.enum })

  hl('@function',             { fg = p.purple })
  hl('@function.call',        { fg = p.purple })
  hl('@function.method',      { fg = p.purple })
  hl('@function.method.call', { fg = p.purple })

  hl('@string',          { fg = p.blue })
  hl('@number',          { fg = p.blue })
  hl('@number.float',    { fg = p.blue })
  hl('@character',       { fg = p.blue })
  hl('@constant',        { fg = p.blue })
  hl('@property',        { fg = p.blue })
  hl('@variable.member', { fg = p.blue })
  hl('@constructor',     { fg = p.blue })

  hl('@attribute', { fg = p.sky })
  hl('@label',     { fg = p.sky })

  hl('@boolean',                { fg = p.orange })
  hl('@variable.builtin',       { fg = p.orange })
  hl('@constant.builtin',       { fg = p.orange })
  hl('@string.regexp',          { fg = p.orange })
  hl('@string.special',         { fg = p.orange })
  hl('@string.special.symbol',  { fg = p.orange })

  hl('@string.escape', { fg = p.escape })

  hl('@punctuation',           { fg = p.punct })
  hl('@punctuation.bracket',   { fg = p.bracket })
  hl('@punctuation.delimiter', { fg = p.bracket })
  hl('@punctuation.special',   { fg = p.punct_special })

  hl('@comment',               { fg = p.comment })
  hl('@comment.documentation', { fg = p.comment })

  hl('@lsp.type.variable',   { fg = p.fg })
  hl('@lsp.type.parameter',  { fg = p.fg })
  hl('@lsp.type.namespace',  { fg = p.fg })
  hl('@lsp.type.type',       { fg = p.red })
  hl('@lsp.type.class',      { fg = p.red })
  hl('@lsp.type.struct',     { fg = p.red })
  hl('@lsp.type.interface',  { fg = p.red })
  hl('@lsp.type.enum',       { fg = p.enum })
  hl('@lsp.type.enumMember', { fg = p.blue })
  hl('@lsp.type.property',   { fg = p.blue })
  hl('@lsp.type.function',   { fg = p.purple })
  hl('@lsp.type.method',     { fg = p.purple })
  hl('@lsp.type.macro',      { fg = p.purple })
end

vim.cmd('hi clear')
if vim.g.syntax_on then
  vim.cmd('syntax reset')
end
vim.g.colors_name = 'zed_pitch'

vim.api.nvim_create_autocmd('ColorScheme', { callback = apply })
apply()
