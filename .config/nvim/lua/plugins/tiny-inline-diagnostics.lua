-- A plugin for displaying inline diagnostic messages with customizable styles
-- and icons.
-- https://github.com/rachartier/tiny-inline-diagnostic.nvim

return {
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy',
    priority = 1000,

    opts = {
      preset = 'modern',

      options = {
        show_all_diags_on_cursorline = true,
        multilines = {
          enabled = true,
          always_show = true,
        },
        show_source = {
          enabled = true,
        },
      },
    },

    config = function(_, opts) require('tiny-inline-diagnostic').setup(opts) end,
  },
}
