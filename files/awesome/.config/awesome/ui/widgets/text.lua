local wibox = require('wibox') ---@module 'wibox.init'
local base = require('wibox.widget.base')
local gtable = require('gears.table')
local dpi = require('beautiful.init').xresources.apply_dpi
local theme = require('ui.theme')

---@class Text
---@field _private table
local Text = {}

local function N(what)
  require('naughty.init').notify {
    message = require('gears.debug').dump_return(what),
  }
end

local TextT = { __index = Text }

local function generate_markup(self)
  local p = self._private

  local text = p.layout.text
  local font_family = p.font_family
  local font_size = p.font_size
  local color = p.color
  local bold = p.bold
  local italic = p.italic

  local markup = string.format(
    "%s%s<span font_family='%s' font_size='%s' foreground='%s'>%s</span>%s%s",
    bold and '<b>' or '',
    italic and '<i>' or '',
    font_family,
    math.ceil(font_size * 1024),
    color,
    text,
    italic and '</i>' or '',
    bold and '</b>' or ''
  )

  self:set_markup(markup)
end

local function new(args)
  args = args or {}

  local font_family = args.font_family or theme._.fonts.cartograph_cf
  local font_size = args.font_size or dpi(15)

  local w = wibox.widget {
    halign = args.halign or 'center',
    valign = args.valign or 'center',
    font = font_family .. ' ' .. font_size,

    widget = wibox.widget.textbox,
  }

  w:connect_signal('widget::redraw_needed', function()
    generate_markup(w)
  end)

  local p = w._private
  p.font_family = font_family
  p.font_size = font_size
  p.color = args.color or theme._.colors.BASE05
  p.bold = args.bold or false
  p.italic = args.italic or false

  if args.text then
    w:set_text(args.text)
  end

  return gtable.crush(w, Text, true)
end

function Text:set(props)
  local p = self._private
  for key, value in pairs(props) do
    p[key] = value
    if key == 'font_family' or key == 'font_size' then
      p.font = p.font_family .. ' ' .. p.font_size
    end
    if key == 'text' then
      p.layout.text = value
    end
  end

  generate_markup(self)
end

local function build_properties(prototype, prop_names)
  for _, prop in ipairs(prop_names) do
    prototype['get_' .. prop] = function(self)
      return self._private[prop]
    end

    prototype['set_' .. prop] = function(self, value)
      if self._private[prop] == value then
        return
      end

      self._private[prop] = value
      self:emit_signal('widget::redraw_needed')
      self:emit_signal('property::' .. prop, value)
      return self
    end
  end
end

local properties = { 'bold', 'italic', 'font_family', 'font_size', 'color' }
build_properties(Text, properties)

---Text Button Constructor
---@return Text
return setmetatable(Text, {
  __call = function(_, ...)
    return new(...)
  end,
})
