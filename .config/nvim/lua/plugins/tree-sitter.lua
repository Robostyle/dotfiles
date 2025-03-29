return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- add tsx and treesitter
    vim.list_extend(opts.ensure_installed, {
      "bash",
      "cmake",
      "devicetree",
      "dockerfile",
      "go",
      "html",
      "javascript",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "regex",
      "templ",
      "tsx",
      "typescript",
      "yaml",
    })

    -- Disable in large C++ buffers
    opts.disable = function(lang, bufnr)
      return lang == "cpp" and vim.api.nvim_buf_line_count(bufnr) > 10000
    end
  end,
}
