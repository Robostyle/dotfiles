return {
  'NeogitOrg/neogit',
  lazy = true,

  dependencies = {
    'esmuellert/codediff.nvim',
    'm00qek/baleia.nvim', --- For a custom log pager
    'folke/snacks.nvim',
  },

  cmd = 'Neogit',

  keys = require('config.keymaps').setup_neogit_keymaps(),
}
