return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    config = function()
    --[[
      require('lualine').setup{
        options = {
          theme = {
            normal = {
              a = { bg = '#865319', fg = '#ffffff', gui = 'bold' },
              b = { bg = '#ffdcbf', fg = '#2d1600' },
              c = { bg = '#ffdcbf', fg = '#2d1600' },
            },
            insert = {
              a = { bg = '#735942', fg = '#ffffff', gui = 'bold' },
              b = { bg = '#ffdcbf', fg = '#2d1600' },
              c = { bg = '#ffdcbf', fg = '#2d1600' },
            },
            inactive = {
              a = { bg = '#596339', fg = '#ffffff', gui = 'bold' },
              b = { bg = '#ffdcbf', fg = '#2d1600' },
              c = { bg = '#ffdcbf', fg = '#2d1600' },
            },
            visual = {
              a = { bg = '#596339', fg = '#ffffff', gui = 'bold' },
              b = { bg = '#ffdcbf', fg = '#2d1600' },
              c = { bg = '#ffdcbf', fg = '#2d1600' },
            },
          }
        }
      }
      --]]
    end
  }
}