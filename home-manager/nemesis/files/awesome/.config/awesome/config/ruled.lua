local awful = require('awful')
local ruled = require('ruled')
local screen = _G.screen
local beautiful = require('beautiful')
local dpi = beautiful.xresources.apply_dpi
-- {{{ Rules
-- Rules to apply to new clients.
ruled.client.connect_signal('request::rules', function()
  -- All clients will match this rule.
  ruled.client.append_rule {
    id = 'global',
    rule = {},
    properties = {
      focus = awful.client.focus.filter,
      raise = true,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
    },
  }

  -- Floating clients.
  ruled.client.append_rule {
    id = 'floating',
    rule_any = {
      instance = { 'copyq', 'pinentry' },
      class = {
        'Arandr',
        'Blueman-manager',
        '.blueman-manager-wrapped',
        'Gpick',
        'Kruler',
        'Sxiv',
        'Tor Browser',
        'Wpa_gui',
        'Virt-manager',
        'mpv',
        'xarchiver',
        'veromix',
        'xtightvncviewer',
        'zoom',
        -- 'mpv',
      },
      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name = {
        'Event Tester', -- xev.
        'Choose a folder',
        'New VM',
        'Locate ISO media volume',
        'archlinux on QEMU/KVM',
        'ubuntu22.04 on QEMU/KVM',
        'win10 on QEMU/KVM',
      },
      role = {
        'pop-up', -- e.g. Google Chrome's (detached) Developer Tools.
        'GtkFileChooserDialog',
      },
    },
    properties = {
      placement = awful.placement.centered,
      floating = true,
    },
  }

  -- Add titlebars to normal clients and dialogs
  ruled.client.append_rule {
    id = 'titlebars',
    rule_any = { type = { 'normal', 'dialog' } },
    properties = { titlebars_enabled = false },
  }

  -- ruled.client.append_rule {
  --   id = 'float',
  --   properties = {
  --     placement = awful.placement.centered,
  --     width = 1080,
  --     height = 720,
  --   },
  -- }

  ruled.client.append_rule {
    rule_any = { class = { 'mpv', 'gl' } },
    properties = {
      floating = true,
      placement = awful.placement.centered,
      x = 0,
      y = 0,
      width = 1920,
      height = 1080,
    },
  }

  -- Set Firefox to always map on the tag named "2" on screen 1.
  ruled.client.append_rule {
    rule = { class = 'Chromium-browser' },
    properties = { tag = screen[1].tags[2] },
  }
end)

-- }}}

-- {{{ Notifications

ruled.notification.connect_signal('request::rules', function()
  -- All notifications will match this rule.
  ruled.notification.append_rule {
    rule = {},
    properties = {
      screen = awful.screen.preferred,
      implicit_timeout = 5,
    },
  }
end)
