require("lazyload").on_vim_enter(function()
  vim.pack.add({
    { src = "https://github.com/j-hui/fidget.nvim" },
  })

  require("fidget").setup({})
end)
