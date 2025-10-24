local config = require("defaults")

return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
      provider = "tkhgroup",
      auto_suggestions_provider = "autocomplete",

      providers = {
        tkhgroup = {
          __inherited_from = "openai",
          endpoint = "https://api.mytkhgroup.com/llm/v1",
          disable_tools = false,
          -- model = "deepseek-r1-distill-llama-70b",
          model = "vertex_ai/gemini-2.5-pro",
        },

        autocomplete = {
          __inherited_from = "openai",
          endpoint = "https://api.mytkhgroup.com/llm/v1",
          -- model = "deepseek-r1-distill-llama-70b",
          model = "vertex_ai/gemini-2.5-flash-lite",
        },

        ollama = {
          endpoint = string.format("http://%s:11434", config.llm_endpoint),
          model = "deepseek-r1:14b", -- your desired model (or use gpt-4o, etc.)
          timeout = 90000, -- Timeout in milliseconds, increase this for reasoning models
          -- temperature = 0,
          max_tokens = 32768, -- Increase this to include reasoning tokens (for reasoning models)
          --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
        },

        behaviour = {
          auto_suggestions = false, -- Experimental stage
        },
      },
    },

    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",

      "nvim-mini/mini.icons",
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },

      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },

      {
        "saghen/blink.cmp",
        dependencies = {
          "Kaiser-Yang/blink-cmp-avante",
        },

        opts = {
          sources = {
            -- Add 'avante' to the list
            default = { "avante", "lsp", "path", "snippets", "buffer" },
            providers = {
              avante = {
                module = "blink-cmp-avante",
                name = "Avante",
              },
            },
          },
        },
      },
    },
  },
}
