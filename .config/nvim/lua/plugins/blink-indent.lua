-- Provides indent guides with scope.
-- https://github.com/saghen/blink.indent

return {
  {
    'saghen/blink.indent',
    lazy = true,
    event = 'BufReadPost',

    --- @module 'blink.indent'
    --- @type blink.indent.Config
    opts = {
      blocked = {
        filetypes = { include_defaults = true, 'snacks_picker_preview' },
      },
      static = {
        enabled = false,
      },
      scope = {
        highlights = { 'BlinkIndentScope' }, -- avoid multiple colors
      },
    },

    config = function(_, opts)
      require('blink.indent').setup(opts)
      require('config.keymaps').setup_blink_indent_keymaps()
    end,
  },
}
