local colors = {
  color0   = '#00000000',
  color2   = '#161821',
  color3   = '#b4be82',
  color4   = '#c6c8d1',
  color5   = '#2e313f',
  color8   = '#e2a478',
  color9   = '#3e445e',
  color10  = '#0f1117',
  color11  = '#17171b',
  color12  = '#818596',
  color15  = '#84a0c6',
}

local custom_iceberg_dark = {
  visual = {
    a = { fg = colors.color2, bg = colors.color3, gui = 'bold' },
    b = { fg = colors.color4, bg = colors.color5 },
  },
  replace = {
    a = { fg = colors.color2, bg = colors.color8, gui = 'bold' },
    b = { fg = colors.color4, bg = colors.color5 },
  },
  inactive = {
    a = { fg = colors.color9, bg = colors.color0, gui = 'bold' },
    b = { fg = colors.color9, bg = colors.color0 },
    c = { fg = colors.color9, bg = colors.color0 },
  },
  normal = {
    a = { fg = colors.color11, bg = colors.color12, gui = 'bold' },
    b = { fg = colors.color4, bg = colors.color5 },
    c = { fg = colors.color4, bg = colors.color0 },
  },
  insert = {
    a = { fg = colors.color2, bg = colors.color15, gui = 'bold' },
    b = { fg = colors.color4, bg = colors.color5 },
  },
}

require('lualine').setup {
  options = {
    theme = custom_iceberg_dark,
    component_separators = '|',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {
      { 'mode', separator = { left = '' }, '' },
    },
    lualine_b = { 'filename', 'branch' },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { 'filetype', 'progress' },
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
}
