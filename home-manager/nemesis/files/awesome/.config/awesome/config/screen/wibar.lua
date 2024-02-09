local capi = {
  screen = _G.screen,
  awesome = _G.awesome,
}

local awful = require('awful')
local wibox = require('wibox') ---@module 'wibox.init'
local xresources = require('beautiful.xresources')

local animation = require('module.animation')
local rubato = require('module.rubato')
local taglist = require('config.screen.wibar.taglist')
-- local nm = require('config.signal.nm')
local theme = require('ui.theme')
local Div = require('ui.widgets.div')
local Text = require('ui.widgets.text')
local Button = require('ui.widgets.button')
-- local bluez = require('config.signal.bluez2')

local dpi = xresources.apply_dpi

local function N(what)
  require('naughty.init').notify {
    message = require('gears.debug').dump_return(what),
  }
end

local C = theme._.colors

local wibar = function(s, args)
  -- Each screen has its own tag table.
  awful.tag({ '1', '2', '3', '4', '5' }, s, awful.layout.layouts[1])

  local mylayoutbox = wibox.widget {
    screen = s,
    forced_width = dpi(30),
    forced_height = dpi(30),
    buttons = {
      awful.button({}, 1, function()
        awful.layout.inc(1)
      end),
      awful.button({}, 3, function()
        awful.layout.inc(-1)
      end),
      awful.button({}, 4, function()
        awful.layout.inc(-1)
      end),
      awful.button({}, 5, function()
        awful.layout.inc(1)
      end),
    },
    widget = awful.widget.layoutbox,
  }

  local mytasklist = awful.widget.tasklist {
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    layout = {
      layout = wibox.layout.fixed.horizontal,
    },
    buttons = {
      awful.button({}, 1, function(c)
        c:activate { context = 'tasklist', action = 'toggle_minimization' }
      end),
      awful.button({}, 4, function()
        awful.client.focus.byidx(-1)
      end),
      awful.button({}, 5, function()
        awful.client.focus.byidx(1)
      end),
    },
  }

  local systray = wibox.widget {
    horizontal = true,
    widget = wibox.widget.systray,
  }

  local htextclock = wibox.widget {
    format = '%H',
    font = 'Cartograph CF Bold Italic ' .. '10',
    halign = 'center',
    valign = 'center',
    widget = wibox.widget.textclock,
  }
  local mtextclock = wibox.widget {
    format = '%M',
    font = 'Cartograph CF Bold Italic ' .. '10',
    halign = 'center',
    valign = 'center',
    widget = wibox.widget.textclock,
  }

  local margins = theme.useless_gap

  awful
    .popup({
      screen = s,
      minimum_width = s.geometry.width,
      maximum_height = dpi(args.size),

      x = 0,
      y = s.geometry.height - args.size,
      bg = C.BASE00,
      widget = {
        Div({
          mylayoutbox,
          mytasklist,

          layout = wibox.layout.fixed.horizontal,
        }, { halign = 'left' }),
        Div(taglist(s), { halign = 'center' }),
        Div({
          systray,
          Div({
            htextclock,
            mtextclock,

            forced_width = dpi(70),
            spacing = dpi(5),

            layout = wibox.layout.flex.horizontal,
          }, {}),
          require('config.screen.wibar.power'),

          spacing = dpi(10),
          layout = wibox.layout.flex.horizontal,
        }, { halign = 'right' }),

        layout = wibox.layout.flex.horizontal,
      },
    })
    :struts { bottom = dpi(args.size) }
end

return {
  setup = function(args)
    capi.screen.connect_signal('request::desktop_decoration', function(s)
      wibar(s, args)
    end)
  end,
}
