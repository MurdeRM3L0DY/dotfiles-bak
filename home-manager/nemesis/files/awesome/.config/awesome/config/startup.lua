local awful = require('awful')
local naughty = require('naughty')

naughty.connect_signal('request::display_error', function(message, startup)
  naughty.notification {
    urgency = 'critical',
    title = 'Oops, an error happened' .. (startup and ' during startup!' or '!'),
    message = message,
  }
end)

naughty.connect_signal('request::display', function(n)
  naughty.layout.box { notification = n }
end)

awful.spawn('compfy -b', false)
awful.spawn('/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1', false)
awful.spawn('nm-applet &')
-- local helpers = require('config.helpers')
--
-- helpers.run.run_once_grep('compfy -b')
-- helpers.run.run_once_grep('/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &')
-- -- helpers.run.run_once_ps(
-- --   'polkit-gnome-authentication-agent-1',
-- --
-- -- )
-- helpers.run.run_once_grep('nm-applet &')
