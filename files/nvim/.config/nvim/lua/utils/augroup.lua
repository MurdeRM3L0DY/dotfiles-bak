---@class AuCtx
local AuCtx = {}

--- create autocmd
---@param event string|string[]
---@param opts vim.api.keyset.create_autocmd
---@return integer
function AuCtx.create(event, opts) end

--- clear autocmd
---@param opts vim.api.keyset.clear_autocmds
function AuCtx.clear(opts) end

---@class Augroup
---@operator
---@operator call(fun(cb: fun(au: AuCtx))):nil
---@field id integer
local Augroup = {}

--- delete augroup
function Augroup:del() end

--- create augroup object
---@param group string
---@param augroup_opts vim.api.keyset.create_augroup
---@return Augroup | fun(cb: fun(au: AuCtx))
local function augroup(group, augroup_opts)
  return setmetatable({
    id = vim.api.nvim_create_augroup(
      group,
      vim.tbl_extend('keep', augroup_opts or {}, { clear = true })
    ),
    del = function(self)
      if self.id then
        vim.api.nvim_del_augroup_by_id(self.id)
        self.id = nil
      else
        print("augroup doesn't exist anymore")
      end
    end,
  }, {
    __call = function(self, callback)
      if self.id then
        callback {
          create = function(event, create_opts)
            create_opts.group = self.id
            return vim.api.nvim_create_autocmd(event, create_opts)
          end,
          clear = function(clear_opts)
            clear_opts.group = self.id
            vim.api.nvim_clear_autocmds(clear_opts)
          end,
        }
      else
        print(string.format("augroup '%s' not found", group))
      end
    end,
  })
end

return augroup
