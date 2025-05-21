local use_transparent_background = false

return {
  {
    "rebelot/kanagawa.nvim",

    opts = {
      transparent = use_transparent_background,
    },
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      dark_variant = "moon",
    },
  },

  {
    "catppuccin/nvim",
    flavour = "frappe",
    name = "catppuccin",
    opts = {
      transparent_background = use_transparent_background,
      integrations = {
        blink_cmp = true,
        neogit = true,
        render_markdown = true,
      },
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },
}
