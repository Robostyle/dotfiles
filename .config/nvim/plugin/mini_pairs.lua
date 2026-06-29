require("lazyload").on_vim_enter(function()
  vim.pack.add({
    { src = "https://github.com/echasnovski/mini.pairs", version = vim.version.range("*") },
  })

  require("mini.pairs").setup({
    modes = { insert = true, command = true, terminal = false },
    -- skip autopair when next character is one of these
    skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
    -- skip autopair when the cursor is inside these treesitter nodes
    skip_ts = { "string" },
    -- skip autopair when next character is closing pair
    -- and there are more closing pairs than opening pairs
    skip_unbalanced = true,
    -- better deal with markdown code blocks
    markdown = true,
  })

  local snacks = require("snacks")
  snacks
    .toggle({
      name = "Mini Pairs",
      get = function()
        return not vim.g.minipairs_disable
      end,
      set = function(state)
        vim.g.minipairs_disable = not state
      end,
    })
    :map("<leader>up")
end)
