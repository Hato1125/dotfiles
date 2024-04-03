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
vim.opt.laststatus = 2

vim.wo.cursorline = true

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

vim.cmd[[colorscheme gruber]]

if vim.g.neovide then
  require('neovide')
end

require('plugins/init')
