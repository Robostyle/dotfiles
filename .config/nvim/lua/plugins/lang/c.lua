-- Installs lsp support for C, C++, objc, opjcpp, and opencl
--
-- Two languages servers are installed 'ccls' and 'clangd'.
-- The main reason for 'ccls' is that it support call in/out and codelens
-- support.
--
-- Formatting is handled by 'clang-format'.
--
-- Note: 'clangd' is currently disabled

local opt = vim.opt_local

local file_types = { 'c', 'cpp', 'objc', 'objcpp', 'opencl' }

local enableClangd = true
local enableCcls = false

vim.api.nvim_create_autocmd('FileType', {
  pattern = file_types,
  callback = function()
    opt.tabstop = 4
    opt.softtabstop = 4
    opt.shiftwidth = 4
    opt.expandtab = true
  end,
})

local function get_clangd_server_config()
  ---@type vim.lsp.Config
  return {
    cmd = {
      'clangd',
      '--background-index',
      '--clang-tidy',
      '--header-insertion=iwyu',
      '--completion-style=detailed',
      '--function-arg-placeholders',
      '--fallback-style=llvm',
    },
    filetypes = file_types,
    root_markers = {
      'compile_commands.json',
      'compile_flags.txt',
      'configure.ac', -- AutoTools
      'Makefile',
      'configure.ac',
      'configure.in',
      'config.h.in',
      'meson.build',
      'meson_options.txt',
      'build.ninja',
      '.git',
    },
    capabilities = {
      offsetEncoding = { 'utf-16' },
    },
    init_options = {
      usePlaceholders = true,
      completeUnimported = true,
      clangdFileStatus = true,
    },
  }
end

local function get_ccls_server_config()
  local cpu_count = #vim.uv.cpu_info()
  local ccls_threads = math.max(1, cpu_count - 1)

  ---@type vim.lsp.Config
  return {
    cmd = { 'ccls', '--log-file=/tmp/ccls.log', '--v=0' },
    filetypes = file_types,
    init_options = {
      threads = ccls_threads,
      index = {
        trackDependency = 1,
        blacklist = { '^build/', '^.cache/', '^bin/', '^packaging', '^res' },
      },
      cache = {
        directory = '.ccls-cache',
      },
    },
  }
end

local function get_ccls_plugin_config()
  local disable_caps = enableClangd
      and {
        disable_capabilities = {
          completionProvider = true,
          documentFormattingProvider = true,
          definitionProvider = true,
          documentRangeFormattingProvider = true,
          documentHighlightProvider = true,
          documentSymbolProvider = true,
          hoverProvider = true,
          referencesProvider = true,
          renameProvider = true,
          typeDefinitionProvider = true,
          workspaceSymbolProvider = true,
        },
        disable_diagnostics = true,
        disable_signature = true,
      }
    or {}

  local ccls_plugin_opts = {
    lsp = {
      codelens = {
        enable = true,
        events = { 'BufWritePost', 'InsertLeave' }, -- optional, these are not the defaults
      },
    },
  }

  ccls_plugin_opts.lsp = vim.tbl_deep_extend('force', ccls_plugin_opts.lsp, disable_caps)

  local config = {
    'ranjithshegde/ccls.nvim',
    opts = ccls_plugin_opts,
  }

  return config
end

local function get_clang_format_plugin_config()
  return {
    'stevearc/conform.nvim',

    opts = {
      formatters_by_ft = {
        cpp = { 'clang-format' },
      },
    },

    dependencies = {
      'mason-org/mason.nvim',
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, { 'clang-format' })
      end,
    },
  }
end

local function create_config()
  local config = {}
  local servers = {}
  local virtual_dependencies = {}

  table.insert(config, get_clang_format_plugin_config())

  if enableClangd then
    servers.clangd = get_clangd_server_config()

    table.insert(virtual_dependencies, {
      'mason-org/mason-lspconfig.nvim',
      dependencies = {
        'mason-org/mason.nvim',
      },

      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, { 'clangd' })
      end,
    })
  end

  if enableCcls then
    servers.ccls = get_ccls_server_config()

    table.insert(config, get_ccls_plugin_config())
  end

  if next(servers) ~= nil then
    table.insert(config, {
      'virtual-lsp-config',

      dependencies = #virtual_dependencies > 0 and virtual_dependencies or nil,
      opts = {
        servers = servers,
        keys = {
          {
            '<leader>ch',
            '<cmd>LspClangdSwitchSourceHeader<cr>',
            desc = 'Switch Source/Header (C/C++)',
          },
        },
      },
    })
  end

  return config
end

return create_config()
