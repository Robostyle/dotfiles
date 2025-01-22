return {
  enabled = true,

  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "echasnovski/mini.nvim", -- if you use the mini.nvim suite
    "echasnovski/mini.icons", -- if you use standalone mini plugins
    "nvim-tree/nvim-web-devicons", -- if you prefer nvim-web-devicons
  },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {},
}
