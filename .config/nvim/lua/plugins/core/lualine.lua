return {
  'nvim-lualine/lualine.nvim',

  opts = {
    diagnostics = 'nvim.lsp',
    diagnostics_indicator = function(_, _, diag)
      local ret = (diag.error 'error' and ' ' .. diag.error .. ' ' or '')
        .. (diag.warning and ' ' .. diag.warning or '')
      return vim.trim(ret)
    end,
  },
}
