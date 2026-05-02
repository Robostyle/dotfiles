-- Helper function to get jj.cmd functions (deferred loading)
local function jjCmd(funcName)
  return function()
    local cmd = require('jj.cmd')
    return cmd[funcName]()
  end
end

-- Helper function for jj.cmd functions that accept arguments
local function jjCmdWithArgs(funcName, ...)
  local args = { ... }
  return function()
    local cmd = require('jj.cmd')
    return cmd[funcName](unpack(args))
  end
end

local function keyMappings()
  return {
    { "<leader>j",  group = "JJ" },
    { "<leader>jd", jjCmd("describe"), desc = "JJ Describe" },
    { "<leader>jl", jjCmd("log"),      desc = "JJ Log" },
    { "<leader>je", jjCmd("edit"),     desc = "JJ Edit" },
    { "<leader>jn", jjCmd("new"),      desc = "JJ New" },
    { "<leader>js", jjCmd("status"),   desc = "JJ Status" },
  }
end

return {
  -- IconNameWhy it fits jj
  -- 󱖫 FlowchartRepresents the jj log graph perfectly.
  -- 󰒲 LayersRepresents the "working-copy-first" stack workflow.
  -- 󱗆 HistoryHighlights the immutable operation log.
  -- 󰜘 Git MergeShows it's still a VCS, but looks modern.
  {
  "nicolasgb/jj.nvim",
  dependencies = {
    "folke/snacks.nvim", -- Optional only if you use picker's
  },

  opts = {
    bookmark = {
      prefix = "rsu/FW-"
    },
  },

  keys = keyMappings()
      },
}
