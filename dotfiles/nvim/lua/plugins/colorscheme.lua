return {
  {
    'projekt0n/github-nvim-theme',
    priority = 1000,
    config = function()
      vim.cmd("set background=light")
      vim.cmd.colorscheme('github_light')
    end,
  },
  --[[
  {
    'xiyaowong/transparent.nvim',
    config = function()
      vim.cmd('TransparentEnable')
    end
  },
  ]]--
}