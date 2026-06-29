vim.pack.add({
  { src = "https://github.com/folke/noice.nvim", version = vim.version.range("*") },
  { src = "https://github.com/MunifTanjim/nui.nvim" },
  { src = "https://github.com/rcarriga/nvim-notify" },
})

require("noice").setup({
  presets = {
    bottom_search = false,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = true,
  },
})
