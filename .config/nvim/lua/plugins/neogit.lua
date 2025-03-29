return {
  "NeogitOrg/neogit",

  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "sindrets/diffview.nvim", -- optional - Diff integration

    "ibhagwan/fzf-lua", -- optional
  },

  config = true,

  opts = {
    disable_line_numbers = false,
    graph_style = "kitty",
    status = {
      recent_commit_count = 40,
    },
  },

  keys = {
    { "<leader>gn", [[<Cmd>lua require"neogit".open({ kind = "tab" })<CR>]], desc = "Neogit" },
    { "<leader>gN", [[<Cmd>lua require"neogit".open({ kind = "auto" })<CR>]], desc = "Neogit" },
  },
}
