local UPowerGlib = require('lgi').require('UPowerGlib')
local gobject = require('gears.object')
local gtimer = require('gears.timer')
local dbp = require('module.dbus_proxy')

-- path = '/org/freedesktop/UPower/devices/line_power_ACAD'
-- path = '/org/freedesktop/UPower/devices/battery_BAT0',

local instance = nil

local function N(what)
  require('naughty.init').notify {
    message = require('gears.debug').dump_return(what),
  }
end

-- local device = UPowerGlib.Client():get_display_device()
-- device.on_notify = function(d)
--   N("hello")
-- end

local upower_state = {
  [UPowerGlib.DeviceState.UNKNOWN] = 'N/A',
  [UPowerGlib.DeviceState.CHARGING] = 'Charging',
  [UPowerGlib.DeviceState.DISCHARGING] = 'Discharging',
  [UPowerGlib.DeviceState.EMPTY] = 'N/A',
  [UPowerGlib.DeviceState.FULLY_CHARGED] = 'Full',
  [UPowerGlib.DeviceState.PENDING_CHARGE] = 'Charging',
  [UPowerGlib.DeviceState.PENDING_DISCHARGE] = 'Discharging',
}

local upower_kind = {
  [UPowerGlib.DeviceKind.UNKNOWN] = 'N/A',
  [UPowerGlib.DeviceKind.LINE_POWER] = 1,
  [UPowerGlib.DeviceKind.TABLET] = 'N/A',
  [UPowerGlib.DeviceKind.COMPUTER] = 'N/A',
  [UPowerGlib.DeviceKind.LAST] = 'N/A',
  [UPowerGlib.DeviceKind.BATTERY] = 0,
  [UPowerGlib.DeviceKind.UPS] = 'N/A',
  [UPowerGlib.DeviceKind.MONITOR] = 'N/A',
  [UPowerGlib.DeviceKind.MOUSE] = 'N/A',
  [UPowerGlib.DeviceKind.KEYBOARD] = 'N/A',
  [UPowerGlib.DeviceKind.PDA] = 'N/A',
  [UPowerGlib.DeviceKind.PHONE] = 'N/A',
  [UPowerGlib.DeviceKind.MEDIA_PLAYER] = 'N/A',
}

--
local new = function()
  local ret = gobject {}

  local battery = dbp.Proxy:new {
    bus = dbp.Bus.SYSTEM,
    name = 'org.freedesktop.UPower',
    path = '/org/freedesktop/UPower/devices/DisplayDevice',
    interface = 'org.freedesktop.UPower.Device',
  }

  -- local battery_line_in = dbp.Proxy:new {
  --   bus = dbp.Bus.SYSTEM,
  --   name = 'org.freedesktop.UPower',
  --   path = '/org/freedesktop/UPower/devices/line_power_ACAD',
  --   interface = 'org.freedesktop.UPower.Device',
  -- }

  local on_properties_changed = function(self)
    if self.State == 1 or (self.State == 4 and self.Percentage < 99) then
      ret:emit_signal('upower::battery::CHARGING')
    end

    if self.State == 2 then
      ret:emit_signal('upower::battery::DISCHARGING')
    end

    if self.State == 4 and self.Percentage == 99 then
      ret:emit_signal('upower::battery::FULLY_CHARGED')
    end

    ret:emit_signal('upower::battery', self.Percentage, self.State)
  end

  battery:on_properties_changed(on_properties_changed)

  gtimer.delayed_call(on_properties_changed, battery)

  return ret
end

if not instance then
  instance = new()
end

return instance
