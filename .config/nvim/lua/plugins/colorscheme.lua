local use_transparent_background = true

return {
  {
    "rebelot/kanagawa.nvim",

    opts = {
      transparent = use_transparent_background,
      theme = "wave",
    },
  },

  {
    "gbprod/nord.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = use_transparent_background,
    },
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
}
