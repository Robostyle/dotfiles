M = {}

---@class LazyRoot
---@field paths string[]
---@field spec LazyRootSpec

---@alias LazyRootFn fun(buf: number): (string|string[])

---@alias LazyRootSpec string|string[]|LazyRootFn

---@type LazyRootSpec[]
M.spec = { "lsp", { ".git", "lua" }, "cwd" }

M.detectors = {}

---@type table<number, string>
M.cache = {}

-- Function to detect the default branch name
function M.get_default_branch()
  local result = vim.fn.system 'git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null'

  -- Check for errors
  if vim.v.shell_error ~= 0 then
    return 'main' -- fallback to main if command fails
  end

  -- Extract just the branch name from the full reference path
  result = result:gsub('^refs/remotes/origin/', ''):gsub('%s+$', '')

  if result ~= 'master' and result ~= 'main' then
    vim.notify('Default branch detected as: ' .. result, vim.log.levels.WARN)
  end

  if result == '' then
    return 'main' -- fallback to main if empty result
  end

  return result
end

---@param spec LazyRootSpec
---@return LazyRootFn
function M.resolve(spec)
  if M.detectors[spec] then
    return M.detectors[spec]
  elseif type(spec) == "function" then
    return spec
  end
  return function(buf)
    return M.detectors.pattern(buf, spec)
  end
end

---@param opts? { buf?: number, spec?: LazyRootSpec[], all?: boolean }
function M.detect(opts)
  opts = opts or {}
  opts.spec = opts.spec or type(vim.g.root_spec) == "table" and vim.g.root_spec or M.spec
  opts.buf = (opts.buf == nil or opts.buf == 0) and vim.api.nvim_get_current_buf() or opts.buf

  local ret = {} ---@type LazyRoot[]
  for _, spec in ipairs(opts.spec) do
    local paths = M.resolve(spec)(opts.buf)
    paths = paths or {}
    paths = type(paths) == "table" and paths or { paths }
    local roots = {} ---@type string[]
    for _, p in ipairs(paths) do
      local pp = M.realpath(p)
      if pp and not vim.tbl_contains(roots, pp) then
        roots[#roots + 1] = pp
      end
    end
    table.sort(roots, function(a, b)
      return #a > #b
    end)
    if #roots > 0 then
      ret[#ret + 1] = { spec = spec, paths = roots }
      if opts.all == false then
        break
      end
    end
  end
  return ret
end

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@param opts? {normalize?:boolean, buf?:number}
---@return string
function M.get(opts)
  opts = opts or {}
  local buf = opts.buf or vim.api.nvim_get_current_buf()
  local ret = M.cache[buf]
  if not ret then
    local roots = M.detect { all = false, buf = buf }
    ret = roots[1] and roots[1].paths[1] or vim.uv.cwd()
    M.cache[buf] = ret
  end
  if opts and opts.normalize then return ret end
  return ret
end

function M.git()
  local root = M.get()
  local git_root = vim.fs.find('.git', { path = root, upward = true })[1]
  local ret = git_root and vim.fn.fnamemodify(git_root, ':h') or root
  return ret
end

return M
