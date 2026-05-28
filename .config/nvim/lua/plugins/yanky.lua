-- Improve yank and put functionalities for Neovim.
-- https://github.com/gbprod/yanky.nvim

return {
    "gbprod/yanky.nvim",
    lazy = true,

    dependencies = {
      "folke/snacks.nvim",
    },

    opts = {},

    keys = require("config.keymaps").setup_yanky_keymaps(),
}

