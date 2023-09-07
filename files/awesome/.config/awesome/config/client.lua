require('awful.autofocus')

local client = client
local awful = require('awful')
local wibox = require('wibox')
local theme = require('ui.theme')

local C = theme._.colors

local super = 'Mod4'
local ctrl = 'Control'
local shift = 'Shift'
local alt = 'Mod1'

-- {{{ Titlebars
-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal('request::titlebars', function(c)
  -- buttons for the titlebar
  local buttons = {
    awful.button({}, 1, function()
      c:activate { context = 'titlebar', action = 'mouse_move' }
    end),
    awful.button({}, 3, function()
      c:activate { context = 'titlebar', action = 'mouse_resize' }
    end),
  }

  awful.titlebar(c).widget = {
    { -- Left
      awful.titlebar.widget.iconwidget(c),
      buttons = buttons,
      layout = wibox.layout.fixed.horizontal,
    },
    { -- Middle
      { -- Title
        align = 'center',
        widget = awful.titlebar.widget.titlewidget(c),
      },
      buttons = buttons,
      layout = wibox.layout.flex.horizontal,
    },
    { -- Right
      awful.titlebar.widget.floatingbutton(c),
      awful.titlebar.widget.maximizedbutton(c),
      awful.titlebar.widget.stickybutton(c),
      awful.titlebar.widget.ontopbutton(c),
      awful.titlebar.widget.closebutton(c),
      layout = wibox.layout.fixed.horizontal(),
    },
    layout = wibox.layout.align.horizontal,
  }
end)
client.connect_signal('request::default_mousebindings', function()
  awful.mouse.append_client_mousebindings {
    awful.button({}, 1, function(c)
      c:activate { context = 'mouse_click' }
    end),
    awful.button({ super }, 1, function(c)
      c:activate { context = 'mouse_click', action = 'mouse_move' }
    end),
    awful.button({ super }, 3, function(c)
      c:activate { context = 'mouse_click', action = 'mouse_resize' }
    end),
  }
end)

client.connect_signal('request::default_keybindings', function()
  awful.keyboard.append_client_keybindings {
    awful.key({ super, shift }, 'Down', function(c)
      c:relative_move(0, 20, 0, 0)
    end),
    awful.key({ super, shift }, 'Up', function(c)
      c:relative_move(0, -20, 0, 0)
    end),
    awful.key({ super, shift }, 'Left', function(c)
      c:relative_move(-20, 0, 0, 0)
    end),
    awful.key({ super, shift }, 'Right', function(c)
      c:relative_move(20, 0, 0, 0)
    end),
    awful.key({ super }, 'f', function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end, {
      description = 'toggle fullscreen',
      group = 'client',
    }),
    awful.key({ super }, 'q', function(c)
      c:kill()
    end, {
      description = 'close',
      group = 'client',
    }),
    awful.key(
      { super, ctrl },
      'space',
      awful.client.floating.toggle,
      { description = 'toggle floating', group = 'client' }
    ),
    awful.key({ super, ctrl }, 'Return', function(c)
      c:swap(awful.client.getmaster())
    end, {
      description = 'move to master',
      group = 'client',
    }),
    awful.key({ super }, 'o', function(c)
      c:move_to_screen()
    end, {
      description = 'move to screen',
      group = 'client',
    }),
    awful.key({ super }, 't', function(c)
      c.ontop = not c.ontop
    end, {
      description = 'toggle keep on top',
      group = 'client',
    }),
    awful.key({ super }, 'n', function(c)
      -- The client currently has the input focus, so it cannot be
      -- minimized, since minimized clients can't have the focus.
      c.minimized = true
    end, {
      description = 'minimize',
      group = 'client',
    }),
    awful.key({ super }, 'm', function(c)
      c.maximized = not c.maximized
      c:raise()
    end, {
      description = '(un)maximize',
      group = 'client',
    }),
    awful.key({ super, ctrl }, 'm', function(c)
      c.maximized_vertical = not c.maximized_vertical
      c:raise()
    end, {
      description = '(un)maximize vertically',
      group = 'client',
    }),
    awful.key({ super, shift }, 'm', function(c)
      c.maximized_horizontal = not c.maximized_horizontal
      c:raise()
    end, {
      description = '(un)maximize horizontally',
      group = 'client',
    }),
  }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal('mouse::enter', function(c)
  c:activate { context = 'mouse_enter', raise = false }
end)

client.connect_signal('focus', function(c)
  c.border_color = C.BASE06
end)

client.connect_signal('unfocus', function(c)
  c.border_color = C.BASE07
end)
