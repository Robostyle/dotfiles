vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = vim.api.nvim_create_augroup('cmake', { clear = true }),
  pattern = { 'cmake', 'CMakeLists.txt' },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
    vim.opt_local.wrap = true
  end,
})

return {
  {
    'virtual-lsp-config',

    dependencies = {
      {
        'mason-org/mason-lspconfig.nvim',
        dependencies = {
          {
            'mason-org/mason.nvim',
          },
        },

        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { 'neocmake' })
        end,
      },
    },

    opts = {
      servers = {
        ---@type vim.lsp.Config
        neocmake = {
          cmd = { 'neocmakelsp', 'stdio' },
          filetypes = { 'cmake' },
          root_markers = { 'CMakePresets.json', 'CTestConfig.cmake', '.git', 'build', 'cmake' },
          single_file_support = true,
          init_options = {
            format = { enable = true },
            lint = { enable = true },
            scan_cmake_in_package = true,
          },
        },
      },
    },
  },

  {
    'stevearc/conform.nvim',

    opts = {
      formatters_by_ft = {
        cmake = { 'gersemi' },
      },
    },

    dependencies = {
      {
        'mason-org/mason.nvim',

        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { 'gersemi' })
        end,
      },
    },
  },
}
