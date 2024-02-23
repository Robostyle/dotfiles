return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",

  init = function()
    local harpoon = require("harpoon")
    harpoon:setup({})
  end,

  keys = {
    {
      "<leader>bh",
      function()
        local harpoon = require("harpoon")
        harpoon:list():append()
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
        local harpoon = require("harpoon")
        harpoon:list():select(1)
      end,
      desc = "Harpoon buf 1",
    },

    {
      "<C-t>",
      function()
        local harpoon = require("harpoon")
        harpoon:list():select(2)
      end,
      desc = "Harpoon buf 2",
    },

    {
      "<C-n>",
      function()
        local harpoon = require("harpoon")
        harpoon:list():select(3)
      end,
      desc = "Harpoon buf 3",
    },

    {
      "<C-s>",
      function()
        local harpoon = require("harpoon")
        harpoon:list():select(4)
      end,
      desc = "Harpoon buf 4",
    },
  },
}
