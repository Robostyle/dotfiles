return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",

  keys = {
    {
      "<leader>bh",
      function()
        require("harpoon"):list():append()
      end,
      desc = "Harpoon active file",
    },

    {
      "<C-e>",
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = "Harpoon menu",
    },

    {
      "<C-h>",
      function()
        require("harpoon"):list():select(1)
      end,
      desc = "Harpoon buf 1",
    },

    {
      "<C-t>",
      function()
        require("harpoon"):list():select(2)
      end,
      desc = "Harpoon buf 2",
    },

    {
      "<C-n>",
      function()
        require("harpoon"):list():select(3)
      end,
      desc = "Harpoon buf 3",
    },

    {
      "<C-s>",
      function()
        require("harpoon"):list():select(4)
      end,
      desc = "Harpoon buf 4",
    },
  },
}
