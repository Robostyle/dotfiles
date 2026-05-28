-- Lightweight alternative to vim-matchup.
-- Highlights the matching bracket/keyword pair using CursorHold,
-- so it only triggers after the cursor is idle (governed by 'updatetime'),
-- rather than on every CursorMoved event.
--
-- Highlight group: "MatchParen" (reuses the built-in group).

return {
  'andymass/vim-matchup',

  dependencies = {
    {
      'nvim-treesitter/nvim-treesitter',
      opts = {
        matchup = {
          enable = true, -- mandatory, false will disable the whole extension
          -- disable = { "c", "ruby" }, -- optional, list of language that will be disabled
        },
      },
    },
  },

  init = function()
    -- disable matchup offscreen
    vim.g.matchup_matchparen_offscreen = { method = 'status-manual' }
  end,

  opts = {},
}
