return {
  "nvim-neo-tree/neo-tree.nvim",

  keys = {
    {
      "<leader>e",
      function()
        require("neo-tree.command").execute({ position = "float", reveal = true, dir = LazyVim.root() })
      end,
    },

    {
      "<leader>E",
      function()
        require("neo-tree.command").execute({ position = "float", reveal = true, dir = vim.uv.cwd() })
      end,
      desc = "Explorer NeoTree (cwd)",
    },
  },
}
