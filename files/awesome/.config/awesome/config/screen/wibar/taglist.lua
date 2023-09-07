local gears = require('gears')
local beautiful = require('beautiful') ---@module 'beautiful.init'
local awful = require('awful')
local wibox = require('wibox') ---@module 'wibox.init'

local Button = require('ui.widgets.button')
local Text = require('ui.widgets.text')

local dpi = beautiful.xresources.apply_dpi
local capi = {
  client = client,
}
local theme = require('ui.theme')
local super = 'Mod4'

local function N(what)
  require('naughty.init').notify {
    message = require('gears.debug').dump_return(what),
  }
end

local update_tag_widget = function(w, tag)
  local font_family = theme._.fonts.font_awesome.REGULAR
  local color = theme._.colors.BASE04
  local text = theme._.icons.font_awesome.CIRCLE

  if #tag:clients() > 0 then
    color = theme._.colors.BASE07
    text = theme._.icons.font_awesome.CIRCLE_DOT
  end

  if tag.selected then
    font_family = theme._.fonts.font_awesome.SOLID
    color = theme._.colors.BASE06
    text = theme._.icons.font_awesome.CIRCLE
  end

  w:set {
    font_family = font_family,
    font_size = dpi(15),
    color = color,
    text = text,
  }
end

local set_tag_widget = function(self)
  local w = Text()
  self:set_widget(w)
  return w
end

local taglist = function(s)
  return awful.widget.taglist {
    screen = s,
    buttons = gears.table.join(
      awful.button({}, 1, function(t)
        t:view_only()
      end),
      awful.button({ super }, 1, function(t)
        if capi.client.focus then
          capi.client.focus:move_to_tag(t)
        end
      end),
      awful.button({}, 3, awful.tag.viewtoggle),
      awful.button({ super }, 3, function(t)
        if capi.client.focus then
          capi.client.focus:toggle_tag(t)
        end
      end),
      awful.button({}, 4, function(t)
        awful.tag.viewprev(t.screen)
      end),
      awful.button({}, 5, function(t)
        awful.tag.viewnext(t.screen)
      end)
    ),
    filter = awful.widget.taglist.filter.all,
    layout = wibox.layout.fixed.horizontal,
    widget_template = {
      widget = wibox.container.margin,
      forced_width = dpi(30),
      forced_height = dpi(30),
      create_callback = function(self, tag, index, tags)
        update_tag_widget(set_tag_widget(self), tag)
      end,
      update_callback = function(self, tag, index, tags)
        update_tag_widget(self.widget, tag)
      end,
    },
  }
end

return taglist
