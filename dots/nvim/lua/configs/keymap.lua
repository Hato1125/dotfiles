local map = vim.keymap.set

vim.g.mapleader = ' '

map('i', 'jk', '<ESC>')

map('n', '<leader>h', '<C-w>h')
map('n', '<leader>l', '<C-w>l')
map('n', '<leader>j', '<C-w>j')
map('n', '<leader>k', '<C-w>k')

map('n', '<leader>ss', ':split<CR>')
map('n', '<leader>sv', ':vsplit<CR>')

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
