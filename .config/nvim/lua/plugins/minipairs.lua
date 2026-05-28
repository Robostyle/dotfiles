-- Auto pairs
-- Automatically inserts a matching closing character
-- when you type an opening character like `"`, `[`, or `(`.

---@param opts {skip_next: string, skip_ts: string[], skip_unbalanced: boolean, markdown: boolean}
local function setup_pairs(opts)
  local pairs = require 'mini.pairs'
  pairs.setup(opts)

  local snacks = require('snacks')
  snacks.toggle( {
    name = 'Mini Pairs',
    get = function() return not vim.g.minipairs_disable end,
    set = function(state) vim.g.minipairs_disable = not state end,
  }):map '<leader>up'
end

return {
  'nvim-mini/mini.pairs',
  event = 'VeryLazy',

  opts = {
    modes = { insert = true, command = true, terminal = false },
    -- skip autopair when next character is one of these
    skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
    -- skip autopair when the cursor is inside these treesitter nodes
    skip_ts = { 'string' },
    -- skip autopair when next character is closing pair
    -- and there are more closing pairs than opening pairs
    skip_unbalanced = true,
    -- better deal with markdown code blocks
    markdown = true,
  },

  config = function(_, opts) setup_pairs(opts) end,
}
