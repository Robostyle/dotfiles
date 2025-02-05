return {
  "ibhagwan/fzf-lua",

  opts = function(_, opts)
    local fzf = require("fzf-lua")
    local actions = fzf.actions

    opts = {
      grep = {
        actions = {
          -- ctrl-g classes with Zellij
          ["alt-g"] = { actions.grep_lgrep },
          ["ctrl-g"] = function() end,
        },
      },
    }
    print("options", opts)
    return opts
  end,
}
