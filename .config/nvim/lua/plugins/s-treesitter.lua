require('nvim-treesitter.configs').setup({
  ensure_installed = { 'c', 'cpp', 'rust', 'lua', 'cmake', 'glsl', 'hlsl', 'json' },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true
  }
})
