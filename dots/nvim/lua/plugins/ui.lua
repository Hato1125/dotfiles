return {
  {
    'projekt0n/github-nvim-theme',
  },
  {
    'xiyaowong/transparent.nvim',
    config = function()
      vim.cmd('colorscheme github_dark')

      require('transparent').setup {
        extra_groups = {
          'NormalFloat',
          'WinSeparator',
          'StatusLine',
          'StatusLineNC',
          'NeoTreeCursorLine',
          'NeoTreeDimText',
          'NeoTreeDirectoryIcon',
          'NeoTreeDirectoryName',
          'NeoTreeDotfile',
          'NeoTreeFileIcon',
          'NeoTreeFileName',
          'NeoTreeFileNameOpene',
          'NeoTreeFilterTerm',
          'NeoTreeFloatBorder',
          'NeoTreeFloatTitle',
          'NeoTreeTitleBar',
          'NeoTreeGitAdded',
          'NeoTreeGitConflict',
          'NeoTreeGitDeleted',
          'NeoTreeGitIgnored',
          'NeoTreeGitModified',
          'NeoTreeGitUnstaged',
          'NeoTreeGitUntracke',
          'NeoTreeGitStaged',
          'NeoTreeHiddenByName',
          'NeoTreeIndentMarker',
          'NeoTreeExpander',
          'NeoTreeNormal',
          'NeoTreeNormalNC',
          'NeoTreeSignColumn',
          'NeoTreeStatusLine',
          'NeoTreeStatusLineNC',
          'NeoTreeVertSplit',
          'NeoTreeWinSeparator',
          'NeoTreeEndOfBuffer',
          'NeoTreeRootName',
          'NeoTreeSymbolicLinkTarget',
          'NeoTreeTitleBar',
          'NeoTreeWindowsHidden',
        },
      }

      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.cmd([[
            highlight NeoTreeNormal guibg=NONE ctermbg=NONE
            highlight NeoTreeNormalNC guibg=NONE ctermbg=NONE
            highlight NeoTreeEndOfBuffer guibg=NONE ctermbg=NONE
            highlight NeoTreeWinSeparator guibg=NONE ctermbg=NONE
            highlight FloatBorder guifg=#FFFFFF guibg=NONE
            highlight WinSeparator guifg=#FFFFFF guibg=NONE
            highlight VertSplit guifg=#FFFFFF guibg=NONE
          ]])
        end,
      })

      vim.cmd('TransparentEnable')
    end
  },
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
  },
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        options = {
          disabled_filetypes = { 'alpha', 'neo-tree', 'snacks_terminal' },
          theme = {
            normal = {
              a = { fg = '#000000', bg = '#ffffff', gui = 'bold' },
              b = { fg = '#000000', bg = '#ffffff' },
              c = { fg = '#000000', bg = '#ffffff' },
            },
            insert = {
              a = { fg = '#000000', bg = '#ffffff', gui = 'bold' },
              b = { fg = '#000000', bg = '#ffffff' },
              c = { fg = '#000000', bg = '#ffffff' },
            },
            visual = {
              a = { fg = '#000000', bg = '#ffffff', gui = 'bold' },
              b = { fg = '#000000', bg = '#ffffff' },
              c = { fg = '#000000', bg = '#ffffff' },
            },
            replace = {
              a = { fg = '#000000', bg = '#ffffff', gui = 'bold' },
              b = { fg = '#000000', bg = '#ffffff' },
              c = { fg = '#000000', bg = '#ffffff' },
            },
            inactive = {
              a = { fg = '#000000', bg = '#ffffff', gui = 'bold' },
              b = { fg = '#000000', bg = '#ffffff' },
              c = { fg = '#000000', bg = '#ffffff' },
            },
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
    }
  }
}
