return {
  {
    "catppuccin/nvim",
    flavour = "frappe",
    name = "catppuccin",
    opts = {
      transparent_background = true,
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
      colorscheme = "catppuccin",
    },
  },
}
