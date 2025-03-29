return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    file_types = {
      "markdown",
      "Avante",
    },
    ft = {
      "markdown",
      "Avante",
    },
    completions = {
      blink = {
        enabled = true,
      },
    },
  },
}
