local capi = {
  screen = _G.screen,
  tag = _G.tag,
}

local theme = require 'ui.theme'
local gears = require 'gears'
local awful = require 'awful'

local deck = require 'module.bling.layout.deck'
local mstab = require 'module.bling.layout.mstab'

capi.tag.connect_signal('request::default_layouts', function()
  awful.layout.append_default_layouts {
    awful.layout.suit.tile.left,
    deck,
    awful.layout.suit.floating,
    mstab,
  }
end)

capi.screen.connect_signal('request::wallpaper', function(s)
  -- Wallpaper
  if theme.wallpaper then
    local wallpaper = theme.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == 'function' then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
  end
end)

require('config.screen.wibar').setup {
  size = 24,
}
