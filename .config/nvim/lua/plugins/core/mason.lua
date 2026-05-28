-- Portable package manager for Neovim that runs everywhere Neovim runs.
-- Easily install and manage LSP servers, DAP servers, linters, and formatters.

return {
  {
    -- Note: changed to the official repository name
    'mason-org/mason.nvim',

    opts = {
      PATH = 'append', -- keeps system-installed tools prioritized
    },

    config = function(_, opts)
      -- Initialize Mason normally
      require('mason').setup(opts)

      local registry = require 'mason-registry'

      if opts.ensure_installed == nil then return end

      registry.refresh(function()
        for _, pkg_name in ipairs(opts.ensure_installed) do
          local ok, pkg = pcall(registry.get_package, pkg_name)
          if ok and not pkg:is_installed() then pkg:install() end
        end
      end)
    end,
  },
}
