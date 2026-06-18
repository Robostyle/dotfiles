local M = {}

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.o`

local opt = vim.opt

-- only set clipboard if not in ssh, to make sure the OSC 52
-- integration works automatically.
opt.breakindent = true
opt.clipboard = vim.env.SSH_CONNECTION and '' or 'unnamedplus' -- Sync with system clipboard
opt.completeopt = 'menu,menuone,noselect'
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Show which line your cursor is on
opt.expandtab = true -- expand tab into spaces
opt.fillchars = {
  foldopen = '',
  foldclose = '',
  fold = ' ', -- hide the ·············· that shows for folded code
  foldsep = ' ', -- hide the vertical line where a fold is possible
  foldinner = ' ', -- hide the indentation numbers in the fold column
  diff = '╱',
  -- diff = "░",
  -- diff = "·",
  eob = ' ',
}

-- Treesitter folding is the global default. LSP folding overrides per-buffer
-- via lsp_foldexpr(), called from plugins/core/lsp.lua when the server
-- supports textDocument/foldingRange.
opt.foldcolumn = '1' -- "0" to hide, "auto" to show when folds exist, "1" for always visible
opt.foldenable = true
opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldmethod = 'expr'
opt.foldtext = 'v:lua.custom_foldtext()'
opt.hlsearch = true
opt.ignorecase = true
opt.inccommand = 'split'
opt.incsearch = true
opt.linebreak = true -- Wrap lines at convenient points
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
opt.list = true
opt.mouse = 'a'
opt.number = true
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true
opt.ruler = true
opt.scrolloff = 4
opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp', 'folds' }
opt.shiftround = true
opt.shiftwidth = 4 -- indent << or >> by 4 spaces
opt.showmode = false
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = 'yes'
opt.smartcase = true
opt.smartindent = true -- Insert indents automatically
opt.softtabstop = 4 -- insert 4 spaces when tab is pressed
opt.smoothscroll = false
opt.spelllang = { 'en' }
opt.splitbelow = true
opt.splitkeep='screen'
opt.splitright = true
opt.tabstop = 4 -- display tabs as 4 spaces
opt.termguicolors = true
opt.timeoutlen = 300
opt.undolevels = 10000
opt.undofile = true
opt.updatetime = 250
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

require('utils.diagnostics').setup_diagnostics()

-- set up folding
function _G.custom_foldtext()
  local line = vim.fn.getline(vim.v.foldstart)
  local line_count = vim.v.foldend - vim.v.foldstart + 1
  local line_text = vim.fn.substitute(line, '\t', ' ', 'g')
  return string.format('%s (%d lines)', line_text, line_count)
end

--- Override foldexpr with LSP folding for the current window/buffer.
---@param win integer window handle
function M.lsp_foldexpr(win) vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()' end

return M
