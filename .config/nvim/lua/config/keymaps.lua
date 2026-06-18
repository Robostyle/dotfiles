local M = {}

local simpleMap = vim.keymap

local get_final_opts = function(desc, opts)
  return vim.tbl_deep_extend('force', {
    desc = desc,
  }, opts or {}) -- 'opts or {}' handles cases where no opts are passed
end

local map = function(mode, keys, command, desc, opts) vim.keymap.set(mode, keys, command, get_final_opts(desc, opts)) end

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

-- better indenting
map('v', '<', '<gv', 'Indent left')
map('v', '>', '>gv', 'Indent right')

-- commenting
map('n', 'gco', 'o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', 'Add Comment Below')
map('n', 'gcO', 'O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>', 'Add Comment Above')

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

-- quit
map('n', '<leader>qq', '<cmd>qa<cr>', 'Quit All')

-- highlights under cursor
map('n', '<leader>ui', vim.show_pos, 'Inspect Pos')
map('n', '<leader>uI', function()
  vim.treesitter.inspect_tree()
  vim.api.nvim_input 'I'
end, 'Inspect Tree')

-- windows
map('n', '<leader>-', '<C-W>s', 'Split Window Below', { remap = true })
map('n', '<leader>|', '<C-W>v', 'Split Window Right', { remap = true })
map('n', '<leader>wd', '<C-W>c', 'Delete Window', { remap = true })

-- tabs
map('n', '<leader><tab>l', '<cmd>tablast<cr>', 'Last Tab')
map('n', '<leader><tab>o', '<cmd>tabonly<cr>', 'Close Other Tabs')
map('n', '<leader><tab>f', '<cmd>tabfirst<cr>', 'First Tab')
map('n', '<leader><tab><tab>', '<cmd>tabnew<cr>', 'New Tab')
map('n', '<leader><tab>]', '<cmd>tabnext<cr>', 'Next Tab')
map('n', '<leader><tab>d', '<cmd>tabclose<cr>', 'Close Tab')
map('n', '<leader><tab>[', '<cmd>tabprevious<cr>', 'Previous Tab')

function M.setup_trouble_keymaps()
  return {
    { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
    { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics (Trouble)' },
    { '<leader>cs', '<cmd>Trouble symbols toggle<cr>', desc = 'Symbols (Trouble)' },
    { '<leader>cS', '<cmd>Trouble lsp toggle<cr>', desc = 'LSP references/definitions/... (Trouble)' },
    { '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List (Trouble)' },
    { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List (Trouble)' },
    {
      '[q',
      function()
        if require('trouble').is_open() then
          require('trouble').prev { skip_groups = true, jump = true }
        else
          local ok, err = pcall(vim.cmd.cprev)
          if not ok then vim.notify(err, vim.log.levels.ERROR) end
        end
      end,
      desc = 'Previous Trouble/Quickfix Item',
    },
    {
      ']q',
      function()
        if require('trouble').is_open() then
          require('trouble').next { skip_groups = true, jump = true }
        else
          local ok, err = pcall(vim.cmd.cnext)
          if not ok then vim.notify(err, vim.log.levels.ERROR) end
        end
      end,
      desc = 'Next Trouble/Quickfix Item',
    },
  }
end

function M.setup_toggles()
  -- TODO: fixme
  --   Snacks.toggle.zoom():map("<leader>wm"):map("<leader>uZ")
  -- Snacks.toggle.zen():map("<leader>uz")
  -- TODO: fixme

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

function M.setup_flash_keymaps()
  return {
    { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash' },
    { 'S', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Flash Treesitter' },
    { 'r', mode = 'o', function() require('flash').remote() end, desc = 'Remote Flash' },
    { 'R', mode = { 'o', 'x' }, function() require('flash').treesitter_search() end, desc = 'Treesitter Search' },
    { '<c-s>', mode = { 'c' }, function() require('flash').toggle() end, desc = 'Toggle Flash Search' },
    -- Simulate nvim-treesitter incremental selection
    {
      '<c-space>',
      mode = { 'n', 'o', 'x' },
      function()
        require('flash').treesitter {
          actions = {
            ['<c-space>'] = 'next',
            ['<BS>'] = 'prev',
          },
        }
      end,
      desc = 'Treesitter Incremental Selection',
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

function M.setup_gitsigns_keymaps(buffer)
  print('Attached to ' .. buffer)
  local gs = package.loaded.gitsigns

  local function buffer_map(mode, k, c, desc) map(mode, k, c, desc, { buffer = buffer, silent = true }) end

  buffer_map('n', ']h', function()
    if vim.wo.diff then
      vim.cmd.normal { ']c', bang = true }
    else
      vim.schedule(function() gs.nav_hunk 'next' end)
    end
  end, 'Next hunk')

  buffer_map('n', '[h', function()
    if vim.wo.diff then
      vim.cmd.normal { '[c', bang = true }
    else
      vim.schedule(function() gs.nav_hunk 'prev' end)
    end
  end, 'Prev hunk')

  buffer_map('n', ']H', function() gs.nav_hunk 'last' end, 'Last Hunk')
  buffer_map('n', '[H', function() gs.nav_hunk 'first' end, 'First Hunk')
  buffer_map({ 'n', 'x' }, '<leader>ghs', gs.require('gitsigns').stage_hunk(), 'Stage hunk')
  buffer_map({ 'n', 'x' }, '<leader>ghr', gs.require('gitsigns').reset_hunk(), 'Stage hunk')
  buffer_map('n', '<leader>ghS', gs.require('gitsigns').stage_buffer(), 'Stage buffer')
  buffer_map('n', '<leader>ghu', gs.require('gitsigns').undo_stage_hunk(), 'Undo stage buffer')

  local x = {
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

  -- TODO: fix me
  --
  --
  -- toggle options
  -- LazyVim.format.snacks_toggle():map '<leader>uf'
  -- LazyVim.format.snacks_toggle(true):map '<leader>uF'
  -- Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>us'
  -- Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
  -- Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>uL'
  -- Snacks.toggle.diagnostics():map '<leader>ud'
  -- Snacks.toggle.line_number():map '<leader>ul'
  -- Snacks.toggle
  --   .option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = 'Conceal Level' })
  --   :map '<leader>uc'
  -- Snacks.toggle
  --   .option('showtabline', { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = 'Tabline' })
  --   :map '<leader>uA'
  -- Snacks.toggle.treesitter():map '<leader>uT'
  -- Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map '<leader>ub'
  -- Snacks.toggle.dim():map '<leader>uD'
  -- Snacks.toggle.animate():map '<leader>ua'
  -- Snacks.toggle.indent():map '<leader>ug'
  -- Snacks.toggle.scroll():map '<leader>uS'
  -- Snacks.toggle.profiler():map '<leader>dpp'
  -- Snacks.toggle.profiler_highlights():map '<leader>dph'
  --
  -- if vim.lsp.inlay_hint then Snacks.toggle.inlay_hints():map '<leader>uh' end
  -- TODO: fix me

  -- NOTE: Snacks is a global; _G.Snacks = M
  return {
    {
      '<leader><space>',
      function()
        ---@type snacks.picker.smart.Config
        local opts = {
          multi = { 'buffers', 'files' },
          hidden = false,
          ignored = false,
          exclude = exclude,
        }
        Snacks.picker.smart(opts)
      end,
      desc = 'Files',
    },
    { '<leader>,', function() Snacks.picker.buffers() end, desc = 'Buffers' },
    { '<leader>/', function() Snacks.picker.grep() end, desc = 'Grep' },
    { '<leader>:', function() Snacks.picker.command_history() end, desc = 'Command History' },
    { '<leader>n', function() Snacks.picker.notifications() end, desc = 'Notification history' },

    -- TODO: get inspiration from LazyVim for the 'has' key and virtual servers
    -- to add the keymaps below

    -- Search
    -- search
    { '<leader>s"', function() Snacks.picker.registers() end, desc = 'Registers' },
    { '<leader>s/', function() Snacks.picker.search_history() end, desc = 'Search History' },
    { '<leader>sa', function() Snacks.picker.autocmds() end, desc = 'Autocmds' },
    { '<leader>sc', function() Snacks.picker.command_history() end, desc = 'Command History' },
    { '<leader>sC', function() Snacks.picker.commands() end, desc = 'Commands' },
    { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = 'Diagnostics' },
    { '<leader>sD', function() Snacks.picker.diagnostics_buffer() end, desc = 'Buffer Diagnostics' },
    { '<leader>sh', function() Snacks.picker.help() end, desc = 'Help Pages' },
    { '<leader>sH', function() Snacks.picker.highlights() end, desc = 'Highlights' },
    { '<leader>si', function() Snacks.picker.icons() end, desc = 'Icons' },
    { '<leader>sj', function() Snacks.picker.jumps() end, desc = 'Jumps' },
    { '<leader>sk', function() Snacks.picker.keymaps() end, desc = 'Keymaps' },
    { '<leader>sl', function() Snacks.picker.loclist() end, desc = 'Location List' },
    { '<leader>sM', function() Snacks.picker.man() end, desc = 'Man Pages' },
    { '<leader>sm', function() Snacks.picker.marks() end, desc = 'Marks' },
    { '<leader>sR', function() Snacks.picker.resume() end, desc = 'Resume' },
    { '<leader>sq', function() Snacks.picker.qflist() end, desc = 'Quickfix List' },
    { '<leader>su', function() Snacks.picker.undo() end, desc = 'Undotree' },

    -- UI
    { '<leader>uC', function() Snacks.picker.colorschemes() end, desc = 'Colorschemes' },

    -- LSP
    { '<leader>cl', function() Snacks.picker.lsp_config() end, desc = 'Lsp Info' },
    { 'gd', function() Snacks.picker.lsp_definitions() end, desc = 'Goto Definition' },
    { 'gD', function() Snacks.picker.lsp_declarations() end, desc = 'Goto Declaration' },
    { 'gr', function() Snacks.picker.lsp_references() end, nowait = true, desc = 'References' },
    { 'gI', function() Snacks.picker.lsp_implementations() end, desc = 'Goto Implementation' },
    { 'gy', function() Snacks.picker.lsp_type_definitions() end, desc = 'Goto Type Definition' },
    { '<leader>cI', function() Snacks.picker.lsp_incoming_calls() end, desc = 'Calls Incoming' },
    { '<leader>cO', function() Snacks.picker.lsp_outgoing_calls() end, desc = 'Calls Outgoing' },
    { '<leader>cs', function() Snacks.picker.lsp_symbols() end, desc = 'LSP Symbols' },
    { '<leader>cS', function() Snacks.picker.lsp_workspace_symbols() end, desc = 'LSP Workspace Symbols' },

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
    { '<leader>bb', '<cmd>e #<cr>', desc = 'Switch to Other Buffer' },
    { '<leader>bd', function() Snacks.bufdelete() end, desc = 'Delete Buffer' },
    { '<leader>bo', function() Snacks.bufdelete.other() end, desc = 'Delete Other Buffers' },
    { '<leader>bi', function() Snacks.bufdelete.invisible() end, desc = 'Delete Invisible Buffers' },
    { '<leader>bD', '<cmd>:bd<cr>', desc = 'Delete Buffer and Window' },

    -- Git
    { '<leader>gd', function() Snacks.picker.git_diff() end, desc = 'Git Diff (hunks)' },
    {
      '<leader>gD',
      function() Snacks.picker.git_diff { base = 'origin', group = true } end,
      desc = 'Git Diff (origin)',
    },
    { '<leader>gs', function() Snacks.picker.git_status() end, desc = 'Git Status' },
    { '<leader>gS', function() Snacks.picker.git_stash() end, desc = 'Git Stash' },
    { '<leader>gL', function() Snacks.picker.git_log() end, desc = 'Git Log (cwd)' },
    { '<leader>gb', function() Snacks.picker.git_log_line() end, desc = 'Git Blame Line' },
    { '<leader>gf', function() Snacks.picker.git_log_file() end, desc = 'Git Current File History' },
    -- { '<leader>gl', function() Snacks.picker.git_log { cwd = LazyVim.root.git() } end, desc = 'Git Current File History' },
  }

  -- map('n', '<leader>gl', function() Snacks.picker.git_log { cwd = LazyVim.root.git() } end, { desc = 'Git Log' })
  -- map({ 'n', 'x' }, '<leader>gB', function() Snacks.gitbrowse() end, { desc = 'Git Browse (open)' })
  -- map({ 'n', 'x' }, '<leader>gY', function()
  --   Snacks.gitbrowse { open = function(url) vim.fn.setreg('+', url) end, notify = false }
  -- end, { desc = 'Git Browse (copy)' })
end

function M.setup_bufferline_keymaps()
  return {
    { '<leader>bj', '<cmd>BufferLinePick<cr>', desc = 'Pick Buffer' },
    { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle Pin' },
    { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete Non-Pinned Buffers' },
    { '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', desc = 'Delete Buffers to the Left' },
    { '<leader>br', '<Cmd>BufferLineCloseRight<CR>', desc = 'Delete Buffers to the Right' },
    { '[b', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
    { '[B', '<cmd>BufferLineMovePrev<cr>', desc = 'Move buffer prev' },
    { ']b', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
    { ']B', '<cmd>BufferLineMoveNext<cr>', desc = 'Move buffer next' },
    { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
    { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
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

  map('<leader>ch', '<cmd>LspClangdSwitchSourceHeader<cr>', 'Toggle source/header')

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
  map('n', '<leader>uf', require('utils.toggle').toggle_formatting, 'Toggle auto-formatting', { silent = true })
end

function M.setup_blink_indent_keymaps()
  Snacks.toggle
    .new({
      id = 'blink_indent',
      name = 'Indent Guides',
      get = function() return require('blink.indent').is_enabled() end,
      set = function(state) require('blink.indent').enable(state) end,
    })
    :map '<leader>ug'
end

function M.setup_undotree_keymaps()
  map('n', '<leader>fu', function() require('undotree').toggle() end, 'Undotree')
end

function M.setup_whichkey(wk)
  wk.add {
    { '<leader><tab>', group = 'tab' },
    { '<leader>a', group = 'avante' },
    { '<leader>c', group = 'code' },
    { '<leader>b', group = 'buffer' },
    { '<leader>g', group = 'git' },
    { '<leader>gh', group = 'hunks' },
    { '<leader>s', group = 'search' },
    { '<leader>sn', group = 'noice' },
    { '<leader>u', group = 'ui' },
    { '<leader>x', group = 'diagnostics/quickfix' },
    { '[', group = 'prev' },
    { ']', group = 'next' },
    { 'g', group = 'goto' },
    { 'gs', group = 'surround' },
    { 'z', group = 'fold' },
    {
      '<leader>b',
      group = 'buffers',
      expand = function() return require('which-key.extras').expand.buf() end,
    },
    {
      '<leader>w',
      group = 'windows',
      proxy = '<c-w>',
      expand = function() return require('which-key.extras').expand.win() end,
    },
    -- better descriptions
    { 'gx', desc = 'Open with system app' },
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
    {
      '<c-w><space>',
      function() require('which-key').show { keys = '<c-w>', loop = true } end,
      desc = 'Window Hydra Mode (which-key)',
    },
  }
end

return M
