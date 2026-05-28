return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },

    dashboard = {
      enabled = true,
      preset = {
        keys = {
          {
            icon = ' ',
            key = 'n',
            desc = 'New File',
            action = ':ene | startinsert',
          },
          {
            icon = ' ',
            key = 'r',
            desc = 'Recent Files',
            action = ":lua Snacks.dashboard.pick('oldfiles')",
          },
          {
            icon = ' ',
            key = 's',
            desc = 'Restore Session',
            section = 'session',
          },
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

    indent = { enabled = true },

    input = { enabled = true },

    picker = { enabled = true },

    notifier = { enabled = true },

    quickfile = { enabled = true },

    scope = { enabled = true },

    scroll = { enabled = true },

    statuscolumn = { enabled = true },

    words = { enabled = true },
  },

  keys = function()
    ---@type table[table]
    local snacks_keymaps = require('config.keymaps').setup_snacks_keymaps()

    local merged_keymaps = {}
    for _, keymap in ipairs(snacks_keymaps) do
      table.insert(merged_keymaps, keymap)
    end
    return merged_keymaps
  end,
}
