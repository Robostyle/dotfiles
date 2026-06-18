-- Navigate your code with search labels, enhanced character motions, and Treesitter integration.
-- https://github.com/folke/flash.nvim

return {
  'folke/flash.nvim',
  event = 'VeryLazy',

  ---@type Flash.Config
  opts = {},

  keys = require('config.keymaps').setup_flash_keymaps(),
}
