local dpi = require('beautiful.xresources').apply_dpi

local theme = {}

-- user theme lib
theme._ = {}

-- local C = {
--   BASE00 = '#090A11',
--   BASE01 = '#1E1E2E',
--   BASE02 = '#212145',
--   BASE03 = '#7B819D', -- Overlay1 (hsl '#7B819D'),
--   BASE04 = '#8E95B4', -- Overlay2 (hsl '#8E95B3'),
--   BASE05 = '#C0C8F2',
--   BASE06 = '#80AAFF',
--   BASE07 = '#9E75F0',
--
--   BASE08 = '#FFB3B3',
--   BASE09 = '#FF7366',
--   BASE0A = '#FFFFB3',
--   BASE0B = '#33FFBB',
--   BASE0C = '#E6194D',
--   BASE0D = '#3355FF',
--   BASE0E = '#8000FF',
--   BASE0F = '#F53D7A',
-- }

-- <flavours>
local C = {}

C.BASE00 = '#1e1e2e'
C.BASE01 = '#212047'
C.BASE02 = '#45475a'
C.BASE03 = '#7f849c'
C.BASE04 = '#9399b2'
C.BASE05 = '#c0c8f2'
C.BASE06 = '#80aaff'
C.BASE07 = '#9e75f0'

C.BASE08 = '#ffb3b3'
C.BASE09 = '#ff7366'
C.BASE0A = '#ffffb3'
C.BASE0B = '#33ffbb'
C.BASE0C = '#f0004c'
C.BASE0D = '#3355f0'
C.BASE0E = '#8000ff'
C.BASE0F = '#ff0080'
-- </flavours>

theme._.fonts = {}
theme._.icons = {}

theme._.fonts.cartograph_cf = 'Cartograph CF Regular'
theme._.fonts.font_awesome = {
  REGULAR = 'Font Awesome 6 Pro Regular',
  SOLID = 'Font Awesome 6 Pro Solid',
  LIGHT = 'Font Awesome 6 Pro Light',
  THIN = 'Font Awesome 6 Pro Thin',
  SHARP = 'Font Awesome 6 Pro Sharp',
}

theme._.icons.font_awesome = {
  POWER_OFF = '',
  CIRCLE = '',
  CIRCLE_DOT = '',
}
theme._.icons.nerd_font = {}

-- start flavours
-- end flavours

theme.wallpaper = os.getenv('HOME') .. '/Pictures/looking-into-the-universe.png'

theme.useless_gap = dpi(5)
theme.border_width = dpi(2)

theme.bg_normal = C.BASE00

theme.font = theme._.fonts.cartograph_cf .. ' 10'

-- taglist
theme.taglist_bg_focus = C.BASE06
theme.taglist_fg_focus = C.BASE02

theme.tabbed_spawn_in_tab = true
theme.tabbed_disable = false
theme.tabbar_size = 20

theme._.colors = C

return theme
