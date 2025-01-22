return {
  enabled = true,

  -- Core plugin configuration
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },

  -- Plugin setup and configuration
  config = true,
  opts = {
    strategies = {
      chat = { adapter = "llama3" },
      inline = { adapter = "llama3" },
    },

    adapters = {
      llama3 = function()
        print("hello")
        return require("codecompanion.adapters").extend("ollama", {
          name = "llama3",
          schema = {
            model = { default = "deepseek-r1:32b" },
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
    { "<leader>aa", mode = { "v" }, ":CodeCompanion<cr>", desc = "Inline Code Companion " },
  },
}
