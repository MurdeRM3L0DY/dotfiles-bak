local hotkeys_popup = require('awful.hotkeys_popup')
local awful = require('awful')
local menubar = require('menubar')

local super = 'Mod4'
local ctrl = 'Control'
local shift = 'Shift'
local alt = 'Mod1'

awful.keyboard.append_global_keybindings {
  awful.key({ super }, 'd', function()
    awful.spawn('rofi -show drun', false)
  end),
  awful.key(
    { super },
    's',
    hotkeys_popup.show_help,
    { description = 'show help', group = 'awesome' }
  ),
  awful.key(
    { super, ctrl },
    'r',
    awesome.restart,
    { description = 'reload awesome', group = 'awesome' }
  ),
  awful.key(
    { super, shift },
    'q',
    awesome.quit,
    { description = 'quit awesome', group = 'awesome' }
  ),

  awful.key({ super }, 'Return', function()
    awful.spawn('kitty', false)
  end, {
    description = 'open a terminal',
    group = 'launcher',
  }),
  awful.key({ super }, 'p', function()
    menubar.show()
  end, {
    description = 'show the menubar',
    group = 'launcher',
  }),
}

awful.keyboard.append_global_keybindings {
  awful.key({ super }, 'w', function()
    -- awful.spawn('firefox --private', false)
    awful.spawn(
      'chromium --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36"',
      false
    )
  end, {
    description = 'launch browser',
    group = 'apps',
  }),

  awful.key({ super }, 'e', function()
    awful.spawn('thunar', false)
  end, {
    description = 'launch thunar',
    group = 'apps',
  }),
}

-- Monitor Brightness
awful.keyboard.append_global_keybindings {
  awful.key({}, 'XF86MonBrightnessDown', function()
    awful.spawn('brightnessctl s 1-', false)
  end, {
    description = '',
    group = 'awesome',
  }),

  awful.key({}, 'XF86MonBrightnessUp', function()
    awful.spawn('brightnessctl s 1+', false)
  end, {
    description = '',
    group = 'awesome',
  }),
}

-- Tags related keybindings
awful.keyboard.append_global_keybindings {
  awful.key(
    { super },
    'Left',
    awful.tag.viewprev,
    { description = 'view previous', group = 'tag' }
  ),
  awful.key({ super }, 'Right', awful.tag.viewnext, { description = 'view next', group = 'tag' }),
  awful.key(
    { super },
    'Escape',
    awful.tag.history.restore,
    { description = 'go back', group = 'tag' }
  ),
}

-- Focus related keybindings
awful.keyboard.append_global_keybindings {
  awful.key({ super }, 'h', function()
    awful.client.focus.bydirection('left')
  end, {
    description = 'focus left',
    group = 'client',
  }),
  awful.key({ super }, 'j', function()
    awful.client.focus.bydirection('down')
  end, {
    description = 'focus down',
    group = 'client',
  }),
  awful.key({ super }, 'k', function()
    awful.client.focus.bydirection('up')
  end, {
    description = 'focus previous by index',
    group = 'client',
  }),
  awful.key({ super }, 'l', function()
    awful.client.focus.bydirection('right')
  end, {
    description = 'focus right',
    group = 'client',
  }),
  awful.key({ super }, 'Tab', function()
    awful.client.focus.history.previous()
    if client.focus then
      client.focus:raise()
    end
  end, {
    description = 'go back',
    group = 'client',
  }),
  awful.key({ super, ctrl }, 'n', function()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
      c:activate { raise = true, context = 'key.unminimize' }
    end
  end, {
    description = 'restore minimized',
    group = 'client',
  }),
}

-- Layout related keybindings
awful.keyboard.append_global_keybindings {
  awful.key({ super, shift }, 'j', function()
    awful.client.swap.bydirection('down')
  end, {
    description = 'swap down',
    group = 'client',
  }),
  awful.key({ super, shift }, 'k', function()
    awful.client.swap.bydirection('up')
  end, {
    description = 'swap up',
    group = 'client',
  }),
  awful.key({ super, shift }, 'h', function()
    awful.client.swap.bydirection('left')
  end, {
    description = 'swap left',
    group = 'client',
  }),
  awful.key({ super, shift }, 'l', function()
    awful.client.swap.bydirection('right')
  end, {
    description = 'swap right',
    group = 'client',
  }),
  awful.key(
    { super },
    'u',
    awful.client.urgent.jumpto,
    { description = 'jump to urgent client', group = 'client' }
  ),
  awful.key({ super }, 'space', function()
    awful.layout.inc(1)
  end, {
    description = 'select next',
    group = 'layout',
  }),
  awful.key({ super, shift }, 'space', function()
    awful.layout.inc(-1)
  end, {
    description = 'select previous',
    group = 'layout',
  }),
}

-- Media Keys
awful.keyboard.append_global_keybindings {
  awful.key({}, 'XF86AudioLowerVolume', function()
    awful.spawn('wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%- &', false)
  end, {
    description = 'Media Keys',
    group = 'awesome',
  }),

  awful.key({}, 'XF86AudioRaiseVolume', function()
    awful.spawn('wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+ &', false)
  end, {
    description = 'Media Keys',
    group = 'awesome',
  }),

  awful.key({}, 'XF86AudioMute', function()
    awful.spawn('wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle', false)
  end, {
    description = 'Media Keys',
    group = 'awesome',
  }),
}

awful.keyboard.append_global_keybindings {
  awful.key {
    modifiers = { super },
    keygroup = 'numrow',
    description = 'only view tag',
    group = 'tag',
    on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        tag:view_only()
      end
    end,
  },
  awful.key {
    modifiers = { super, ctrl },
    keygroup = 'numrow',
    description = 'toggle tag',
    group = 'tag',
    on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end,
  },
  awful.key {
    modifiers = { super, shift },
    keygroup = 'numrow',
    description = 'move focused client to tag',
    group = 'tag',
    on_press = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end,
  },
  awful.key {
    modifiers = { super, ctrl, shift },
    keygroup = 'numrow',
    description = 'toggle focused client on tag',
    group = 'tag',
    on_press = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:toggle_tag(tag)
        end
      end
    end,
  },
  awful.key {
    modifiers = { super },
    keygroup = 'numpad',
    description = 'select layout directly',
    group = 'layout',
    on_press = function(index)
      local t = awful.screen.focused().selected_tag
      if t then
        t.layout = t.layouts[index] or t.layout
      end
    end,
  },
}
