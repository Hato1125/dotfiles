return {
  {
    'LelouchHe/xmake-luals-addon',
    lazy = true,
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        'lazy.nvim',
        'LazyVim',
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { path = 'LazyVim', words = { 'LazyVim' } },
        { path = 'xmake-luals-addon/library', words = { 'xmake' } },
      },
    },
  },
  {
    'https://git.sr.ht/~p00f/clangd_extensions.nvim',
    ft = {
      'c',
      'cpp',
    },
    opts = {},
    keys = {
      {
        '<leader>ch',
        '<cmd>ClangdTypeHierarchy<CR>',
        desc = 'Show C/C++ type hierarchy',
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'saghen/blink.cmp',
      'folke/lazydev.nvim',
      'MunifTanjim/nui.nvim',
    },
    event = {
      'BufReadPre',
      'BufNewFile',
    },
    opts = {
      servers = {
        clangd = {
          cmd = {
            'clangd',
            '--background-index',
            '--clang-tidy',
            '--header-insertion=iwyu',
            '--completion-style=detailed',
          },
          cmd_env = {
            XDG_CONFIG_HOME = vim.fn.stdpath('config'),
          },
        },
        ruff = {
          on_attach = function(client)
            client.server_capabilities.hoverProvider = false
          end,
        },
      },
    },
    config = function(_, opts)
      require('mason').setup {
        ui = {
          border = 'rounded'
        }
      }

      local lspconfig = require('lspconfig')
      local mason_lspconfig = require('mason-lspconfig')
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      mason_lspconfig.setup {
        ensure_installed = {
          'lua_ls',
          'ts_ls',
          'angularls',
          'bacon_ls',
          'rust_analyzer',
          'bashls',
          'tombi',
          'yamlls',
          'clangd',
          'neocmake',
          'cssls',
          'html',
          'biome',
          'intelephense',
          'basedpyright',
          'ruff',
          'dockerls',
          'glsl_analyzer',
        },
        handlers = {
          function(name)
            lspconfig[name].setup(vim.tbl_deep_extend(
              'force',
              { capabilities = capabilities },
              opts.servers and opts.servers[name] or {}
            ))
          end
        },
      }

      require('features.cpp.init').setup()
    end
  },
}
