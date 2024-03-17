vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'Pocco81/auto-save.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'goolord/alpha-nvim'
  use 'sainnhe/everforest'
  use 'norcalli/nvim-colorizer.lua'
  use 'ramojus/mellifluous.nvim'
  use 'xiyaowong/transparent.nvim'
  use 'christianchiarulli/nvcode-color-schemes.vim'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make'
  }
  use {
    'nvim-telescope/telescope-file-browser.nvim',
    requires = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' }
  }
  use {
    'neoclide/coc.nvim',
    branch = 'release'
  }
  use {
    'akinsho/toggleterm.nvim',
    tag = '*'
  }
end)
