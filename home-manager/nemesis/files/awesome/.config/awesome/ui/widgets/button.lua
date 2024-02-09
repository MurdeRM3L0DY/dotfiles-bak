local wibox = require('wibox') ---@module 'wibox.init'
local awful = require('awful')
local gtable = require('gears.table')
local beautiful = require('beautiful.init')

---@class Button
local Button = {}
Button._private = {}

Button._private.normal_fg = ''
Button._private.normal_bg = ''

---@param signal string name of signal to listen to
---@param cb fun(...)
function Button:connect_signal(signal, cb) end

---@param signal string name of signal to trigger
function Button:emit_signal(signal, ...) end

local ButtonT = { __index = Button }

local button_handler = function(m, ret, args)
  return function(...)
    local button = select(4, ...)
    local action = m[button]
    if action then
      local cb = args['on_' .. action]
      if cb then
        cb(...)
      else
        ret:emit_signal('button::' .. action, ...)
      end
    end
  end
end

local function N(what)
  require('naughty.init').notify {
    message = require('gears.debug').dump_return(what),
  }
end

---Text Button Constructor
---@param child table
---@param args table
---@return Button
return function(child, args)
  local w = wibox.widget {
    {
      child,
      halign = args.halign or 'center',
      valign = args.valign or 'center',
      widget = wibox.container.place,
    },
    fg = args.fg,
    bg = args.bg,
    forced_height = args.height,
    forced_width = args.width,
    shape = args.shape,
    widget = wibox.container.background,
  }

  local ret = setmetatable(w, ButtonT)

  local function button_action_map(action)
    return {
      [awful.button.names.LEFT] = action,
      [awful.button.names.MIDDLE] = 'middle_' .. action,
      [awful.button.names.RIGHT] = 'secondary_' .. action,
      [awful.button.names.SCROLL_UP] = 'scroll_up',
      [awful.button.names.SCROLL_DOWN] = 'scroll_down',
    }
  end

  w:connect_signal('button::press', button_handler(button_action_map('press'), ret, args))

  w:connect_signal('button::release', button_handler(button_action_map('release'), ret, args))

  w:connect_signal('mouse::enter', function(...)
    local cb = args.on_mouse_enter
    if cb then
      cb(...)
    end
  end)

  w:connect_signal('mouse::leave', function(...)
    local cb = args.on_mouse_leave
    if cb then
      cb(...)
    end
  end)

  return ret
end
