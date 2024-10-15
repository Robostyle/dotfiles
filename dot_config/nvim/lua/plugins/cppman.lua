return {

  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        {
          mode = { "n", "v" },
          { "<leader>m", group = "cppman" },
        },
      },
    },
  },

  {
    "madskjeldgaard/cppman.nvim",

    requires = {
      { "MunifTanjim/nui.nvim" },
    },

    keys = {
      {
        "<leader>mm",
        function()
          require("cppman").open_cppman_for(vim.fn.expand("<cword>"))
        end,
        desc = "Open keyword",
        ft = { "c", "cpp", "h" },
      },

      {
        "<leader>mf",
        function()
          require("cppman").input()
        end,
        desc = "Search",
        ft = { "c", "cpp", "h" },
      },
    },
  },
}
