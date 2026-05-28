-- Utilities that handle toggling options

local M = {}

local orig_fmt_func = vim.lsp.handlers['textDocument/formatting']

function M.toggle_formatting()
  vim.g.auto_format = not vim.g.auto_format -- reverse the value

  vim.lsp.handlers['textDocument/formatting'] = vim.g.auto_format and orig_fmt_func or function() end
  vim.notify(vim.g.auto_format and 'Auto-formatting enabled' or 'Auto-formatting disabled', vim.log.levels.INFO)
end

return M
