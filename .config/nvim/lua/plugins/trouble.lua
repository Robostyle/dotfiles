-- A pretty list for showing diagnostics, references, telescope results,
-- quickfix and location lists to help you solve all the trouble your code is
-- causing.
-- https://github.com/folke/trouble.nvim

return {
  'folke/trouble.nvim',
  enabled = false,
  lazy = true,
  dependencies = {
    -- icons supported via mini-icons.lua

    {
      'nvim-lualine/lualine.nvim',
      opts = {
        extensions = { 'trouble' },
      },
    },
  },

  opts = {},

  keys = require('config.keymaps').setup_trouble_keymaps(),
}
