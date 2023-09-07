local capi = {
  screen = _G.screen,
}

local gears = require('gears')
local awful = require('awful')
local wibox = require('wibox') ---@module 'wibox.init'

local theme = require('ui.theme')

local upower = require('config.signal.upower2')
local animation = require('module.animation')
local color = require('module.color')

local dpi = require('beautiful.xresources').apply_dpi

local Button = require('ui.widgets.button')
local Text = require('ui.widgets.text')

local function N(what)
  require('naughty.init').notify {
    message = require('gears.debug').dump_return(what),
  }
end

local power_text_widget = Text {
  text = theme._.icons.font_awesome.POWER_OFF,
  color = theme._.colors.BASE06,
  font_family = theme._.fonts.font_awesome.SOLID,
  font_size = dpi(10),
}

local power = wibox.widget {
  Button(power_text_widget, {
    on_mouse_enter = function()
      -- N(power_text_widget)
    end,
    on_press = function()
      power_text_widget:set { text = 'T', color = '#FF0000' }
    end,
  }),

  max_value = 99,
  min_value = 0,
  start_angle = 3 / 2 * math.pi,
  thickness = dpi(3),
  rounded_edge = true,
  widget = wibox.container.arcchart,
}

local power_anim = animation:new {
  reset_on_stop = false,
  easing = animation.easing.linear,
  loop = true,
  update = function(self, pos)
    power:set_start_angle(pos * math.pi)
  end,
}

power_anim:connect_signal('started', function()
  power:set_value(20)
end)

upower:connect_signal('upower::battery', function(_, percentage, state)
  -- CHARGING
  -- if state == 1 or (state == 4 and percentage < 99) then
  --   power_anim:start { pos = 1.5, target = -0.5, duration = 0.5 }
  -- end

  -- DISCHARGING OR FULLY_CHARGED
  -- if state == 2 or (state == 4 and percentage == 99) then
  --   power_anim:stop()
  -- end

  if power_anim.state == false then
    power:set_value(percentage)
    power:set_start_angle((1.5 - (2 * percentage / 99)) * math.pi)
  end
end)

return power
