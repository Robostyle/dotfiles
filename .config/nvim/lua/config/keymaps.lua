local M = {}

local simpleMap = vim.keymap

local get_final_opts = function(desc, opts)
  return vim.tbl_deep_extend('force', {
    desc = desc,
  }, opts or {}) -- 'opts or {}' handles cases where no opts are passed
end

local map = function(mode, keys, command, desc, opts)
  vim.keymap.set(mode, keys, command, get_final_opts(desc, opts))
end

local is_mac = vim.fn.has 'macunix' == 1
local down_keys = is_mac and { '∆', '<M-j>', '<A-j>' } or { '<M-j>' }
local up_keys = is_mac and { '˚', '<M-k>', '<A-k>' } or { '<M-k>' }

-- Helper function to set multiple mappings for the same action
local function map_multiple(mode, keys, command, desc, opts)
  for _, key in ipairs(keys) do
    vim.keymap.set(mode, key, command, get_final_opts(desc, opts))
  end
end

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
simpleMap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- windows
--  Use CTRL+<hjkl> to switch between windows
map('n', '<C-h>', '<C-w>h', 'Go to left window', { silent = true })
map('n', '<C-j>', '<C-w>j', 'Go to lower window', { silent = true })
map('n', '<C-k>', '<C-w>k', 'Go to upper window', { silent = true })
map('n', '<C-l>', '<C-w>l', 'Go to right window', { silent = true })

-- Resize windows using <ctrl> arrow keys
map('n', '<C-Up>', ':resize +2<CR>', 'Increase window height', { silent = true })
map('n', '<C-Down>', ':resize -2<CR>', 'Decrease window height', { silent = true })
map('n', '<C-Right>', ':vertical resize +2<CR>', 'Increase window width', { silent = true })
map('n', '<C-Left>', ':vertical resize -2<CR>', 'Decrease window width', { silent = true })

-- Move Lines
-- Normal mode
map_multiple('n', down_keys, ':m .+1<CR>==', 'Move line down', { silent = true })
map_multiple('n', up_keys, ':m .-2<CR>==', 'Move line up', { silent = true })
-- Insert mode
map_multiple('i', down_keys, '<Esc>:m .+1<CR>==gi', 'Move line down', { silent = true })
map_multiple('i', up_keys, '<Esc>:m .-2<CR>==gi', 'Move line up', { silent = true })
-- Visual mode
map_multiple('v', down_keys, ":m '>+1<CR>gv=gv", 'Move selection down', { silent = true })
map_multiple('v', up_keys, ":m '<-2<CR>gv=gv", 'Move selection up', { silent = true })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map('n', 'n', "'Nn'[v:searchforward].'zv'", 'Next Search Result', { expr = true })
map('x', 'n', "'Nn'[v:searchforward]", 'Next Search Result', { expr = true })
map('o', 'n', "'Nn'[v:searchforward]", 'Next Search Result', { expr = true })
map('n', 'N', "'nN'[v:searchforward].'zv'", 'Prev Search Result', { expr = true })
map('x', 'N', "'nN'[v:searchforward]", 'Prev Search Result', { expr = true })
map('o', 'N', "'nN'[v:searchforward]", 'Prev Search Result', { expr = true })

-- buffers (see fred and kick)

-- tabs (see fred and kick)

-- better indenting
map('v', '<', '<gv', 'Indent left')
map('v', '>', '>gv', 'Indent right')

-- Lazy.nvim
map('n', '<leader>l', '<cmd>Lazy<cr>', 'Lazy')

-- new file
map('n', '<leader>fn', '<cmd>enew<cr>', 'New File')

-- diagnostic
local diagnostic_goto = function(next, severity)
  return function()
    vim.diagnostic.jump {
      count = (next and 1 or -1) * vim.v.count1,
      severity = severity and vim.diagnostic.severity[severity] or nil,
      float = true,
    }
  end
end

map('n', '<leader>cd', vim.diagnostic.open_float, 'Line Diagnostics')
map('n', ']d', diagnostic_goto(true), 'Next Diagnostic')
map('n', '[d', diagnostic_goto(false), 'Prev Diagnostic')
map('n', ']e', diagnostic_goto(true, 'ERROR'), 'Next Error')
map('n', '[e', diagnostic_goto(false, 'ERROR'), 'Prev Error')
map('n', ']w', diagnostic_goto(true, 'WARN'), 'Next Warning')
map('n', '[w', diagnostic_goto(false, 'WARN'), 'Prev Warning')

function M.setup_trouble_keymaps()
  return {
    {
      '<leader>xx',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics (Trouble)',
    },
    {
      '<leader>xX',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Buffer Diagnostics (Trouble)',
    },
    {
      '<leader>cl',
      '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      desc = 'LSP Definitions / references / ... (Trouble)',
    },
    {
      '<leader>xL',
      '<cmd>Trouble loclist toggle<cr>',
      desc = 'Location List (Trouble)',
    },
    {
      '<leader>xQ',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'Quickfix List (Trouble)',
    },
  }
end

function M.setup_toggles()
  Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>uL'
end

function M.setup_diagnostics_keymaps()
  -- TODO: use Snacks.toggle
  vim.keymap.set(
    'n',
    '<leader>ud',
    function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end,
    { desc = 'Toggle diagnostics', silent = true }
  )
end

function M.setup_yanky_keymaps()
  return {
    {
      '<leader>p',
      function() Snacks.picker.yanky() end,
      desc = 'Yanky history',
    },
  }
end

function M.setup_markdown_keymaps()
  return {
    {
      '<Leader>uM',
      function()
        local m = require 'render-markdown'
        local enabled = require('render-markdown.state').enabled
        if enabled then
          m.disable()
          vim.cmd 'setlocal conceallevel=0'
        else
          m.enable()
          vim.cmd 'setlocal conceallevel=2'
        end
      end,
      desc = 'Toggle markdown render',
    },
  }
end

function M.setup_neogit_keymaps()
  return {
    { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Show Neogit UI' },
  }
end

function M.setup_noice_keymaps()
  return {
    { '<leader>sn', '', desc = '+noice' },
    {
      '<S-Enter>',
      function() require('noice').redirect(vim.fn.getcmdline()) end,
      mode = 'c',
      desc = 'Redirect Cmdline',
    },
    {
      '<leader>snl',
      function() require('noice').cmd 'last' end,
      desc = 'Noice Last Message',
    },
    {
      '<leader>snh',
      function() require('noice').cmd 'history' end,
      desc = 'Noice History',
    },
    {
      '<leader>sna',
      function() require('noice').cmd 'all' end,
      desc = 'Noice All',
    },
    {
      '<leader>snd',
      function() require('noice').cmd 'dismiss' end,
      desc = 'Dismiss All',
    },
    {
      '<c-f>',
      function()
        if not require('noice.lsp').scroll(4) then return '<c-f>' end
      end,
      silent = true,
      expr = true,
      desc = 'Scroll Forward',
      mode = { 'i', 'n', 's' },
    },
    {
      '<c-b>',
      function()
        if not require('noice.lsp').scroll(-4) then return '<c-b>' end
      end,
      silent = true,
      expr = true,
      desc = 'Scroll Backward',
      mode = { 'i', 'n', 's' },
    },
  }
end

function M.setup_gitsigns_keymaps()
  return {
    {
      ']h',
      function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() require('gitsigns').nav_hunk 'next' end)
        return '<Ignore>'
      end,
      expr = true,
      desc = 'Next hunk',
    },
    {
      '[h',
      function()
        if vim.wo.diff then return '[c' end
        vim.schedule(function() require('gitsigns').nav_hunk 'prev' end)
        return '<Ignore>'
      end,
      expr = true,
      desc = 'Prev hunk',
    },
    {
      '<leader>ghb',
      function()
        local default_branch = require('utils.git').get_default_branch()
        require('gitsigns').change_base(default_branch, true)

        -- TODO: how to also tell codediff about this?
        -- https://github.com/esmuellert/codediff.nvim/pull/345
        -- require("codediff").change_base(default_branch, true)
      end,
      mode = { 'n', 'v' },
      desc = 'change base to default branch',
    },
    {
      '<leader>ghs',
      function() require('gitsigns').stage_hunk() end,
      mode = { 'n', 'v' },
      desc = 'toggle stage hunk',
    },
    {
      '<leader>ghS',
      function() require('gitsigns').stage_buffer() end,
      mode = { 'n', 'v' },
      desc = 'Stage buffer',
    },
    {
      '<leader>ghr',
      function() require('gitsigns').reset_hunk() end,
      desc = 'reset hunk',
    },
    {
      '<leader>gbb',
      function() require('gitsigns').blame() end,
      desc = 'blame on the side',
    },
    {
      '<leader>ght',
      function()
        require('gitsigns').toggle_show_deleted()
        require('gitsigns').toggle_linehl()
        require('gitsigns').toggle_word_diff()
      end,
      desc = 'toggle inline diff',
    },
  }
end

function M.setup_snacks_keymaps()
  local exclude = {}

  -- NOTE: Snacks is a global; _G.Snacks = M
  return {
    {
      '<leader><leader>',
      function()
        ---@type snacks.picker.smart.Config
        local opts = {
          multi = { 'buffers', 'files' },
          hidden = true,
          ignored = true,
          exclude = exclude,
        }
        Snacks.picker.smart(opts)
      end,
      desc = 'Files',
    },
    { '<leader>/', function() Snacks.picker.grep() end, desc = 'Grep' },
    {
      '<leader>:',
      function() Snacks.picker.command_history() end,
      desc = 'Command History',
    },
    { '<leader>,', function() Snacks.picker.buffers() end, desc = 'Buffers' },
    {
      '<leader>n',
      function() Snacks.notifier.show_history() end,
      desc = 'Toggle notification history',
    },

    -- LSP
    {
      'gd',
      function() Snacks.picker.lsp_definitions() end,
      desc = 'Goto Definition',
    },
    {
      'gs',
      function()
        vim.cmd 'split'
        Snacks.picker.lsp_definitions()
      end,
      desc = 'Goto Definition (split)',
    },
    {
      'gv',
      function()
        vim.cmd 'vsplit'
        Snacks.picker.lsp_definitions()
      end,
      desc = 'Goto Definition (vertical split)',
    },
    {
      'gD',
      function() Snacks.picker.lsp_declarations() end,
      desc = 'Goto Declaration',
    },
    {
      'gr',
      function() Snacks.picker.lsp_references() end,
      nowait = true,
      desc = 'References',
    },
    {
      'gI',
      function() Snacks.picker.lsp_implementations() end,
      desc = 'Goto Implementation',
    },
    {
      'gy',
      function() Snacks.picker.lsp_type_definitions() end,
      desc = 'Goto Type Definition',
    },
    {
      '<leader>cai',
      function() Snacks.picker.lsp_incoming_calls() end,
      desc = 'Calls Incoming',
    },
    {
      '<leder>cao',
      function() Snacks.picker.lsp_outgoing_calls() end,
      desc = 'Calls Outgoing',
    },
    {
      '<leader>cs',
      function() Snacks.picker.lsp_symbols() end,
      desc = 'LSP Symbols',
    },
    {
      '<leader>cS',
      function() Snacks.picker.lsp_workspace_symbols() end,
      desc = 'LSP Workspace Symbols',
    },

    -- Class Inheritance trees routing smoothly into Snacks float panels
    {
      '<leader>ct',
      function() require('utils.hierarchy_picker').open_type_hierarchy_in_snacks 'supertypes' end,
      desc = 'Class Hierarchy: Parents / Bases',
    },
    {
      '<leader>cT',
      function() require('utils.hierarchy_picker').open_type_hierarchy_in_snacks 'subtypes' end,
      desc = 'Class Hierarchy: Derived / Children',
    },

    -- Buffers
    {
      '<leader>bb',
      '<cmd>e #<cr>',
      desc = 'Switch to Other Buffer',
    },
    {
      '<leader>`',
      '<cmd>e #<cr>',
      desc = 'Switch to Other Buffer',
    },
    {
      '<leader>bd',
      function() Snacks.bufdelete() end,
      desc = 'Delete Buffer',
    },
    {
      '<leader>bo',
      function() Snacks.bufdelete.other() end,
      desc = 'Delete Other Buffers',
    },
    {
      '<leader>bi',
      function() Snacks.bufdelete.invisible() end,
      desc = 'Delete Invisible Buffers',
    },
    {
      '<leader>bD',
      '<cmd>:bd<cr>',
      desc = 'Delete Buffer and Window',
    },
  }
end

function M.setup_bufferline_keymaps()
  return {
    { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle Pin' },
    {
      '<leader>bP',
      '<Cmd>BufferLineGroupClose ungrouped<CR>',
      desc = 'Delete Non-Pinned Buffers',
    },
    {
      '<leader>br',
      '<Cmd>BufferLineCloseRight<CR>',
      desc = 'Delete Buffers to the Right',
    },
    {
      '<leader>bl',
      '<Cmd>BufferLineCloseLeft<CR>',
      desc = 'Delete Buffers to the Left',
    },
    { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
    { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
    { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
    { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
    { '[B', '<cmd>BufferLineMovePrev<cr>', desc = 'Move buffer prev' },
    { ']B', '<cmd>BufferLineMoveNext<cr>', desc = 'Move buffer next' },
    { '<leader>bj', '<cmd>BufferLinePick<cr>', desc = 'Pick Buffer' },
  }
end

function M.setup_lsp_autocmd_keymaps(buf)
  local map = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = buf, desc = 'LSP: ' .. desc, nowait = true })
  end

  -- Rename the variable under your cursor
  --  Most Language Servers support renaming across files, etc.
  map('<leader>cr', vim.lsp.buf.rename, 'Code rename')

  map('<leader>cR', Snacks.rename.rename_file, 'Code file rename')

  -- Execute a code action, usually your cursor needs to be on top of an error
  -- or a suggestion from your LSP for this to activate.
  map('<leader>ca', vim.lsp.buf.code_action, 'Code action')

  -- Show the available code actions for the word under your cursor
  map('<leader>cc', vim.lsp.codelens.run, 'Run Codelens')
  -- map("<leader>cC", vim.lsp.codelens.refresh, "Refresh & Display Codelens") -- only needed if not using autocmd

  -- Opens a popup that displays documentation about the word under your cursor
  --  See `:help K` for why this keymap
  map('K', vim.lsp.buf.hover, 'Hover Documentation')
end

function M.setup_lsp_keymaps()
  if vim.lsp.inlay_hint then Snacks.toggle.inlay_hints():map '<leader>uh' end

  if vim.lsp.codelens then
    Snacks.toggle
      .new({
        id = 'codelens',
        name = 'codelens',
        get = function() return vim.lsp.codelens.is_enabled() end,
        set = function(state) vim.lsp.codelens.enable(state) end,
      })
      :map '<leader>ul'
  end
end

function M.setup_conform_keymaps()
  map(
    'n',
    '<leader>uf',
    require('utils.toggle').toggle_formatting,
    'Toggle auto-formatting',
    { silent = true }
  )
end

function M.setup_undotree_keymaps()
  map('n', '<leader>fu', function() require('undotree').toggle() end, 'Undotree')
end

function M.setup_whichkey(wk)
  wk.add {
    { '<leader><tab>', group = 'tab' },
    --  { "<leader>a", group = "ai" },
    { '<leader>c', group = 'code' },
    -- { "<leader>d", group = "debug" },
    -- { "<leader>dl", group = "debug lua" },
    { '<leader>b', group = 'buffer' },
    { '<leader>g', group = 'git' },
    -- { "<leader>gb", group = "blame" },
    -- { "<leader>gd", group = "diffview" },
    { '<leader>gh', group = 'hunks' },
    -- { "<leader>n", group = "notes" },
    -- { "<leader>r", group = "run" },
    { '<leader>s', group = 'search' },
    -- { "<leader>sg", group = "git" },
    { '<leader>sn', group = 'noice' },
    -- { "<leader>t", group = "test" },
    { '<leader>u', group = 'ui' },
    { '<leader>x', group = 'diagnostics/quickfix' },
    { '<leader>w', group = 'windows', proxy = '<c-w>' },
    {
      '<leader>b',
      group = 'buffers',
      expand = function() return require('which-key.extras').expand.buf() end,
    },
  }
end

function M.setup_whichkey_contextual()
  return {
    {
      '<leader>?',
      function() require('which-key').show { global = false } end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
  }
end

function M.setup_oil_keymaps()
  return {
    {
      '<leader>o',
      function() require('oil').open_float() end,
      desc = 'Oil',
    },
  }
end

return M
