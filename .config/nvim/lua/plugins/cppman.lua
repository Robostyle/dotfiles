return {
  "madskjeldgaard/cppman.nvim",

  requires = {
    { "MunifTanjim/nui.nvim" },
  },

  keys = {
    {
      "<leader>sf",
      function()
        require("cppman").open_cppman_for(vim.fn.expand("<cword>"))
      end,
      desc = "Open C++ keyword",
    },

    {
      "<leader>sF",
      function()
        require("cppman").input()
      end,
      desc = "Search C++",
    },
  },
}
