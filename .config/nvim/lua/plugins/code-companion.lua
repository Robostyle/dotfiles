return {
  enabled = false,

  -- Core plugin configuration
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",

    {
      "saghen/blink.cmp",
      -- @module 'blink.cmp'
      -- @type blink.cmp.Config
      opts = {
        sources = {
          default = { "codecompanion" },
          providers = {
            codecompanion = {
              name = "CodeCompanion",
              module = "codecompanion.providers.completion.blink",
              enabled = true,
            },
          },
        },
      },
      opts_extends = {
        "sources.default",
      },
    },
  },

  -- Plugin setup and configuration
  config = true,
  opts = {
    strategies = {
      slash_commands = {
        opts = {},
      },
      chat = { adapter = "llama3" },
      inline = { adapter = "llama3" },
    },

    adapters = {
      llama3 = function()
        return require("codecompanion.adapters").extend("ollama", {
          schema = {
            -- model = { default = "deepseek-r1:32b" },
            model = { default = "qwq" },
          },
          num_ctx = {
            default = 16384,
          },
          num_predict = {
            default = -1,
          },
          env = {
            url = "http://100.81.18.112:11434", -- API. endpoint
          },
        })
      end,
    },
  },

  -- Add keybindings section to enable chat toggling
  keys = {
    { "<leader>ac", ":CodeCompanionChat toggle<cr>", desc = "Toggle Code Companion chat" },
    { "<leader>aa", ":CodeCompanionActions<cr>", desc = "Toggle Code Companion chat" },
    { "<leader>ai", mode = { "v" }, ":CodeCompanion<cr>", desc = "Inline Code Companion " },
  },
}
