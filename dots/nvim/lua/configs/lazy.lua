local lazypath = vim.fn.stdpath("data") .. '/lazy/lazy.nvim'
local lazyrepo = 'https://github.com/folke/lazy.nvim.git'

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    lazyrepo,
    lazypath
  })

  if vim.v.shell_error ~= 0 then
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)


require('lazy').setup {
  spec = {
    { import = 'plugins' },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  checker = {
    enabled = false,
  },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      disabled_plugins = {
        'gzip',
        'netrwPlugin',
        'rplugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      }
    }
  },
  change_detection = {
    enabled = false,
  },
  debug = false,
}
