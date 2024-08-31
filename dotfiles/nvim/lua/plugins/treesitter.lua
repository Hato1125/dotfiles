return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    event = 'BufRead',
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
  }
}