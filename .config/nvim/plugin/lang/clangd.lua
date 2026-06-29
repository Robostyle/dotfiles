require("lazyload").on_vim_enter(function()
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserClangdLspConfig", { clear = true }),
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      -- Only apply this keymap if the attaching LSP is clangd
      if client and client.name == "clangd" then
        local bufnr = args.buf

        -- Bind the key (e.g., <leader>gh for "Go to Header/Source")
        vim.keymap.set("n", "<leader>ch", "<cmd>LspClangdSwitchSourceHeader<cr>", {
          buffer = bufnr,
          desc = "Clangd: Switch between Source/Header",
        })
      end
    end,
  })
end)
