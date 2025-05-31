local use_transparent_background = true

return {
  {
    "rebelot/kanagawa.nvim",

    opts = {
      transparent = use_transparent_background,
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
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nord",
    },
  },
}
