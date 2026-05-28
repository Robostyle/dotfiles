local M = {}

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- fillchars
vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ", -- hide the ·············· that shows for folded code
  foldsep = " ", -- hide the vertical line where a fold is possible
  foldinner = " ", -- hide the indentation numbers in the fold column
  diff = "╱",
  -- diff = "░",
  -- diff = "·",
  eob = " ",
}

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- set tab and indents defaults (can be overridden by per-language configs)
vim.opt.tabstop = 4 -- display tabs as 4 spaces
vim.opt.softtabstop = 4 -- insert 4 spaces when tab is pressed
vim.opt.shiftwidth = 4 -- indent << or >> by 4 spaces
vim.opt.expandtab = false -- expand tab into spaces

-- 24-bit color
vim.opt.termguicolors = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- incremental search
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- ignore case when searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- text wrap
vim.opt.wrap = false
vim.opt.linebreak = true -- Wrap lines at convenient points

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

-- Enable break indent
vim.o.breakindent = true

-- Enable undo/redo changes even after closing and reopening a file
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

require("utils.diagnostics").setup_diagnostics()

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-guide-options`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- set up folding
function _G.custom_foldtext()
  local line = vim.fn.getline(vim.v.foldstart)
  local line_count = vim.v.foldend - vim.v.foldstart + 1
  local line_text = vim.fn.substitute(line, "\t", " ", "g")
  return string.format("%s (%d lines)", line_text, line_count)
end

-- Treesitter folding is the global default. LSP folding overrides per-buffer
-- via lsp_foldexpr(), called from plugins/core/lsp.lua when the server
-- supports textDocument/foldingRange.
vim.opt.foldcolumn = "1" -- "0" to hide, "auto" to show when folds exist, "1" for always visible
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = "v:lua.custom_foldtext()"
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

--- Override foldexpr with LSP folding for the current window/buffer.
---@param win integer window handle
function M.lsp_foldexpr(win)
  vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
end

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 4

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true


return M
