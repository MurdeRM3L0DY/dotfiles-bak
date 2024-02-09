local wibox = require('wibox') ---@module "wibox.init"
local gtable = require('gears.table')

---@class Div
local Div = {}

-- ---@param signal string name of signal to listen to
-- ---@param cb fun(...)
-- function Div:connect_signal(signal, cb) end
--
-- ---@param signal string name of signal to trigger
-- function Div:emit_signal(signal, ...) end

local DivT = { __index = Div }

local function extract_prop(t, v)
  local r = t[v]
  t[v] = nil
  return r
end

---Text Button Constructor
---@param args table
---@return Div
return function(child, args)
  local fg = extract_prop(args, "fg")
  local bg = extract_prop(args, "bg")
  local halign = extract_prop(args, "halign")
  local valign = extract_prop(args, "valign")

  local w = wibox.widget(gtable.crush({
    {
      {
        child,
        widget = wibox.container.margin,
      },

      fg = fg,
      bg = bg,
      widget = wibox.container.background,
    },

    halign = halign,
    valign = valign,

    widget = wibox.container.place,
  }, args, true))


  local self = setmetatable(w, DivT)

  return self
end
