-- A visualizer for Neovim’s internal undo tree.
-- https://github.com/jiaoshijie/undotree

return {
  'jiaoshijie/undotree',

  opts = {
    window = {
      border = 'rounded',
    },
  },

  keys = require('config.keymaps').setup_undotree_keymaps(),
}
