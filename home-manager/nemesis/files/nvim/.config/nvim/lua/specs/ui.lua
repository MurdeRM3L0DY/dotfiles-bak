local USER_AUGROUP = require('config.autocmds')

return {
  {
    'utilyre/barbecue.nvim',
    -- enabled = false,
    event = { 'UIEnter', 'BufReadPost' },
    version = '*',
    dependencies = {
      { 'SmiteshP/nvim-navic' },
    },
    config = function()
      require('barbecue').setup {
        theme = {
          normal = { bold = true, italic = true },
        },
      }
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    -- lazy = false,
    config = function()
      require('catppuccin').setup {
        flavour = 'mocha', -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = 'latte',
          dark = 'mocha',
        },
        transparent_background = false, -- disables setting the background color.
        show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
        term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
          enabled = false, -- dims the background color of inactive window
          shade = 'dark',
          percentage = 0.15, -- percentage of the shade to apply to the inactive window
        },
        no_italic = false, -- Force no italic
        no_bold = false, -- Force no bold
        no_underline = false, -- Force no underline
        styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
          comments = { 'italic' }, -- Change the style of comments
          conditionals = { 'italic' },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        color_overrides = {},
        custom_highlights = {},
        integrations = {
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { 'italic' },
              hints = { 'italic' },
              warnings = { 'italic' },
              information = { 'italic' },
            },
            underlines = {
              errors = { 'undercurl' },
              hints = { 'undercurl' },
              warnings = { 'undercurl' },
              information = { 'undercurl' },
            },
            inlay_hints = {
              background = true,
            },
          },
          navic = true,
          neogit = true,
          neotree = true,
          semantic_tokens = true,
          mason = true,
          barbar = true,
          markdown = true,
          octo = true,
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = false,
          mini = true,
          noice = true,
          flash = true,
          lsp_trouble = true,
          -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
        -- compile_path = '',
        highlight_overrides = {},
      }

      vim.cmd.colorschem('catppuccin')
    end,
  },
  {
    'rebelot/heirline.nvim',
    event = 'UIEnter',
    init = function(p)
      USER_AUGROUP(function(au)
        au.create('User', {
          pattern = 'Flavours',
          callback = function()
            require('lazy').reload { plugins = { p } }
          end,
          once = true,
        })
      end)
    end,
    config = function()
      local C = require('utils.palette')
      local augroup = require('utils.augroup')
      local settings = require('utils.settings')

      local heirline = require('heirline')

      local HEIRLINE_AUGROUP = augroup('HEIRLINE_AUGROUP', {})

      HEIRLINE_AUGROUP(function(au)
        au.create({ 'ColorScheme' }, {
          callback = function()
            heirline.reset_highlights()
          end,
        })
      end)

      local sep = {
        vertical_bar = '┃',
        vertical_bar_thin = '│',
        left = '',
        right = '',
        block = '█',
        block_thin = '▌',
        left_filled = '',
        right_filled = '',
        slant_left = '',
        slant_right = '',
        slant_left_thin = '',
        slant_right_thin = '',
        slant_left_2 = '',
        slant_right_2 = '',
        left_rounded = '',
        right_rounded = '',
        left_rounded_thin = '',
        right_rounded_thin = '',
        circle = '●',
      }

      local api = vim.api
      local bo = vim.bo

      local str_find = string.find
      local str_sub = string.sub
      local str_match = string.match
      local str_rep = string.rep

      local nvim_get_mode = api.nvim_get_mode
      local nvim_buf_get_name = api.nvim_buf_get_name
      local diagnostic_get = vim.diagnostic.get
      local fnamemodify = vim.fn.fnamemodify
      local cwd = vim.loop.cwd

      local setup_workspace = function(self)
        self.stlbufname = nvim_buf_get_name(0)
        self.stlbuftype = bo.buftype
        self.stlcwd = cwd()
      end

      local StatusLine = {
        hl = {
          bold = true,
          italic = true,
        },
        static = {
          stlmodemap = {
            ['n'] = {
              text = 'N',
              hl = { fg = C.BASE01.hex, bg = C.BASE06.hex },
            },
            ['no'] = {
              text = 'O-P',
              hl = { fg = C.BASE01.hex, bg = C.BASE06.hex },
            },
            ['nov'] = {
              text = 'O-P',
              hl = { fg = C.BASE01.hex, bg = C.BASE06.hex },
            },
            ['noV'] = {
              text = 'O-P',
              hl = { fg = C.BASE01.hex, bg = C.BASE06.hex },
            },
            ['no'] = {
              text = 'O-P',
              hl = { fg = C.BASE01.hex, bg = C.BASE06.hex },
            },
            ['niI'] = {
              text = 'I-N',
              hl = { fg = C.BASE01.hex, bg = C.BASE06.hex },
            },
            ['niR'] = {
              text = 'R-N',
              hl = { fg = C.BASE01.hex, bg = C.BASE06.hex },
            },
            ['niV'] = {
              text = 'VR-N',
              hl = { fg = C.BASE01.hex, bg = C.BASE06.hex },
            },
            ['nt'] = {
              text = 'T-N',
              hl = { fg = C.BASE01.hex, bg = C.BASE06.hex },
            },
            ['v'] = {
              text = 'V',
              hl = { fg = C.BASE01.hex, bg = C.BASE0A.hex },
            },
            ['vs'] = {
              text = 'V-S',
              hl = { fg = C.BASE01.hex, bg = C.BASE0A.hex },
            },
            ['V'] = {
              text = 'V-L',
              hl = { fg = C.BASE01.hex, bg = C.BASE0A.hex },
            },
            ['Vs'] = {
              text = 'VL-S',
              hl = { fg = C.BASE01.hex, bg = C.BASE0A.hex },
            },
            [''] = {
              text = 'V-B',
              hl = { fg = C.BASE01.hex, bg = C.BASE0A.hex },
            },
            ['s'] = {
              text = 'VB-S',
              hl = { fg = C.BASE01.hex, bg = C.BASE0A.hex },
            },
            ['s'] = {
              text = 'S',
              hl = { fg = C.BASE01.hex, bg = C.BASE07.hex },
            },
            ['S'] = {
              text = 'S-L',
              hl = { fg = C.BASE01.hex, bg = C.BASE07.hex },
            },
            [''] = {
              text = 'S-B',
              hl = { fg = C.BASE01.hex, bg = C.BASE07.hex },
            },
            ['i'] = {
              text = 'I',
              hl = { fg = C.BASE01.hex, bg = C.BASE0B.hex },
            },
            ['ic'] = {
              text = 'I',
              hl = { fg = C.BASE01.hex, bg = C.BASE0B.hex },
            },
            ['ix'] = {
              text = 'I',
              hl = { fg = C.BASE01.hex, bg = C.BASE0B.hex },
            },
            ['R'] = {
              text = 'R',
              hl = { fg = C.BASE01.hex, bg = C.BASE0F.hex },
            },
            ['Rc'] = {
              text = 'R',
              hl = { fg = C.BASE01.hex, bg = C.BASE0F.hex },
            },
            ['Rv'] = {
              text = 'V-R',
              hl = { fg = C.BASE01.hex, bg = C.BASE0F.hex },
            },
            ['Rx'] = {
              text = 'R',
              hl = { fg = C.BASE01.hex, bg = C.BASE0F.hex },
            },
            ['Rvc'] = {
              text = 'V-R',
              hl = { fg = C.BASE01.hex, bg = C.BASE0F.hex },
            },
            ['Rvx'] = {
              text = 'V-R',
              hl = { fg = C.BASE01.hex, bg = C.BASE0F.hex },
            },
            ['c'] = {
              text = 'C',
              hl = { fg = C.BASE01.hex, bg = C.BASE09.hex },
            },
            ['cv'] = {
              text = 'EX',
              hl = { fg = C.BASE01.hex, bg = C.BASE09.hex },
            },
            ['ce'] = {
              text = 'EX',
              hl = { fg = C.BASE01.hex, bg = C.BASE09.hex },
            },
            ['r'] = {
              text = 'H-E',
              hl = { fg = C.BASE01.hex, bg = C.BASE0D.hex },
            },
            ['rm'] = {
              text = 'M',
              hl = { fg = C.BASE01.hex, bg = C.BASE0D.hex },
            },
            ['r?'] = {
              text = 'C',
              hl = { fg = C.BASE01.hex, bg = C.BASE0D.hex },
            },
            ['!'] = {
              text = 'SH',
              hl = { fg = C.BASE01.hex, bg = C.BASE0C.hex },
            },
            ['t'] = {
              text = 'T',
              hl = { fg = C.BASE01.hex, bg = C.BASE0C.hex },
            },
          },
        },
        init = function(self)
          self.stlmode = nvim_get_mode().mode
        end,
      }

      local ViMode = {
        update = {
          'ModeChanged',
          pattern = '*:*',
          callback = vim.schedule_wrap(function()
            vim.cmd.redrawstatus()
          end),
        },

        {
          provider = sep.left_rounded,
          hl = function(self)
            local hl = self.stlmodemap[self.stlmode].hl

            return {
              fg = hl.bg,
              bg = hl.fg,
            }
          end,
        },
        {
          provider = function(self)
            return self.stlmodemap[self.stlmode].text
          end,
          hl = function(self)
            return self.stlmodemap[self.stlmode].hl
          end,
        },
        {
          provider = sep.right_rounded,
          hl = function(self)
            local hl = self.stlmodemap[self.stlmode].hl
            return {
              fg = hl.bg,
              bg = hl.fg,
            }
          end,
        },
      }

      local Align = {
        provider = '%=',
      }

      local Space = setmetatable({
        provider = ' ',
      }, {
        __call = function(self, count)
          return {
            provider = str_rep(self.provider, count),
          }
        end,
      })

      local TabPage = {
        update = { 'TabNew', 'TabEnter', 'TabLeave', 'TabClosed' },
        init = function(self)
          local hl = C.BASE06.hex

          local tabpage = vim
            .iter(vim.api.nvim_list_tabpages())
            :map(function(handle)
              return {
                hl = function()
                  return vim.api.nvim_get_current_tabpage() == handle
                      and {
                        underline = true,
                        sp = hl,
                        fg = hl,
                        bg = C.BASE02.hex,
                      }
                    or {
                      bg = C.BASE01.hex,
                      fg = C.BASE04.hex,
                    }
                end,
                on_click = {
                  callback = function()
                    vim.api.nvim_set_current_tabpage(handle)
                  end,
                  name = 'stltab' .. handle,
                },

                Space,
                {
                  provider = handle,
                },
                Space,
              }
            end)
            :totable()

          self.child = self:new(tabpage, 1)
        end,
        {
          provider = function(self)
            return self.child:eval()
          end,
        },
      }

      local Git = {
        {
          hl = {
            fg = C.BASE01.hex,
          },
          provider = sep.left_rounded,
        },

        {
          hl = {
            bg = C.BASE01.hex,
          },

          {
            condition = function(self)
              self.stlgitstatus = vim.b.gitsigns_status_dict
              return self.stlgitstatus ~= nil
            end,

            {
              condition = function(self)
                return self.stlgitstatus.head ~= ''
              end,

              {
                hl = {
                  fg = C.BASE04.hex,
                },
                provider = function(self)
                  return self.stlgitstatus.head
                end,
              },
              {
                condition = function(self)
                  return self.stlgitstatus.added ~= nil
                    or self.stlgitstatus.changed ~= nil
                    or self.stlgitstatus.removed ~= nil
                end,

                Space,
              },
            },
            {
              condition = function(self)
                return self.stlgitstatus.added ~= nil
              end,

              {
                hl = {
                  fg = C.BASE0B.hex,
                },
                provider = function(self)
                  return settings.ui.git.added .. self.stlgitstatus.added
                end,
              },
              Space,
            },
            {
              condition = function(self)
                return self.stlgitstatus.changed ~= nil
              end,

              {
                hl = {
                  fg = C.BASE0A.hex,
                },
                provider = function(self)
                  return settings.ui.git.changed .. self.stlgitstatus.changed
                end,
              },
              Space,
            },
            {
              condition = function(self)
                return self.stlgitstatus.removed ~= nil
              end,
              hl = {
                fg = C.BASE0F.hex,
              },
              provider = function(self)
                return settings.ui.git.deleted .. self.stlgitstatus.removed
              end,
            },
          },
        },

        {
          hl = {
            fg = C.BASE01.hex,
          },
          provider = sep.right_rounded,
        },
      }

      local Diagnostics = {
        update = { 'DiagnosticChanged', 'BufEnter', 'BufLeave' },
        {
          hl = {
            fg = C.BASE01.hex,
          },
          provider = sep.left_rounded,
        },

        {
          hl = {
            bg = C.BASE01.hex,
          },

          {
            condition = function(self)
              self.stldiagnostics = diagnostic_get(0)
              return #self.stldiagnostics > 0
            end,
            init = function(self)
              local count = { 0, 0, 0, 0 }
              for _, diagnostic in ipairs(self.stldiagnostics) do
                count[diagnostic.severity] = count[diagnostic.severity] + 1
              end

              self.stldiagnosticserror = count[1]
              self.stldiagnosticswarn = count[2]
              self.stldiagnosticsinfo = count[3]
              self.stldiagnosticshint = count[4]
            end,

            {
              condition = function(self)
                return self.stldiagnosticserror > 0
              end,

              {
                hl = {
                  fg = C.BASE0F.hex,
                },
                provider = function(self)
                  return settings.ui.diagnostics.Error .. self.stldiagnosticserror
                end,
              },
              {
                condition = function(self)
                  return self.stldiagnosticswarn > 0
                    or self.stldiagnosticsinfo > 0
                    or self.stldiagnosticshint > 0
                end,

                Space,
              },
            },
            {
              condition = function(self)
                return self.stldiagnosticswarn > 0
              end,

              {
                hl = {
                  fg = C.BASE0A.hex,
                },
                provider = function(self)
                  return settings.ui.diagnostics.Warn .. self.stldiagnosticswarn
                end,
              },
              {
                condition = function(self)
                  return self.stldiagnosticsinfo > 0 or self.stldiagnosticshint > 0
                end,

                Space,
              },
            },
            {
              condition = function(self)
                return self.stldiagnosticsinfo > 0
              end,

              {
                hl = {
                  fg = C.BASE06.hex,
                },
                provider = function(self)
                  return settings.ui.diagnostics.Info .. self.stldiagnosticsinfo
                end,
              },
              {
                condition = function(self)
                  return self.stldiagnosticshint > 0
                end,

                Space,
              },
            },
            {
              condition = function(self)
                return self.stldiagnosticshint > 0
              end,
              hl = {
                fg = C.BASE0B.hex,
              },
              provider = function(self)
                return settings.ui.diagnostics.Hint .. self.stldiagnosticshint
              end,
            },
          },
        },

        {
          hl = {
            fg = C.BASE01.hex,
          },
          provider = sep.right_rounded,
        },
      }

      local Workspace = {
        init = function(self)
          setup_workspace(self)
        end,

        {
          hl = {
            fg = C.BASE01.hex,
          },
          provider = sep.left_rounded,
        },
        {
          -- fallthrough = false,
          hl = {
            fg = C.BASE04.hex,
            bg = C.BASE01.hex,
          },

          {
            update = { 'TermEnter', 'TermLeave' },
            condition = function(self)
              return self.stlbuftype == 'terminal'
            end,

            provider = 'term://',
          },
          {
            hl = {
              fg = C.BASE04.hex,
              bg = C.BASE01.hex,
            },
            provider = function(self)
              return fnamemodify(self.stlcwd, ':~')
            end,
          },
          {
            update = { 'TermEnter', 'TermLeave' },
            condition = function(self)
              return self.stlbuftype == 'terminal'
            end,
            provider = function(self)
              local pattern = '//[%d%p]+' .. vim.o.shell .. '[%p%w]+$'

              return str_match(self.stlbufname, pattern)
            end,
          },
        },
        {
          hl = {
            fg = C.BASE01.hex,
          },
          provider = sep.right_rounded,
        },
      }

      local FileType = {
        update = { 'BufEnter', 'BufLeave' },
        {
          hl = {
            fg = C.BASE01.hex,
          },
          provider = sep.left_rounded,
        },
        {
          hl = {
            fg = C.BASE04.hex,
            bg = C.BASE01.hex,
          },
          provider = function()
            return bo.filetype
          end,
        },
        {
          hl = {
            fg = C.BASE01.hex,
          },
          provider = sep.right_rounded,
        },
      }

      local Location = {
        update = {
          'ModeChanged',
          pattern = '*:*',
          callback = vim.schedule_wrap(function()
            vim.cmd.redrawstatus()
          end),
        },

        {
          provider = sep.left_rounded,
          hl = function(self)
            local hl = self.stlmodemap[self.stlmode].hl

            return {
              fg = hl.bg,
              bg = hl.fg,
            }
          end,
        },
        {
          provider = '%03l:%02v',
          hl = function(self)
            return self.stlmodemap[self.stlmode].hl
          end,
        },
        {
          provider = sep.right_rounded,
          hl = function(self)
            local hl = self.stlmodemap[self.stlmode].hl
            return {
              fg = hl.bg,
              bg = hl.fg,
            }
          end,
        },
      }

      table.insert(StatusLine, {
        Space,
        ViMode,
        Space,
        Workspace,
        Space,
        Git,
        Space,
        Diagnostics,
        Space,
        TabPage,
        Align,
        FileType,
        Space,
        Location,
        Space,
      })

      local WinBar = {
        hl = {
          bold = true,
          italic = true,
        },
      }

      -- local Navic = {
      --   condition = function()
      --     return require('nvim-navic').is_available()
      --   end,
      --   provider = function()
      --     return require('nvim-navic').get_location { highlight = true }
      --   end,
      --   update = 'CursorMoved',
      -- }

      -- Full nerd (with icon colors and clickable elements)!
      -- works in multi window, but does not support flexible components (yet ...)
      -- local Navic = {
      --   condition = function()
      --     return require('nvim-navic').is_available()
      --   end,
      --   static = {
      --     -- create a type highlight map
      --     type_hl = {
      --       File = 'Directory',
      --       Module = '@include',
      --       Namespace = '@namespace',
      --       Package = '@include',
      --       Class = '@structure',
      --       Method = '@method',
      --       Property = '@property',
      --       Field = '@field',
      --       Constructor = '@constructor',
      --       Enum = '@field',
      --       Interface = '@type',
      --       Function = '@function',
      --       Variable = '@variable',
      --       Constant = '@constant',
      --       String = '@string',
      --       Number = '@number',
      --       Boolean = '@boolean',
      --       Array = '@field',
      --       Object = '@type',
      --       Key = '@keyword',
      --       Null = '@comment',
      --       EnumMember = '@field',
      --       Struct = '@structure',
      --       Event = '@keyword',
      --       Operator = '@operator',
      --       TypeParameter = '@type',
      --     },
      --     -- bit operation dark magic, see below...
      --     enc = function(line, col, winnr)
      --       return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
      --     end,
      --     -- line: 16 bit (65535); col: 10 bit (1023); winnr: 6 bit (63)
      --     dec = function(c)
      --       local line = bit.rshift(c, 16)
      --       local col = bit.band(bit.rshift(c, 6), 1023)
      --       local winnr = bit.band(c, 63)
      --       return line, col, winnr
      --     end,
      --   },
      --   init = function(self)
      --     local data = require('nvim-navic').get_data() or {}
      --     local children = {}
      --     -- create a child for each level
      --     for i, d in ipairs(data) do
      --       -- encode line and column numbers into a single integer
      --       local pos = self.enc(d.scope.start.line, d.scope.start.character, self.winnr)
      --       local child = {
      --         {
      --           provider = d.icon,
      --           hl = self.type_hl[d.type],
      --         },
      --         {
      --           -- escape `%`s (elixir) and buggy default separators
      --           provider = d.name:gsub('%%', '%%%%'):gsub('%s*->%s*', ''),
      --           -- highlight icon only or location name as well
      --           -- hl = self.type_hl[d.type],
      --
      --           on_click = {
      --             -- pass the encoded position through minwid
      --             minwid = pos,
      --             callback = function(_, minwid)
      --               -- decode
      --               local line, col, winnr = self.dec(minwid)
      --               vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), { line, col })
      --             end,
      --             name = 'heirline_navic',
      --           },
      --         },
      --       }
      --       -- add a separator only if needed
      --       if #data > 1 and i < #data then
      --         table.insert(child, {
      --           provider = ' > ',
      --           hl = { fg = 'bright_fg' },
      --         })
      --       end
      --       table.insert(children, child)
      --     end
      --     -- instantiate the new child, overwriting the previous one
      --     self.child = self:new(children, 1)
      --   end,
      --   -- evaluate the children containing navic components
      --   provider = function(self)
      --     return self.child:eval()
      --   end,
      --   hl = { fg = 'gray' },
      --   update = 'CursorMoved',
      -- }

      -- The easy way.
      local Navic = {
        condition = function()
          return require('nvim-navic').is_available()
        end,
        provider = function()
          return require('nvim-navic').get_location { highlight = false }
        end,
        update = { 'CursorMoved' },
      }

      local FileName = {
        condition = function(self)
          setup_workspace(self)
          return self.stlbuftype == ''
        end,

        {
          hl = {
            fg = C.BASE01.hex,
          },
          provider = sep.left_rounded,
        },
        {
          hl = {
            bg = C.BASE01.hex,
            fg = C.BASE04.hex,
          },
          {
            update = { 'DirChanged', 'BufEnter', 'BufLeave' },
            provider = function(self)
              if str_find(self.stlbufname, self.stlcwd, 1, true) then
                local offset = #self.stlcwd
                if self.stlcwd == '/' then
                  offset = offset - 1
                end
                return str_sub(self.stlbufname, offset + 2, -1)
              elseif self.stlbufname ~= '' then
                return fnamemodify(self.stlbufname, ':~')
              else
                return ''
              end
            end,
          },

          { provider = '[' },
          {
            fallthrough = false,
            {
              condition = function()
                return bo.modified
              end,
              hl = {
                fg = C.BASE08.hex,
              },
              provider = '+',
            },
            {
              condition = function()
                return bo.readonly
              end,
              hl = {
                fg = C.BASE0F.hex,
              },
              provider = '',
            },
          },
          { provider = ']' },
        },
        {
          hl = {
            fg = C.BASE01.hex,
          },
          provider = sep.right_rounded,
        },
      }

      table.insert(WinBar, {
        Navic,
        -- FileName,
      })

      heirline.setup {
        statusline = StatusLine,
        -- winbar = WinBar,
        opts = {
          disable_winbar_cb = function(ctx)
            local buftypes = { 'prompt', 'nofile', 'help', 'quickfix', 'terminal' }
            local filetypes = { 'gitcommit', 'fugitive', 'lazy', 'toggleterm', 'Trouble', 'noice' }
            local buf = ctx.buf
            local in_buftype = vim.tbl_contains(buftypes, bo[buf].buftype)
            local in_filetype = vim.tbl_contains(filetypes, bo[buf].filetype)
            return in_buftype or in_filetype
          end,
        },
      }
    end,
  },
  {
    'rktjmp/lush.nvim',
    lazy = false,
    init = function(p)
      USER_AUGROUP(function(au)
        au.create('User', {
          pattern = 'Flavours',
          callback = function()
            require('lazy').reload { plugins = { p } }
          end,
          once = true,
        })
      end)
    end,
    config = function()
      vim.cmd.colorscheme('lush')
    end,
  },
  -- {
  --   'echasnovski/mini.colors',
  --   config = function()
  --     require('mini.colors').setup {}
  --   end,
  -- },
  -- {
  --   'echasnovski/mini.hues',
  --   -- lazy = false,
  --   opts = function()
  --     local palette = require('utils.palette')
  --     return {
  --       background = palette.BASE00.da(20).hex,
  --       foreground = palette.BASE05.sa(20).hex,
  --       saturation = 'medium',
  --       n_hues = 8,
  --     }
  --   end,
  -- },
  {
    'SmiteshP/nvim-navic',
    init = function()
      vim.g.navic_silence = true

      -- require('utils.lsp').on_attach(function(client, bufnr)
      --   if client.server_capabilities.documentSymbolProvider then
      --     require('nvim-navic').attach(client, bufnr)
      --   end
      -- end)
    end,
    config = function()
      require('nvim-navic').setup {
        highlight = true,
        icons = {
          File = ' ',
          Module = ' ',
          Namespace = ' ',
          Package = ' ',
          Class = ' ',
          Method = ' ',
          Property = ' ',
          Field = ' ',
          Constructor = ' ',
          Enum = ' ',
          Interface = ' ',
          Function = ' ',
          Variable = ' ',
          Constant = ' ',
          String = ' ',
          Number = ' ',
          Boolean = ' ',
          Array = ' ',
          Object = ' ',
          Key = ' ',
          Null = ' ',
          EnumMember = ' ',
          Struct = ' ',
          Event = ' ',
          Operator = ' ',
          TypeParameter = ' ',
        },
      }
    end,
  },
  {
    'folke/noice.nvim',
    event = 'UIEnter',
    config = function()
      require('noice').setup {
        cmdline = {
          enabled = true,
          view = 'cmdline',
        },
        lsp = {
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true,
          },

          signature = {
            enabled = false,
            throttle = 0,
          },
          hover = {
            enabled = true,
          },
        },

        views = {
          hover = {
            border = {
              style = 'single',
            },
          },
        },

        presets = {
          bottom_search = false, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = false, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      }
    end,
  },
  {
    'MunifTanjim/nougat.nvim',
    -- event = 'UIEnter',
    config = function()
      local core = require('nougat.core')
      local Bar = require('nougat.bar')
      local bar_util = require('nougat.bar.util')
      local Item = require('nougat.item')
      local sep = require('nougat.separator')

      local nut = {
        buf = {
          diagnostic_count = require('nougat.nut.buf.diagnostic_count').create,
          filename = require('nougat.nut.buf.filename').create,
          filetype = require('nougat.nut.buf.filetype').create,
        },
        git = {
          branch = require('nougat.nut.git.branch').create,
          status = require('nougat.nut.git.status'),
        },
        tab = {
          tablist = {
            tabs = require('nougat.nut.tab.tablist').create,
            close = require('nougat.nut.tab.tablist.close').create,
            icon = require('nougat.nut.tab.tablist.icon').create,
            label = require('nougat.nut.tab.tablist.label').create,
            modified = require('nougat.nut.tab.tablist.modified').create,
          },
        },
        mode = require('nougat.nut.mode').create,
        spacer = require('nougat.nut.spacer').create,
        truncation_point = require('nougat.nut.truncation_point').create,
      }

      local color = {
        bg = '#1d2021',
        bg0_h = '#1d2021',
        bg0 = '#282828',
        bg0_s = '#32302f',
        bg1 = '#3c3836',
        bg2 = '#504945',
        bg3 = '#665c54',
        bg4 = '#7c6f64',

        gray = '#928374',

        fg = '#ebdbb2',
        fg0 = '#fbf1c7',
        fg1 = '#ebdbb2',
        fg2 = '#d5c4a1',
        fg3 = '#bdae93',
        fg4 = '#a89984',

        lightgray = '#a89984',

        red = '#fb4934',
        green = '#b8bb26',
        yellow = '#fabd2f',
        blue = '#83a598',
        purple = '#d3869b',
        aqua = '#8ec07c',
        orange = '#f38019',

        accent = {
          red = '#cc241d',
          green = '#98971a',
          yellow = '#d79921',
          blue = '#458588',
          purple = '#b16286',
          aqua = '#689d6a',
          orange = '#d65d0e',
        },
      }

      local mode = nut.mode {
        sep_left = sep.left_half_circle_solid(true),
        sep_right = sep.right_half_circle_solid(true),
        config = {
          highlight = {
            normal = {
              bg = 'fg',
              fg = color.bg,
            },
            visual = {
              bg = color.orange,
              fg = color.bg,
            },
            insert = {
              bg = color.blue,
              fg = color.bg,
            },
            replace = {
              bg = color.purple,
              fg = color.bg,
            },
            commandline = {
              bg = color.green,
              fg = color.bg,
            },
            terminal = {
              bg = color.accent.green,
              fg = color.bg,
            },
            inactive = {},
          },
        },
      }

      local filename = (function()
        local item = Item {
          prepare = function(_, ctx)
            local bufnr, data = ctx.bufnr, ctx.ctx
            data.readonly = vim.api.nvim_buf_get_option(bufnr, 'readonly')
            data.modifiable = vim.api.nvim_buf_get_option(bufnr, 'modifiable')
            data.modified = vim.api.nvim_buf_get_option(bufnr, 'modified')
          end,
          sep_left = sep.left_half_circle_solid(true),
          content = {
            Item {
              hl = { bg = color.bg4, fg = color.fg },
              hidden = function(_, ctx)
                return not ctx.ctx.readonly
              end,
              suffix = ' ',
              content = 'RO',
            },
            Item {
              hl = { bg = color.bg4, fg = color.fg },
              hidden = function(_, ctx)
                return ctx.ctx.modifiable
              end,
              content = '',
              suffix = ' ',
            },
            nut.buf.filename {
              hl = { bg = color.fg, fg = color.bg },
              prefix = function(_, ctx)
                local data = ctx.ctx
                if data.readonly or not data.modifiable then
                  return ' '
                end
                return ''
              end,
              suffix = function(_, ctx)
                local data = ctx.ctx
                if data.modified then
                  return ' '
                end
                return ''
              end,
            },
            Item {
              hl = { bg = color.bg4, fg = color.fg },
              hidden = function(_, ctx)
                return not ctx.ctx.modified
              end,
              prefix = ' ',
              content = '+',
            },
          },
          sep_right = sep.right_half_circle_solid(true),
        }

        return item
      end)()

      local ruler = (function()
        local scroll_hl = {
          [true] = { bg = color.bg3 },
          [false] = { bg = color.bg4 },
        }

        local item = Item {
          content = {
            Item {
              hl = { bg = color.bg4 },
              sep_left = sep.left_half_circle_solid(true),
              content = core.group({
                core.code('l'),
                ':',
                core.code('c'),
              }, { align = 'left', min_width = 8 }),
              suffix = ' ',
            },
            Item {
              hl = function(_, ctx)
                return scroll_hl[ctx.is_focused]
              end,
              prefix = ' ',
              content = core.code('P'),
              sep_right = sep.right_half_circle_solid(true),
            },
          },
        }

        return item
      end)()

      -- renders space only when item is rendered
      ---@param item NougatItem
      local function paired_space(item)
        return Item {
          content = sep.space().content,
          hidden = item,
        }
      end

      local stl = Bar('statusline')
      stl:add_item(mode)
      stl:add_item(sep.space())
      stl:add_item(nut.git.branch {
        hl = { bg = color.purple, fg = color.bg },
        sep_left = sep.left_half_circle_solid(true),
        prefix = ' ',
        sep_right = sep.right_half_circle_solid(true),
      })
      stl:add_item(sep.space())
      local gitstatus = stl:add_item(nut.git.status.create {
        hl = { fg = color.bg },
        sep_left = sep.left_half_circle_solid(true),
        content = {
          nut.git.status.count('added', {
            hl = { bg = color.green },
            prefix = '+',
            suffix = function(_, ctx)
              return (ctx.gitstatus.changed > 0 or ctx.gitstatus.removed > 0) and ' ' or ''
            end,
          }),
          nut.git.status.count('changed', {
            hl = { bg = color.blue },
            prefix = function(_, ctx)
              return ctx.gitstatus.added > 0 and ' ~' or '~'
            end,
            suffix = function(_, ctx)
              return ctx.gitstatus.removed > 0 and ' ' or ''
            end,
          }),
          nut.git.status.count('removed', {
            hl = { bg = color.red },
            prefix = function(_, ctx)
              return (ctx.gitstatus.added > 0 or ctx.gitstatus.changed > 0) and ' -' or '-'
            end,
          }),
        },
        sep_right = sep.right_half_circle_solid(true),
      })
      stl:add_item(paired_space(gitstatus))
      stl:add_item(filename)
      stl:add_item(sep.space())
      stl:add_item(nut.spacer())
      stl:add_item(nut.truncation_point())
      stl:add_item(nut.buf.filetype {
        hl = { bg = color.blue, fg = color.bg },
        sep_left = sep.left_half_circle_solid(true),
        sep_right = sep.right_half_circle_solid(true),
      })
      stl:add_item(sep.space())
      local diagnostic_count = stl:add_item(nut.buf.diagnostic_count {
        hl = { bg = color.bg4 },
        sep_left = sep.left_half_circle_solid(true),
        sep_right = sep.right_half_circle_solid(true),
        config = {
          error = { prefix = ' ', fg = color.red },
          warn = { prefix = ' ', fg = color.yellow },
          info = { prefix = ' ', fg = color.blue },
          hint = { prefix = ' ', fg = color.green },
        },
      })
      stl:add_item(paired_space(diagnostic_count))
      stl:add_item(ruler)
      stl:add_item(sep.space())

      local stl_inactive = Bar('statusline')
      stl_inactive:add_item(mode)
      stl_inactive:add_item(sep.space())
      stl_inactive:add_item(filename)
      stl_inactive:add_item(sep.space())
      stl_inactive:add_item(nut.spacer())
      stl_inactive:add_item(ruler)
      stl_inactive:add_item(sep.space())

      bar_util.set_statusline(function(ctx)
        return ctx.is_focused and stl or stl_inactive
      end)

      local tal = Bar('tabline')

      tal:add_item(nut.tab.tablist.tabs {
        active_tab = {
          hl = { bg = color.bg0_h, fg = color.blue },
          prefix = ' ',
          suffix = ' ',
          content = {
            nut.tab.tablist.icon { suffix = ' ' },
            nut.tab.tablist.label {},
            nut.tab.tablist.modified { prefix = ' ', config = { text = '●' } },
            nut.tab.tablist.close { prefix = ' ', config = { text = '󰅖' } },
          },
          sep_left = sep.left_half_circle_solid { bg = 'bg', fg = color.bg0_h },
          sep_right = sep.right_half_circle_solid { bg = 'bg', fg = color.bg0_h },
        },
        inactive_tab = {
          hl = { bg = color.bg2, fg = color.fg2 },
          prefix = ' ',
          suffix = ' ',
          content = {
            nut.tab.tablist.icon { suffix = ' ' },
            nut.tab.tablist.label {},
            nut.tab.tablist.modified { prefix = ' ', config = { text = '●' } },
            nut.tab.tablist.close { prefix = ' ', config = { text = '󰅖' } },
          },
          sep_left = sep.left_half_circle_solid { bg = 'bg', fg = color.bg2 },
          sep_right = sep.right_half_circle_solid { bg = 'bg', fg = color.bg2 },
        },
      })

      bar_util.set_tabline(tal)
    end,
  },
}
