local M = {}

function M.open_type_hierarchy_in_snacks(kind)
  -- Grab active clients attached to the current buffer that support Type Hierarchies
  local clients = vim.lsp.get_clients { bufnr = 0, method = 'textDocument/prepareTypeHierarchy' }
  if vim.tbl_isempty(clients) then
    vim.notify('No active LSP supports Type Hierarchies', vim.log.levels.WARN)
    return
  end
  local client = clients[1]

  local params = vim.lsp.util.make_position_params(0, client.offset_encoding)

  client:request('textDocument/prepareTypeHierarchy', params, function(err, result)
    if err or not result or vim.tbl_isempty(result) then
      vim.notify('No type hierarchy found under cursor', vim.log.levels.WARN)
      return
    end

    -- Route down to the subtypes/supertypes endpoint
    local method = kind == 'supertypes' and 'typeHierarchy/supertypes' or 'typeHierarchy/subtypes'

    client:request(method, { item = result[1] }, function(sub_err, sub_result)
      if sub_err or not sub_result or vim.tbl_isempty(sub_result) then
        vim.notify('No ' .. kind .. ' found for this class', vim.log.levels.INFO)
        return
      end

      -- Flatten out the results for our Snacks layout
      local items = {}
      for _, item in ipairs(sub_result) do
        table.insert(items, {
          text = item.name,
          file = vim.uri_to_fname(item.uri),
          pos = { item.range['start'].line + 1, item.range['start'].character },
        })
      end

      -- NOTE: Snacks is a global; _G.Snacks = M
      Snacks.picker.pick {
        title = 'Class Hierarchy (' .. kind .. ')',
        items = items,
        format = 'text',
        layout = { preset = 'vscode' },
      }
    end)
  end)
end

return M
