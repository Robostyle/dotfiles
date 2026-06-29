-- Lets you navigate your code with search labels, enhanced character motions,
-- and Treesitter integration.

require("lazyload").on_vim_enter(function()
  vim.pack.add({
    { src = "https://github.com/folke/flash.nvim" },
  })

  require("flash").setup({})

  vim.keymap.set({ "n", "x", "o" }, "s", function()
    require("flash").jump()
  end, { desc = "Flash" })
  vim.keymap.set({ "n", "x", "o" }, "S", function()
    require("flash").treesitter()
  end, { desc = "Flash Treesitter" })
  vim.keymap.set("o", "r", function()
    require("flash").remote()
  end, { desc = "Remote Flash" })
  vim.keymap.set({ "o", "x" }, "R", function()
    require("flash").treesitter_search()
  end, { desc = "Treesitter Search" })
  vim.keymap.set({ "n", "o", "x" }, "<c-space>", function()
    require("flash").treesitter_search()
  end, { desc = "Treesitter Incremental Selection" })
  vim.keymap.set("c", "<c-s>", function()
    require("flash").treesitter_search()
  end, { desc = "Toggle Flash Search" })
end)
