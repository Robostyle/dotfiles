-- Deep buffer integration for Git
-- https://github.com/lewis6991/gitsigns.nvim

return {
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",

    opts = {},

    keys = require("config.keymaps").setup_gitsigns_keymaps(),
  },
}

