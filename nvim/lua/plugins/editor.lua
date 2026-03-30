return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    build = ':TSUpdate',
    lazy = true,
    event = {
      'BufReadPre',
      'BufNewFile',
    },
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'c',
          'cpp',
          'cmake',
          'json',
          'lua',
          'rust',
          'zig'
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true
        }
      }
    end
  },
  {
    'hrsh7th/nvim-cmp',
    lazy = true,
    event = {
      'InsertEnter',
      'CmdlineEnter',
    },
    config = function()
      local cmp = require('cmp')

      cmp.setup {
        window = {
          completion = cmp.config.window.bordered({
            border = 'rounded',
          }),
          documentation = cmp.config.window.bordered({
            border = 'rounded',
          }),
        },
        mapping = cmp.mapping.preset.insert({
          ['<Tab>'] = cmp.mapping.confirm({ select = true }),
          ['<Down>'] = cmp.mapping.select_next_item(),
          ['<Up>'] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
        }, {
          { name = 'buffer' },
        }),
      }
    end
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    lazy = true,
    event = {
      'BufReadPre',
      'BufNewFile',
    },
    config = function()
      local highlight = {
        'IblScope',
      }

      local hooks = require('ibl.hooks')

      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, 'IblScope', { fg = '#D29922' })
      end)
      
      require('ibl').setup({
        indent = {
          char = '▏',
        },
        scope = {
          enabled = true,
          show_start = false,
          show_end = false,
          highlight = highlight,
        },
      })
    end
  },
  {
    'coder/claudecode.nvim',
    dependencies = {
      'folke/snacks.nvim',
    },
    opts = {
      terminal = {
        split_side = 'right',
      },
    },
    lazy = true,
    keys = {
      { '<leader>ac', '<cmd>ClaudeCode<cr>', desc = 'Toggle Claude' },
      { '<leader>af', '<cmd>ClaudeCodeFocus<cr>', desc = 'Focus Claude' },
      { '<leader>ar', '<cmd>ClaudeCode --resume<cr>', desc = 'Resume Claude' },
      { '<leader>aC', '<cmd>ClaudeCode --continue<cr>', desc = 'Continue Claude' },
      { '<leader>am', '<cmd>ClaudeCodeSelectModel<cr>', desc = 'Select Claude model' },
      { '<leader>ab', '<cmd>ClaudeCodeAdd %<cr>', desc = 'Add current buffer' },
      { '<leader>as', '<cmd>ClaudeCodeSend<cr>', mode = 'v', desc = 'Send to Claude' },
      { '<leader>as', '<cmd>ClaudeCodeTreeAdd<cr>', desc = 'Add file', ft = { 'neo-tree' } },
      { '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', desc = 'Accept diff' },
      { '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', desc = 'Deny diff' },
    },
  },
  {
    'Mythos-404/xmake.nvim',
    version = '^3',
    lazy = true,
    event = "BufReadPost",
    config = true,
    opts = {
      on_save = {
        lsp_compile_commands = {
          enable = false
        }
      },
    },
  },
}
