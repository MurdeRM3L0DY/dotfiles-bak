---vim.print(...)
---@param ... unknown
---@return any
function _G.P(...)
  return vim.print(...)
end

--- Reloads the given module, returns any value returned by the given module(`true` when `nil`).
---@param modname string
---@return unknown
function _G.R(modname)
  package.loaded[modname] = nil
  return require(modname)
end

---@param modname string
---@return unknown
function _G.require_lazy(modname)
  if package.loaded[modname] then
    return package.loaded[modname]
  end

  return setmetatable({}, {
    __call = function(_, ...)
      return require(modname)(...)
    end,
    __index = function(_, k)
      return require(modname)[k]
    end,
    __newindex = function(_, k, v)
      require(modname)[k] = v
    end,
  })
end

package.path = table.concat { package.path, ';', '/home/nemesis/.config/nvim/lua/?.so' }
