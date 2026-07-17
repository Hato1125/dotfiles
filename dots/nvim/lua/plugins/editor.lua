return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    event = {
      'BufReadPre',
      'BufNewFile',
    },
    config = function()
      require('nvim-treesitter').install({
        'bash',
        'markdown',
        'kotlin',
        'c',
        'cpp',
        'rust',
        'glsl',
        'cmake',
        'css',
        'html',
        'javascript',
        'typescript',
        'dart',
        'json',
        'toml',
        'xml',
        'dockerfile',
        'doxygen',
        'angular',
        'python',
        'lua',
        'gitignore',
        'gitcommit',
        'gitattributes',
      },
      {
        force = false,
        generate = true,
        max_jobs = 8,
      }
    )

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(ev)
          pcall(vim.treesitter.start, ev.buf)
        end,
      })
    end
  },
  {
    'saghen/blink.cmp',
    dependencies = {
      'saghen/blink.lib',
      'rafamadriz/friendly-snippets',
    },
    init = function()
      local function set_border_background()
        local normal = vim.api.nvim_get_hl(0, { name = 'Normal', link = false })
        local border = vim.api.nvim_get_hl(0, { name = 'FloatBorder', link = false })
        local background = normal.bg or 'NONE'
        local border_highlight = {
          fg = border.fg,
          bg = background,
        }

        for _, group in ipairs({
          'BlinkCmpMenuBorder',
          'BlinkCmpDocBorder',
          'BlinkCmpSignatureHelpBorder',
        }) do
          vim.api.nvim_set_hl(0, group, border_highlight)
        end

        for group, source in pairs({
          BlinkCmpMenu = 'Pmenu',
          BlinkCmpDoc = 'NormalFloat',
          BlinkCmpDocSeparator = 'NormalFloat',
          BlinkCmpSignatureHelp = 'NormalFloat',
        }) do
          local source_highlight = vim.api.nvim_get_hl(0, { name = source, link = false })
          vim.api.nvim_set_hl(0, group, {
            fg = source_highlight.fg or normal.fg,
            bg = background,
          })
        end
      end

      vim.api.nvim_create_autocmd('ColorScheme', {
        group = vim.api.nvim_create_augroup('BlinkCmpBorderBackground', { clear = true }),
        callback = set_border_background,
      })
      set_border_background()
    end,
    build = function()
      require('blink.cmp').build():pwait()
    end,
    opts = {
      keymap = {
        preset = 'default',
        ['<Tab>'] = { 'select_and_accept', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
        ['<Up>'] = { 'select_prev', 'fallback' },
      },
      completion = {
        menu = {
          border = 'rounded',
        },
        documentation = {
          auto_show = false,
          window = {
            border = 'rounded',
          },
        },
      },
      sources = {
        default = {
          'lsp',
          'path',
          'snippets',
          'buffer'
        },
      },
      fuzzy = {
        implementation = 'rust',
      },
    },
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
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
    event = 'BufReadPost',
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
