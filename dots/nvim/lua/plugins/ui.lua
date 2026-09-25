return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    },
    lazy = true,
    keys = {
      { '<leader>fb', '<cmd>Neotree left selector=false<CR>' },
    },
    config = function()
      require('neo-tree').setup({
        filesystem = {
          use_libuv_file_watcher = true,
        },
      })
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    config = function()
      local scheme = {
        a = { fg = '#000000', bg = '#ffffff', gui = 'bold' },
        b = { fg = '#000000', bg = '#ffffff' },
        c = { fg = '#000000', bg = '#ffffff' },
      }

      require('lualine').setup {
        options = {
          disabled_filetypes = {
            'alpha',
            'neo-tree',
            'snacks_terminal',
          },
          theme = {
            normal = scheme,
            insert = scheme,
            visual = scheme,
            replace = scheme,
            inactive = scheme,
          },
          section_separators = '',
          component_separators = '',
          extensions = {},
        },
        sections = {
          lualine_c = { 'filename' },
          lualine_x = {},
        },
        winbar = {},
        inactive_winbar = {},
      }
    end
  },
  {
    'IogaMaster/neocord',
    event = 'VeryLazy',
    config = function()
      require('neocord').setup {
        logo = os.getenv('NVIM_DISCORD_RPC_LOGO_URL'),
        client_id = os.getenv('NVIM_DISCORD_RPC_CLIENT_ID'),
      }
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    lazy = true,
    keys = {
      { '<leader>ff', function() require('telescope.builtin').find_files() end },
      { '<leader>fg', function() require('telescope.builtin').live_grep() end },
      { '<leader>fr', function() require('telescope.builtin').lsp_references() end },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          layout_strategy = 'flex',
          layout_config = {
            horizontal = {
              width = 0.90,
              height = 0.85,
              preview_width = 0.6,
            },
          },
          borderchars = {
            results = { '─', '│', ' ', '│', '╭', '┬', '│', '│' },
            prompt = { '─', '│', '─', '│', '├', '┤', '┴', '╰' },
            preview = { '─', '│', '─', ' ', '─', '╮', '╯', '─' },
          },
        },
        pickers = {
          lsp_references = { show_line = false },
          live_grep = { show_line = false },
          grep_string = { show_line = false },
        },
      }

      vim.api.nvim_create_autocmd('User', {
        pattern = 'TelescopePreviewerLoaded',
        callback = function(args)
          vim.wo.number = args.data.filetype ~= 'help'
        end,
      })
    end
  },
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    keys = {
      { '<leader>aa', '<cmd>1ToggleTerm direction=vertical<CR>' },
      { '<leader>\\', '<cmd>2ToggleTerm direction=horizontal<CR>' },
    },
    opts = {
      on_open = function(term)
        if term.direction == 'vertical' then
          vim.cmd('wincmd L')
        elseif term.direction == 'horizontal' then
          vim.cmd('wincmd J')
        end
      end,
    },
  }
}
