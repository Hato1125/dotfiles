vim.opt.fileencoding = 'utf-8'
vim.opt.helplang = 'ja'
vim.opt.swapfile = false

vim.opt.clipboard:append({ 'unnamedplus' })

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.autoindent = false
vim.opt.smartindent = false

vim.opt.number = true
vim.opt.wrap = false
vim.opt.background = 'dark'
vim.opt.termguicolors = true

vim.g.nord_contrast = true
vim.g.nord_borders = false
vim.g.nord_disable_background = false
vim.g.nord_italic = false
vim.g.nord_uniform_diff_background = true
vim.g.nord_bold = false
vim.opt.termguicolors = true
vim.opt.list = true
vim.opt.listchars = {
  trail = '.',
}

vim.opt.laststatus = 2
vim.cmd[[colorscheme gruber]]

-- neovide configure.
if vim.g.neovide then
  vim.o.guifont = "Monaspace Radon semibold:e-subpixelantialias"

  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_refresh_rate = 144
  vim.g.neovide_show_border = true
  vim.g.neovide_confirm_quit = true
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_unlink_border_highlights = true
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_smooth_blink = false
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
  vim.g.neovide_padding_top = 25
  vim.g.neovide_padding_bottom = 10
  vim.g.neovide_padding_right = 10
  vim.g.neovide_padding_left = 10

  vim.opt.linespace = -1
end

require('plugins/init')
