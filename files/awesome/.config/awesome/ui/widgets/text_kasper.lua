-------------------------------------------
-- @author https://github.com/Kasper24
-- @copyright 2021-2022 Kasper24
-------------------------------------------
local gtable = require('gears.table')
local wibox = require('wibox')
local dpi = require('beautiful.xresources').apply_dpi
local theme = require('ui.theme')
local setmetatable = setmetatable
local string = string
local ceil = math.ceil
-- local capi = {
--   awesome = awesome,
-- }

local text = {
  mt = {},
}

local properties = { 'bold', 'italic', 'size', 'color', 'text', 'icon' }

local function build_properties(prototype, prop_names)
  for _, prop in ipairs(prop_names) do
    if not prototype['set_' .. prop] then
      prototype['set_' .. prop] = function(self, value)
        if self._private[prop] ~= value then
          self._private[prop] = value
          self:emit_signal('widget::redraw_needed')
          self:emit_signal('property::' .. prop, value)
        end
        return self
      end
    end
    if not prototype['get_' .. prop] then
      prototype['get_' .. prop] = function(self)
        return self._private[prop]
      end
    end
  end
end

local function generate_markup(self)
  local wp = self._private

  local font = wp.font
  local size = wp.size
  local color = wp.color
  local t = wp.text
  local bold = wp.bold
  local italic = wp.italic

  size = dpi(size)

  -- -- Need to unescape in a case the text was escaped by other code before
  -- text = gstring.xml_unescape(tostring(text))
  -- text = gstring.xml_escape(tostring(text))

  size = ceil(size * 1024)

  local markup = string.format(
    "%s%s<span font_family='%s' font_size='%s' foreground='%s'>%s</span>%s%s",
    bold and '<b>' or '',
    italic and '<i>' or '',
    font,
    math.ceil(size * 1024),
    color,
    t,
    italic and '</i>' or '',
    bold and '</b>' or ''
  )

  self.markup = markup
end

function text:set_icon(icon)
  local wp = self._private

  wp.icon = icon
  wp.defaults.font = wp.font or icon.font
  wp.defaults.size = wp.size or icon.size
  wp.defaults.color = wp.color or icon.color
  wp.defaults.text = icon.icon

  self:emit_signal('widget::redraw_needed')
  self:emit_signal('property::icon', icon)
end

function text:get_size()
  local wp = self._private
  return wp.size
end

local function new()
  local widget = wibox.widget.textbox()
  gtable.crush(widget, text, true)

  local wp = widget._private

  -- Setup default values
  wp.defaults = {}
  wp.defaults.font = theme.font_name
  wp.defaults.size = 20
  wp.defaults.color = theme._.colors.BASE05
  wp.defaults.text = ''

  widget:connect_signal('widget::redraw_needed', function()
    generate_markup(widget)
  end)

  return widget
end

function text.mt:__call()
  return new()
end

build_properties(text, properties)

return setmetatable(text, text.mt)
