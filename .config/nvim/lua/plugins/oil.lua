-- Global function to retrieve the current directory
function _G.get_oil_winbar()
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local dir = require("oil").get_current_dir(bufnr)
  if dir then
    return vim.fn.fnamemodify(dir, ":~")
  else
    -- If there is no current directory (e.g. over ssh), just show the buffer name
    return vim.api.nvim_buf_get_name(0)
  end
end

local detail = false

local function toggle_file_detail()
  detail = not detail
  if detail then
    require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
  else
    require("oil").set_columns({ "icon" })
  end
end

return {
  "stevearc/oil.nvim",

  ---
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    winbar = "%!v:lua.get_oil_winbar()",

    keymaps = {
      ["gd"] = {
        desc = "Toggle file detail view",
        callback = toggle_file_detail,
      },
    },
  },

  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,

  keys = {
    {
      "<leader>o",
      function()
        require("oil").open(nil)
      end,
      desc = "Find Plugin File",
    },
  },
}
