-- git signs highlights text that has changed since the list
-- git commit, and also lets you interactively stage & unstage
-- hunks in a commit.
-- https://github.com/lewis6991/gitsigns.nvim

return {
  {
    'lewis6991/gitsigns.nvim',
    event = 'VeryLazy',

    opts = {
      signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
        untracked = { text = '▎' },
      },

      signs_staged = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
      },
    },

    on_attach = function(buffer) 

  print("Attached to "..buffer)

      require('config.keymaps').setup_gitsigns_keymaps(buffer) end,
  },

  {
    'gitsigns.nvim',
    opts = function()
      Snacks.toggle({
        name = 'Git signs',
        get = function() return require('gitsigns.config').config.signcolumn end,
        set = function(state) require('gitsigns').toggle_signs(state) end,
      }):map '<leader>uG'
    end,
  },
}
