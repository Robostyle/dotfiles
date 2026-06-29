require("lazyload").on_vim_enter(function()
  vim.pack.add({
    { src = "https://github.com/neogitorg/neogit" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/m00qek/baleia.nvim" },
  })

  require("neogit").setup({
    cmd = "Neogit",
  })

  vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Show Neogit UI" })
end)
