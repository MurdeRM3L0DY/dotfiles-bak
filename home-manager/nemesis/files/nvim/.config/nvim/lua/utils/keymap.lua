local keymap = {}
-- local co = require 'lib.coroutine'()
local co = coroutine

local set = function(defaults)
  ---@param modes string|string[]
  ---@param lhs string
  ---@param rhs string|fun()
  ---@param opts? table
  return function(modes, lhs, rhs, opts)
    opts = vim.tbl_extend('force', defaults, opts or {})
    local buffer = opts.buffer
    opts.buffer = nil

    if type(rhs) == 'function' then
      opts.callback = (function(callback)
        opts.expr = not opts.noremap
        rhs = ''

        return function()
          local key = callback()
          if key and opts.expr then
            return keymap.t(key)
          end
        end
      end)(rhs)
    end

    if type(modes) == 'string' then
      modes = { modes }
    end

    for _, mode in ipairs(modes) do
      if buffer then
        vim.api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, opts)
      else
        vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
      end
    end
  end
end

local mapping = {}

mapping.new = function(key, rhs, opts)
  return setmetatable({ key = key, rhs = rhs, opts = opts or {} }, { __index = mapping })
end

mapping.iter = function(self)
  local next_mapping

  next_mapping = function(map)
    if type(map.rhs) ~= 'table' then
      co.yield(map.key, map.rhs, map.opts)
    else
      if getmetatable(map.rhs) == mapping then
        map.rhs = { map.rhs }
      end

      for _, rhs in ipairs(map.rhs) do
        next_mapping {
          key = map.key .. rhs.key,
          rhs = rhs.rhs,
          opts = vim.tbl_extend('force', map.opts, rhs.opts),
        }
      end
    end
  end

  return co.wrap(function()
    next_mapping(self)
  end)
end

local key = function(key, map, opts)
  opts = opts or {}

  for mode, rhs in pairs(map) do
    if type(rhs) == 'table' then
      keymap.set(mode, key, rhs.rhs, vim.tbl_extend('force', opts, rhs.opts or {}))
    else
      keymap.set(mode, key, rhs, opts)
    end
  end
end

return setmetatable(keymap, {
  __index = {
    key = key,

    set = set { noremap = true, silent = true },

    t = function(k)
      return vim.api.nvim_replace_termcodes(k, true, true, true)
    end,
  },
  __call = function(_, modes, mappings, defaults)
    if type(modes) ~= 'table' then
      modes = { modes }
    end

    for _, mode in ipairs(modes) do
      for _, map in ipairs(mappings) do
        for lhs, rhs, opts in map:iter() do
          keymap.set(mode, lhs, rhs, vim.tbl_extend('force', defaults or {}, opts))
        end
      end
    end
  end,
})
