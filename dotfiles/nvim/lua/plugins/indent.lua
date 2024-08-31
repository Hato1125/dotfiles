return {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = 'BufRead',
    config = function()
      require('ibl').setup {
        indent = {
          char = '┆'
        }
      }
    end
  }
}