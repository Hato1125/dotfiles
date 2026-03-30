return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        'lazy.nvim',
        'LazyVim',
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { path = 'LazyVim', words = { 'LazyVim' } },
        { path = 'xmake-luals-addon/library', files = { 'xmake.lua' } },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'folke/lazydev.nvim',
    },
    lazy = true,
    event = {
      'BufReadPre',
      'BufNewFile',
    },
    opts = {
    },
    config = function(_, opts)
      require('mason').setup {
        ui = {
          border = 'rounded'
        }
      }

      local lspconfig = require('lspconfig')
      local mason_lspconfig = require('mason-lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      mason_lspconfig.setup {
        ensure_installed = {
          'lua_ls',
          'ts_ls',
          'bacon_ls',
          'bashls',
          'tombi',
          'yamlls',
          'clangd',
          'cmake',
          'cssls',
          'html',
          'biome',
          'intelephense',
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
    end
  },
}
