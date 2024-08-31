return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    keys = {
      { '<c-\\>', 'i' },
      { '<c-\\>', 'n' },
    },
    config = function()
      require('toggleterm').setup{
        open_mapping = [[<c-\>]],
      }
    end
  }
}