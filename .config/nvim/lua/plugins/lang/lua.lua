local opt = vim.opt_local

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lua' },
  callback = function()
    opt.tabstop = 2
    opt.softtabstop = 2
    opt.shiftwidth = 2
    opt.expandtab = true
  end,
})

return {
  {
    'stevearc/conform.nvim',

    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
      },
    },

    dependencies = {
      {
        'mason-org/mason.nvim',

        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { 'stylua' })
        end,
      },
    },
  },

  {
    'virtual-lsp-config',

    opts = {
      servers = {
        ---@type vim.lsp.Config
        stylua = {
          enabled = false, -- handled by conform.nvim
        },

        ---@type vim.lsp.Config
        lua_ls = {
          -- lsp: https://github.com/luals/lua-language-server
          -- reference: https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/lua_ls.lua
          cmd = { 'lua-language-server' },
          filetypes = { 'lua' },
          root_markers = {
            '.luarc.json',
            '.luarc.jsonc',
            '.luacheckrc',
            '.stylua.toml',
            'stylua.toml',
            'selene.toml',
            'selene.yml',
            '.git',
          },

          log_level = vim.lsp.protocol.MessageType.Warning,

          settings = {
            Lua = {
              runtime = {
                version = 'LuaJIT',
              },

              workspace = {
                checkThirdParty = false,
                ignoreDir = { 'stow' },
              },

              codeLens = {
                enable = false, -- causes annoying flickering
              },

              completion = {
                callSnippet = 'Replace',
              },

              doc = {
                privateName = { '^_' },
              },

              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = 'Disable',
                semicolon = 'Disable',
                arrayIndex = 'Disable',
              },

              format = {
                enable = false, -- use stylua instead
              },
            },
          },
        },
      },
    },

    dependencies = {
      {
        'mason-org/mason-lspconfig.nvim',

        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { 'lua_ls' })
        end,

        dependencies = {
          {
            'mason-org/mason.nvim',
          },
        },
      },

      {
        'folke/lazydev.nvim',

        opts = {
          library = {

            -- Library paths can be absolute
            -- "~/projects/my-awesome-lib",

            -- Or relative, which means they will be resolved from the plugin dir.
            'lazy.nvim',
            'neotest',
            'plenary',

            -- It can also be a table with trigger words / mods
            -- Only load luvit types when the `vim.uv` word is found
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },

            -- always load the LazyVim library
            -- "LazyVim",

            -- Only load the lazyvim library when the `LazyVim` global is found
            { path = 'LazyVim', words = { 'LazyVim' } },
            { path = 'snacks.nvim', words = { 'Snacks' } },
            { path = 'lazy.nvim', words = { 'LazyVim' } },
          },
        },
      },

      {
        'Bilal2453/luvit-meta',
        lazy = true,
      }, -- optional `vim.uv` typings

      { -- optional blink completion source for require statements and module annotations
        'saghen/blink.cmp',
        opts = {
          sources = {
            -- add lazydev to your completion providers
            default = { 'lazydev' },
            providers = {
              lazydev = {
                name = 'LazyDev',
                module = 'lazydev.integrations.blink',
                -- make lazydev completions top priority (see `:h blink.cmp`)
                score_offset = 100,
              },
            },
          },
        },
        opts_extend = {
          'sources.default',
        },
      },
    },
  },
}
