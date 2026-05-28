-- A plugin to highlight and search for todo comments like TODO, HACK, BUG in
-- your code base.
-- https://github.com/folke/todo-comments.nvim

return {
  {
    'folke/todo-comments.nvim',
    lazy = true,
    event = 'VeryLazy',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
    -- NOTE: keymaps through Snacks.picker
  },
}
