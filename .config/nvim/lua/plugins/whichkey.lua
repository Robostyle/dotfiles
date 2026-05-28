return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter',

    dependencies = {
      'echasnovski/mini.icons',
    },

    opts = {
      preset = 'helix',

      delay = 0,
    },

    config = function(_, opts)
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      local wk = require 'which-key'
      require('config.keymaps').setup_whichkey(wk)
      wk.setup(opts)
    end,

    keys = require('config.keymaps').setup_whichkey_contextual(),
  },
}
