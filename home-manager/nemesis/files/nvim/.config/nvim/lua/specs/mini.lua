local augroup = require('utils.augroup')

return {
  {
    'echasnovski/mini.indentscope',
    event = { 'BufReadPost' },
    init = function(_)
      augroup('indentscope_ft_disable', {})(function(au)
        au.create({ 'FileType' }, {
          pattern = { 'fzf', 'neo-tree', 'help', 'noice', 'toggleterm', 'Trouble', 'lazy' },
          callback = function(ctx)
            vim.b[ctx.buf].miniindentscope_disable = true
          end,
        })
      end)
    end,
    opts = {
      symbol = '│',
    },
  },
  {
    'echasnovski/mini.files',
    -- lazy = false,
    config = function()
      require('mini.files').setup {}
    end,
  },
  {
    'echasnovski/mini.pick',
    dependencies = {
      { 'mini.extra' },
    },
    keys = {
      {
        '<leader>pf',
        mode = { 'n' },
        function()
          require('mini.pick').builtin.files({ tool = 'rg' }, {})
        end,
      },
    },
    config = function()
      require('mini.pick').setup {
        options = {
          use_cache = true,
        },
        mappings = {
          move_down = '<C-j>',
          move_up = '<C-k>',
        },
        window = {
          config = function()
            local height = math.floor(0.618 * vim.o.lines)
            local width = math.floor(0.618 * vim.o.columns)

            return {
              anchor = 'NW',
              height = height,
              width = width,
              row = math.floor(0.5 * (vim.o.lines - height)),
              col = math.floor(0.5 * (vim.o.columns - width)),
            }
          end,
        },
      }
    end,
  },
  {
    'echasnovski/mini.extra',
    opts = {},
  },
  {
    'echasnovski/mini.ai',
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter-textobjects',
        init = function(p)
          require('lazy.core.loader').disable_rtp_plugin(p.name)
        end,

        config = function()
          -- require('nvim-treesitter.configs').setup {
          --   textobjects = {
          --     select = {
          --       enable = true,
          --
          --       -- Automatically jump forward to textobj, similar to targets.vim
          --       lookahead = true,
          --
          --       keymaps = {
          --         -- You can use the capture groups defined in textobjects.scm
          --         ['am'] = '@function.outer',
          --         ['im'] = '@function.inner',
          --         ['al'] = '@class.outer',
          --         -- You can optionally set descriptions to the mappings (used in the desc parameter of
          --         -- nvim_buf_set_keymap) which plugins like which-key display
          --         ['il'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
          --         ['ab'] = '@block.outer',
          --         ['ib'] = '@block.inner',
          --         ['ad'] = '@conditional.outer',
          --         ['id'] = '@conditional.inner',
          --         ['ao'] = '@loop.outer',
          --         ['io'] = '@loop.inner',
          --         ['aa'] = '@parameter.outer',
          --         ['ia'] = '@parameter.inner',
          --         ['af'] = '@call.outer',
          --         ['if'] = '@call.inner',
          --         ['ac'] = '@comment.outer',
          --         ['ar'] = '@frame.outer',
          --         ['ir'] = '@frame.inner',
          --         ['at'] = '@attribute.outer',
          --         ['it'] = '@attribute.inner',
          --         ['ae'] = '@scopename.inner',
          --         ['ie'] = '@scopename.inner',
          --         ['as'] = '@statement.outer',
          --         ['is'] = '@statement.outer',
          --       },
          --       -- You can choose the select mode (default is charwise 'v')
          --       --
          --       -- Can also be a function which gets passed a table with the keys
          --       -- * query_string: eg '@function.inner'
          --       -- * method: eg 'v' or 'o'
          --       -- and should return the mode ('v', 'V', or '<c-v>') or a table
          --       -- mapping query_strings to modes.
          --       -- selection_modes = treesitter_selection_mode,
          --       -- if you set this to `true` (default is `false`) then any textobject is
          --       -- extended to include preceding or succeeding whitespace. succeeding
          --       -- whitespace has priority in order to act similarly to eg the built-in
          --       -- `ap`.
          --       --
          --       -- can also be a function which gets passed a table with the keys
          --       -- * query_string: eg '@function.inner'
          --       -- * selection_mode: eg 'v'
          --       -- and should return true of false
          --       include_surrounding_whitespace = false,
          --     },
          --     swap = {
          --       enable = true,
          --       swap_next = {
          --         ['m'] = '@function.outer',
          --         [')c'] = '@comment.outer',
          --         [')a'] = '@parameter.inner',
          --         [')b'] = '@block.outer',
          --         [')C'] = '@class.outer',
          --       },
          --       swap_previous = {
          --         ['(m'] = '@function.outer',
          --         ['(c'] = '@comment.outer',
          --         ['(a'] = '@parameter.inner',
          --         ['(b'] = '@block.outer',
          --         ['(C'] = '@class.outer',
          --       },
          --     },
          --     move = {
          --       enable = true,
          --       set_jumps = true, -- whether to set jumps in the jumplist
          --       goto_next_start = {
          --         [']m'] = '@function.outer',
          --         [']f'] = '@call.outer',
          --         [']d'] = '@conditional.outer',
          --         [']o'] = '@loop.outer',
          --         [']s'] = '@statement.outer',
          --         [']a'] = '@parameter.outer',
          --         [']c'] = '@comment.outer',
          --         [']b'] = '@block.outer',
          --         [']l'] = { query = '@class.outer', desc = 'next class start' },
          --         [']r'] = '@frame.outer',
          --         [']t'] = '@attribute.outer',
          --         [']e'] = '@scopename.outer',
          --         [']]m'] = '@function.inner',
          --         [']]f'] = '@call.inner',
          --         [']]d'] = '@conditional.inner',
          --         [']]o'] = '@loop.inner',
          --         [']]a'] = '@parameter.inner',
          --         [']]b'] = '@block.inner',
          --         [']]l'] = { query = '@class.inner', desc = 'next class start' },
          --         [']]r'] = '@frame.inner',
          --         [']]t'] = '@attribute.inner',
          --         [']]e'] = '@scopename.inner',
          --       },
          --       goto_next_end = {
          --         [']M'] = '@function.outer',
          --         [']F'] = '@call.outer',
          --         [']D'] = '@conditional.outer',
          --         [']O'] = '@loop.outer',
          --         [']S'] = '@statement.outer',
          --         [']A'] = '@parameter.outer',
          --         [']C'] = '@comment.outer',
          --         [']B'] = '@block.outer',
          --         [']L'] = '@class.outer',
          --         [']R'] = '@frame.outer',
          --         [']T'] = '@attribute.outer',
          --         [']E'] = '@scopename.outer',
          --         [']]M'] = '@function.inner',
          --         [']]F'] = '@call.inner',
          --         [']]D'] = '@conditional.inner',
          --         [']]O'] = '@loop.inner',
          --         [']]A'] = '@parameter.inner',
          --         [']]B'] = '@block.inner',
          --         [']]L'] = '@class.inner',
          --         [']]R'] = '@frame.inner',
          --         [']]T'] = '@attribute.inner',
          --         [']]E'] = '@scopename.inner',
          --       },
          --       goto_previous_start = {
          --         ['[m'] = '@function.outer',
          --         ['[f'] = '@call.outer',
          --         ['[d'] = '@conditional.outer',
          --         ['[o'] = '@loop.outer',
          --         ['[s'] = '@statement.outer',
          --         ['[a'] = '@parameter.outer',
          --         ['[c'] = '@comment.outer',
          --         ['[b'] = '@block.outer',
          --         ['[l'] = '@class.outer',
          --         ['[r'] = '@frame.outer',
          --         ['[t'] = '@attribute.outer',
          --         ['[e'] = '@scopename.outer',
          --         ['[[m'] = '@function.inner',
          --         ['[[f'] = '@call.inner',
          --         ['[[d'] = '@conditional.inner',
          --         ['[[o'] = '@loop.inner',
          --         ['[[a'] = '@parameter.inner',
          --         ['[[b'] = '@block.inner',
          --         ['[[l'] = '@class.inner',
          --         ['[[r'] = '@frame.inner',
          --         ['[[t'] = '@attribute.inner',
          --         ['[[e'] = '@scopename.inner',
          --       },
          --       goto_previous_end = {
          --         ['[M'] = '@function.outer',
          --         ['[F'] = '@call.outer',
          --         ['[D'] = '@conditional.outer',
          --         ['[O'] = '@loop.outer',
          --         ['[S'] = '@statement.outer',
          --         ['[A'] = '@parameter.outer',
          --         ['[C'] = '@comment.outer',
          --         ['[B'] = '@block.outer',
          --         ['[L'] = '@class.outer',
          --         ['[R'] = '@frame.outer',
          --         ['[T'] = '@attribute.outer',
          --         ['[E'] = '@scopename.outer',
          --         ['[[M'] = '@function.inner',
          --         ['[[F'] = '@call.inner',
          --         ['[[D'] = '@conditional.inner',
          --         ['[[O'] = '@loop.inner',
          --         ['[[A'] = '@parameter.inner',
          --         ['[[B'] = '@block.inner',
          --         ['[[L'] = '@class.inner',
          --         ['[[R'] = '@frame.inner',
          --         ['[[T'] = '@attribute.inner',
          --         ['[[E'] = '@scopename.inner',
          --       },
          --     },
          --   },
          -- }
        end,
      },
    },
    keys = {
      { 'a', mode = { 'x', 'o' } },
      { 'i', mode = { 'x', 'o' } },
      { 'g[', mode = { 'n' } },
      { 'g]', mode = { 'n' } },
    },
    event = {},
    opts = function()
      local ai = require('mini.ai')
      local gen_spec_ts = ai.gen_spec.treesitter

      return {
        custom_textobjects = {
          f = gen_spec_ts({ a = '@function.outer', i = '@function.inner' }, {}),
          F = gen_spec_ts({ a = '@call.outer', i = '@call.inner' }, {}),
          c = gen_spec_ts({ a = '@class.outer', i = '@class.inner' }, {}),
          o = gen_spec_ts({
            a = { '@block.outer', '@conditional.outer', '@loop.outer' },
            i = { '@block.inner', '@conditional.inner', '@loop.inner' },
          }, {}),
          t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' },
        },
        search_method = 'cover_or_nearest',
        n_lines = 9999,
      }
    end,
  },
  {
    'echasnovski/mini.comment',
    dependencies = {
      {
        'JoosepAlviste/nvim-ts-context-commentstring',
        init = function(p)
          require('lazy.core.loader').disable_rtp_plugin(p.name)
        end,
        opts = {
          enable_autocmd = false,
        },
      },
    },
    keys = {
      { 'gc', mode = { 'n', 'x', 'o' } },
    },
    init = function()
      augroup('commentstring', {})(function(au)
        au.create({ 'FileType' }, {
          pattern = { 'nix' },
          callback = function(ctx)
            vim.bo[ctx.buf].commentstring = '# %s'
          end,
        })

        au.create({ 'FileType' }, {
          pattern = { 'c', 'cpp', 'kotlin' },
          callback = function(ctx)
            vim.bo[ctx.buf].commentstring = '// %s'
          end,
        })
      end)
    end,
    opts = {
      options = {
        custom_commentstring = function()
          return require('ts_context_commentstring.internal').calculate_commentstring()
            or vim.bo.commentstring
        end,
      },
    },
  },
  {
    'echasnovski/mini.move',
    keys = {
      { '<C-M-h>', mode = { 'n', 'x' } },
      { '<C-M-j>', mode = { 'n', 'x' } },
      { '<C-M-k>', mode = { 'n', 'x' } },
      { '<C-M-l>', mode = { 'n', 'x' } },
    },
    opts = {
      mappings = {
        left = '<C-M-h>',
        down = '<C-M-j>',
        up = '<C-M-k>',
        right = '<C-M-l>',

        line_left = '<C-M-h>',
        line_down = '<C-M-j>',
        line_up = '<C-M-k>',
        line_right = '<C-M-l>',
      },
      options = {
        -- Automatically reindent selection during linewise vertical move
        reindent_linewise = true,
      },
    },
  },
  {
    'echasnovski/mini.surround',
    keys = {
      -- { 'gz', mode = { 'n', 'x' } },
      { 's', mode = { 'n', 'x' } },
    },
    init = function()
      augroup('minisurround_ft_config', {})(function(au)
        au.create({ 'FileType' }, {
          pattern = { 'lua' },
          callback = function(ctx)
            vim.b[ctx.buf].minisurround_config = {
              custom_surroundings = {
                S = {
                  input = { '%[%[().-()%]%]' },
                  output = { left = '[[', right = ']]' },
                },
              },
            }
          end,
        })
      end)
    end,
    opts = {
      -- mappings = {
      --   add = 'gza',
      --   delete = 'gzd',
      --   find = 'gzf',
      --   find_left = 'gz',
      --   highlight = 'gzh',
      --   replace = 'gzr',
      --   update_n_lines = 'gzn',
      -- },
      search_method = 'cover_or_nearest',
      n_lines = 9999,
    },
  },
  {
    'echasnovski/mini.splitjoin',
    dependencies = {
      {
        'Wansmer/treesj',
        opts = {},
      },
    },
    keys = {
      {
        'J',
        function()
          local tsj_langs = require('treesj.langs').presets
          if tsj_langs[vim.bo.filetype] then
            require('treesj').toggle()
          else
            require('mini.splitjoin').toggle {}
          end
        end,
        mode = { 'n' },
      },
    },
    opts = {
      max_join_length = 999999,
    },
  },
}
