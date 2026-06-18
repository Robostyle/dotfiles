-- Lightweight yet powerful formatter plugin for Neovim
-- https://github.com/stevearc/conform.nvim

return {
  'stevearc/conform.nvim',
  lazy = true,
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format({ bufnr = 0, timeout_ms = 5000, lsp_format = 'fallback' })
      end,
      desc = 'Format file',
    },
  },

  config = function(_, opts)
    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '*',
      callback = function(args)
        if vim.g.auto_format then
          require('conform').format {
            bufnr = args.buf,
            timeout_ms = 5000,
            lsp_format = 'fallback',
          }
        end
      end,
    })

    vim.g.auto_format = false

    require('conform').setup(opts)
    require('config.keymaps').setup_conform_keymaps()
  end,
}
