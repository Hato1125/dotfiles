vim.opt.termguicolors = true

local theme_path = '/home/hato/Develop/hub/Hato1125/nvim-color-scheme'
if (vim.uv or vim.loop).fs_stat(theme_path) then
  vim.opt.runtimepath:prepend(theme_path)
end

require('hato_theme').setup({
  transparent = true,
})

vim.cmd.colorscheme(vim.g.hato_colorscheme or 'zed_pitch')
