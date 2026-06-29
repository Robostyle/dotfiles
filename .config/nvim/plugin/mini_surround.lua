require("lazyload").on_vim_enter(function()
  vim.pack.add({
    { src = "https://github.com/echasnovski/mini.surround", version = vim.version.range("*") },
  })

  require("mini.surround").setup({
    mappings = {
      add = "gsa",
      delete = "gsd",
      find = "gsf",
      find_left = "gsF",
      highlight = "gsh",
      replace = "gsr",
      update_n_lines = "gsn",
    },
  })
end)
