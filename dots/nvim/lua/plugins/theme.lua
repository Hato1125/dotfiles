local theme_path = '/home/hato/Develop/hub/Hato1125/nvim-color-scheme'

if not (vim.uv or vim.loop).fs_stat(theme_path) then
  return {}
end

return {
  {
    dir = theme_path,
    name = 'nvim-color-scheme',
    lazy = false,
    priority = 1000,
  },
}
