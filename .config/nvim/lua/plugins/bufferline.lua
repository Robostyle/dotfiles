return {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',

  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },

  opts = {
    options = {
      always_show_bufferline = false,
      diagnostics = 'nvim_lsp',

      indicator = {
        icon = '',
        style = 'underline',
      },

      diagnostics_indicator = function(count, level, _, _)
        local icon = level:match 'error' and ' ' or ' '
        return ' ' .. icon .. count
      end,

      separator_style = 'thick',
      sort_by = 'relative_directory',
    },
  },

  keys = require('config.keymaps').setup_bufferline_keymaps(),
}
