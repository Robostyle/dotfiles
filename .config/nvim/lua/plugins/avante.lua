return {

  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
      -- add any opts here
      -- for example
      provider = "ollama",
      ollama = {
        endpoint = "http://[fd7a:115c:a1e0::d5b1:4d]:11434",
        model = "gemma3:27b", -- your desired model (or use gpt-4o, etc.)
        timeout = 90000, -- Timeout in milliseconds, increase this for reasoning models
        temperature = 0,
        max_tokens = 16384, -- Increase this to include reasoning tokens (for reasoning models)
        --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
      },

      auto_suggestions_provider = "gemma3",
      behaviour = {
        auto_suggestions = false, -- Experimental stage
      },

      vendors = {
        gemma3 = {
          __inherited_from = "openai",
          api_key_name = "",
          endpoint = "http://[fd7a:115c:a1e0::d5b1:4d]:11434/v1",
          model = "codegemma",
          disable_tools = true, -- Open-source models often do not support tools.
        },
      },
    },

    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",

    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",

      --- The below dependencies are optional,
      -- "echasnovski/mini.pick", -- for file_selector provider mini.pick
      -- "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      -- "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      -- "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      -- "zbirenbaum/copilot.lua", -- for providers='copilot'
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
