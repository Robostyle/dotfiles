return {
  'rebelot/kanagawa.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.

  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('kanagawa').setup {
      styles = {
        keywordStyle = { bold = true },
        commentStyle = { italic = true },
        transparent = true,
      },
    }

    vim.cmd.colorscheme 'kanagawa'
  end,
}
