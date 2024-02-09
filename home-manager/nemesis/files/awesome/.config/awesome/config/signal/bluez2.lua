local lgi = require('lgi')
local gtimer = require('gears.timer')
local gobject = require('gears.object')

local naughty = require('naughty')
local gdebug = require('gears.debug')

local dbp = require('module.dbus_proxy')

local devices = {}

local proxies = {
  object_manager = dbp.Proxy:new {
    bus = dbp.Bus.SYSTEM,
    name = 'org.bluez',
    interface = 'org.freedesktop.DBus.ObjectManager',
    path = '/',
  },
  adapter = dbp.Proxy:new {
    bus = dbp.Bus.SYSTEM,
    name = 'org.bluez',
    interface = 'org.bluez.Adapter1',
    path = '/org/bluez/hci0',
  },
  adapter_properties = dbp.Proxy:new {
    bus = dbp.Bus.SYSTEM,
    name = 'org.bluez',
    interface = 'org.freedesktop.DBus.Properties',
    path = '/org/bluez/hci0',
  },
}

local add_device = function(self, path)
  devices[path] = devices[path]
    or dbp.Proxy:new {
      bus = dbp.Bus.SYSTEM,
      name = 'org.bluez',
      interface = 'org.bluez.Device1',
      path = path,
    }

  if devices[path].Name then
    local device_properties_proxy = dbp.Proxy:new {
      bus = dbp.Bus.SYSTEM,
      name = 'org.bluez',
      interface = 'org.freedesktop.DBus.Properties',
      path = path,
    }

    device_properties_proxy:connect_signal('PropertiesChanged', function(_, _, _)
      self:emit_signal(path .. '::Changed')

      naughty.notify {
        title = 'device_properties_changed_' .. path,
        message = gdebug.dump_return(devices[path].Connected),
      }
    end)
  end

  for p, _ in pairs(devices) do
    if not p:find(path, 1, true) then
      self:emit_signal('device::Added', path, devices[path])
    end
  end
end

local init = function()
  local ret = gobject {}

  ret.scan = function()
    proxies.adapter:StartDiscovery()
  end

  ret.toggle = function()
    local powered = proxies.adapter.Powered
    proxies.adapter:Set('org.bluez.Adapter1', 'Powered', lgi.GLib.Variant('b', not powered))
    proxies.adapter.Powered = { signature = 'b', value = not powered }
  end

  proxies.object_manager:connect_signal('InterfacesAdded', function(_, path, _)
    naughty.notify {
      title = 'InterfacesAdded',
      message = gdebug.dump_return(path),
    }
    add_device(ret, path)
  end)

  proxies.object_manager:connect_signal('InterfacesRemoved', function(_, path, _)
    for p, _ in pairs(devices) do
      if p:find(path, 1, true) then
        ret:emit_signal(path .. '::Removed')
        devices[path] = nil
      end
    end
    naughty.notify {
      title = 'InterfacesRemoved',
      message = gdebug.dump_return(path),
    }
  end)

  proxies.adapter_properties:connect_signal('PropertiesChanged', function(_, _, data)
    naughty.notify {
      title = 'adapter_properties_changed',
      message = gdebug.dump_return(data),
    }
    if data.Powered then
      ret.scan()
    end
  end)

  gtimer.delayed_call(function()
    local objects = proxies.object_manager:GetManagedObjects()
    for path in pairs(objects) do
      if path:find('/org/bluez/hci0/dev_', 1, true) then
        add_device(ret, path)
      end
    end
    ret:emit_signal('adapter', proxies.adapter.Powered)
  end)

  return ret
end

return init()
