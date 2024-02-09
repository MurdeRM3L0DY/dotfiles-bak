-------------------------------------------
-- @author https://github.com/Kasper24
-- @copyright 2021-2022 Kasper24
-------------------------------------------

local UPowerGlib = require('lgi').require('UPowerGlib')
local gobject = require('gears.object')
local gtimer = require('gears.timer')

local instance = nil

local function new()
  local ret = gobject {}

  local battery = UPowerGlib.Client():get_display_device()

  -- battery:connect_signal('PropertiesChanged', function(a, b)
  --   require('naughty').notify {
  --     title = 'battery::update',
  --     message = require('gears.debug').dump_return(a, b),
  --   }
  -- end)

  battery.on_notify = function(self, data)
    -- require('naughty').notify {
    --   title = 'battery::update',
    --   message = require('gears.debug').dump_return(self),
    -- }
    if battery.model ~= '' and battery.model ~= nil then
      ret:emit_signal('battery::update', battery)
    end
  end

  gtimer.delayed_call(function()
    if battery.model ~= '' and battery.model ~= nil then
      ret:emit_signal('battery::update', battery)
    end
  end)

  return ret
end

if not instance then
  instance = new(...)
end
return instance
