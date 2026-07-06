-- A snazzy 💅 buffer line (with tabpage integration) for Neovim built using lua.

require("lazyload").on_vim_enter(function()
  vim.pack.add({
    { src = "https://github.com/akinsho/bufferline.nvim", version = vim.version.range("*") },
  })

  require("bufferline").setup({
    options = {
      mode = "buffers",
      always_show_bufferline = false,
      name_formatter = function(buf)
        if buf.tabnr then
          local ok, name = pcall(vim.api.nvim_tabpage_get_var, buf.tabnr, "name")
          if ok and name then
            return name
          end
        end
      end,
    },
  })

  vim.keymap.set("n", "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", { desc = "Toggle Pin" })
  vim.keymap.set("n", "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", { desc = "Delete Non-Pinned Buffers" })
  vim.keymap.set("n", "<leader>br", "<Cmd>BufferLineCloseRight<CR>", { desc = "Delete Buffers to the Right" })
  vim.keymap.set("n", "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", { desc = "Delete Buffers to the Left" })
  vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
  vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
  vim.keymap.set("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
  vim.keymap.set("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
  vim.keymap.set("n", "[B", "<cmd>BufferLineMovePrev<cr>", { desc = "Move buffer prev" })
  vim.keymap.set("n", "]B", "<cmd>BufferLineMoveNext<cr>", { desc = "Move buffer next" })
  vim.keymap.set("n", "<leader>bj", "<cmd>BufferLinePick<cr>", { desc = "Pick Buffer" })
  vim.keymap.set("n", "<leader><tab>r", ":BufferLineTabRename ", { desc = "Rename tab" })
end)
