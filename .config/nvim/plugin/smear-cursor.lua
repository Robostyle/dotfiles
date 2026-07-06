require("lazyload").on_vim_enter(function()
  vim.pack.add({
    { src = "https://github.com/sphamba/smear-cursor.nvim", version = vim.version.range("*") },
  })

  local smear = require("smear_cursor")
  smear.setup({})

  vim.keymap.set("n", "<leader>uc", smear.toggle, { desc = "Toggle smear Cursor" })
end)
