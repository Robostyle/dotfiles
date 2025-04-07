--- Ollama config for CodeCompanion.
local ollama_fn = function()
  return require("codecompanion.adapters").extend("ollama", {
    schema = {
      model = {
        default = "qwq",
      },
      num_ctx = {
        default = 16384,
      },
      num_predict = {
        default = -1,
      },
      env = {
        url = "http://[fd7a:115c:a1e0::d5b1:4d]:11434",
      },
    },
  })
end

local supported_adapters = {
  ollama = ollama_fn,
}

return {
  {
    "olimorris/codecompanion.nvim",
    config = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- {
      --   "saghen/blink.cmp",
      --   ---@module 'blink.cmp'
      --   ---@type blink.cmp.Config
      --   opts = {
      --     sources = {
      --       default = { "codecompanion" },
      --       providers = {
      --         codecompanion = {
      --           name = "CodeCompanion",
      --           module = "codecompanion.providers.completion.blink",
      --           enabled = true,
      --         },
      --       },
      --     },
      --   },
      --   opts_extend = {
      --     "sources.default",
      --   },
      -- },
    },

    opts = {
      adapters = supported_adapters,

      strategies = {
        chat = {
          adapter = "ollama",
          slash_commands = {
            buffer = { opts = { provider = "snacks" } },
            file = { opts = { provider = "snacks" } },
            help = { opts = { provider = "snacks" } },
            symbols = { opts = { provider = "snacks" } },
          },
          -- tools = {
          --   mcp = {
          --     callback = function()
          --       return require("mcphub.extensions.codecompanion")
          --     end,
          --     description = "Call tools and resources from the MCP Servers",
          --     opts = {
          --       requires_approval = true,
          --     },
          --   },
          -- },
        },
        inline = {
          adapter = "ollama",
        },
        cmd = {
          adapter = "ollama",
        },
      },
    },
  },
}
