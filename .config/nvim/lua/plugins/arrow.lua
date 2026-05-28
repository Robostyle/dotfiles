-- Arrow.nvim is a plugin made to bookmarks files (like harpoon) using a single UI (and single keymap).
-- https://github.com/otavioschwanck/arrow.nvim

return {
  {
    'otavioschwanck/arrow.nvim',
    lazy = true,
    event = 'VeryLazy',

    opts = {
      show_icons = true,
      leader_key = ';', -- Recommended to be a single key
      buffer_leader_key = 'm',
      always_show_path = true,
    },
  },
}
