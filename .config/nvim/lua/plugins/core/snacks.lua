return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = false }, -- We use Fredrik Averpil's sollution

    dashboard = {
      enabled = true,
      preset = {
        keys = {
          { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
          { icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
          {
            icon = ' ',
            key = 'c',
            desc = 'Config',
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = '󰒲 ', key = 'l', desc = 'Lazy', action = ':Lazy' },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
      },

      sections = {
        { section = 'header' },
        { section = 'keys', gap = 1, padding = 1 },
        (function()
          local specs = vim.g.local_lazy_specs
          if not specs or #specs == 0 then return { text = '' } end
          local lines = {}
          for _, path in ipairs(specs) do
            table.insert(lines, '  ' .. vim.fn.fnamemodify(path, ':~'))
          end
          return {
            text = table.concat(lines, '\n'),
            align = 'center',
            hl = 'Comment',
            padding = 1,
          }
        end)(),
        { section = 'startup' },
      },
    },

    explorer = { enabled = true },

    indent = { enabled = false },

    input = { enabled = true },

    picker = {
      enabled = true,

      win = {
        -- input window
        input = {
          keys = {
            -- disable the default keybinds
            ['<M-i>'] = false,
            ['<M-h>'] = false,

            ['<c-r>h'] = { 'toggle_hidden', mode = { 'i', 'n' } },
            ['<c-r>i'] = { 'toggle_ignored', mode = { 'i', 'n' } },
            ['g?'] = 'toggle_help_input',
          },
        },
      },
    },

    notifier = { enabled = true },

    quickfile = { enabled = true },

    scope = { enabled = true },

    scroll = { enabled = true },

    statuscolumn = { enabled = true },

    words = { enabled = true },
  },

  keys = require('config.keymaps').setup_snacks_keymaps(),

  init = function() vim.g.snacks_animate = false end,
}
