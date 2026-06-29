-- NOTE: not lazyloaded so to support running e.g. `nvim .`

vim.pack.add({
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/malewicz1337/oil-git.nvim" },
  { src = "https://github.com/JezerM/oil-lsp-diagnostics.nvim" },
})

require("oil").setup({
  keymaps = {
    ["<C-v>"] = { "actions.select", opts = { vertical = true } },
    ["<C-s>"] = { "actions.select", opts = { horizontal = true } },
    ["q"] = { "actions.close", mode = "n" },
  },
  columns = {
    "icon",
    "size",
    "mtime",
  },
  view_options = {
    show_hidden = true,
  },
  win_options = { signcolumn = "auto:2" },
  skip_confirm_for_simple_edits = true,
  watch_for_changes = false,
})

require("oil-git").setup({ symbol_position = "signcolumn" })
require("oil-lsp-diagnostics").setup()

vim.keymap.set("n", "<leader>o", "<cmd>Oil<cr>", { desc = "Oil" })
