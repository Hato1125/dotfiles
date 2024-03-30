local builtin = require('telescope.builtin')
local opts = {
  noremap = true,
  silent = true
}

-- leader
vim.g.mapleader = ' '

-- change mode
vim.keymap.set('i', 'jk', '<esc>', opts)

-- split window
vim.keymap.set('n', 'sv', ':vsplit<Return>', opts)
vim.keymap.set('n', 'ss', ':split<Return>', opts)

-- move window
vim.keymap.set('n', '<leader>h', '<C-w>h')
vim.keymap.set('n', '<leader>j', '<C-w>j')
vim.keymap.set('n', '<leader>k', '<C-w>k')
vim.keymap.set('n', '<leader>l', '<C-w>l')

-- telescope
vim.keymap.set('n', '<leader>ff', builtin.find_files, opts)
vim.keymap.set('n', '<leader>fg', builtin.git_files, opts)
vim.keymap.set('n', '<leader>fb', ':Telescope file_browser<CR>', opts)

-- coc
vim.keymap.set('n', 'gd', '<Plug>(coc-definition)', { silent = true })
