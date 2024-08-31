return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    cmd = 'Telescope',
    keys = {
      { '<leader>ff', ':Telescope find_files<return>', desc = 'Find files' },
      { '<leader>fg', ':Telescope live_grep<return>', desc = 'Live grep' },
    },
    config = function()
      require('telescope').setup {
        extensions = {
          file_browser = {
            grouped = true
          }
        },
        pickers = {
          find_files = {
            hidden = true
          }
        },
        defaults = {
          sorting_strategy = 'ascending',
          layout_config = {
            prompt_position = 'top'
          }
        }
      }
    end
  },
  {
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim'
    },
    keys = {
      { '<leader>fb', ':Telescope file_browser<return>', desc = 'File browser' }
    },
    config = function()
      require('telescope').load_extension 'file_browser'
    end
  }
}