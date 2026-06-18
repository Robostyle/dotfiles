-- A vim-vinegar like file explorer that lets you edit your filesystem like a normal Neovim buffer.
-- https://github.com/stevearc/oil.nvim

return {
  {
    'stevearc/oil.nvim',
    lazy = false, -- Lazy loading is not recommended

    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },

    __opts = function(_, opts)
      opts = opts or {}

      opts.keymaps = opts.keymaps or {}
      opts.keymaps['<C-v>'] = { 'actions.select', opts = { vertical = true } }
      opts.keymaps['<C-s>'] = { 'actions.select', opts = { horizontal = true } }
      opts.keymaps['q'] = { 'actions.close', mode = 'n' }
      opts.view_options = { show_hidden = true }
      return opts
    end,

    opts = {
      columns = {
        'permissions',
        'size',
        'icon',
      },

      skip_confirm_for_simple_edits = true,

      float = {
        padding = 8,
        max_width = 0.9,
        max_height = 0.9,
      },

      keymaps = {
        ['<C-v>'] = { 'actions.select', opts = { vertical = true } },
        ['<C-s>'] = { 'actions.select', opts = { horizontal = true } },
        ['q'] = { 'actions.close', mode = 'n' },
      },

      view_options = {
        show_hidden = true,
      },
    },

    keys = require('config.keymaps').setup_oil_keymaps(),
  },

  {
    'malewicz1337/oil-git.nvim',
    dependencies = {
      'stevearc/oil.nvim',
      opts = {
        win_options = { signcolumn = 'auto:2' },
      },
    },
    opts = {
      symbol_position = 'signcolumn',
    },
  },

  {
    'JezerM/oil-lsp-diagnostics.nvim',
    dependencies = { 'stevearc/oil.nvim' },
    opts = {},
  },
}
