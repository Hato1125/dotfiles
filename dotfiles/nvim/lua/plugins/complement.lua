return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp'
    },
    config = function()
      local cmp = require 'cmp'
      local map = cmp.mapping

      cmp.setup {
        mapping = map.preset.insert {
          ['<C-d>'] = map.scroll_docs(-4),
          ['<C-f>'] = map.scroll_docs(4),
          ['<C-Space>'] = map.complete(),
          ['<C-e>'] = map.abort(),
          ['<CR>'] = map.confirm { select = false },
        },
        sources = cmp.config.sources {
          { name = 'nvim_lsp' },
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      }
    end
  }
}
