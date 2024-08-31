if vim.loader then
  vim.loader.enable()
end

require('configs.keymaps')
require('configs.options')
require('configs.bootstrap')
require('configs.lazy')