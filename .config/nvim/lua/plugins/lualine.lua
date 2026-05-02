return {
  "nvim-lualine/lualine.nvim",

  opts = {
    always_divide_middle = false,

    sections = {
      lualine_z = { "lsp_status" },
    },
  },
}
