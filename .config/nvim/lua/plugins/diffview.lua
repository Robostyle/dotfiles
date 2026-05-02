return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        {
          "<leader>p",
          group = "Diffview",
          icon = { icon = " ", color = "green" },
        },
      },
    },
  },

  {
    "sindrets/diffview.nvim",

    opts = {
    },

    keys = {
      {
        "<leader>pf",
        function()
          local args = vim.fn.input("DiffviewOpen args: ")
          vim.cmd("DiffviewOpen " .. args)
        end,
        desc = "DiffView open with arguments"
      },
      {
        "<leader>pd",
        function()
          vim.cmd("DiffviewOpen")
        end,
        desc = "DiffView open"
      },
      {
        "<leader>ph",
        function()
          vim.cmd("DiffviewFileHistory")
        end,
        desc = "DiffView history"
      },
    },
  },
}
