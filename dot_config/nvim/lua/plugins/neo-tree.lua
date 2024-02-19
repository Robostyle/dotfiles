local Util = require("lazyvim/util")

return {
  "nvim-neo-tree/neo-tree.nvim",

  keys = {
    {
      "<leader>fe",
      function()
        require("neo-tree.command").execute({ focus = true, dir = Util.root() })
      end,
      desc = "Explorer NeoTree (root dir)",
    },

    {
      "<leader>fE",
      function()
        require("neo-tree.command").execute({ focus = true, dir = vim.loop.cwd() })
      end,
      desc = "Explorer NeoTree (cwd)",
    },
  },
}
