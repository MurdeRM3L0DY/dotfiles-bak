return {
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
    },
    opts = function()
      local cmp = require('cmp')

      local codicons = require('codicons')
      local symbols = require('codicons.extensions.completion_item_kind').symbols
      local codicon_from_kind = vim.iter(symbols):fold({}, function(t, k, v)
        t[k] = codicons.get(v.icon, 'icon')
        return t
      end)

      local compare = cmp.config.compare

      return {
        performance = {
          debounce = 10,
          throttle = 10,
        },

        experimental = {
          ghost_text = {},
        },

        snippet = {
          expand = nil,
        },

        sorting = {
          priority_weight = 1,
          comparators = {
            compare.score,
            compare.recently_used,
            compare.locality,
            -- compare.offset,
            -- compare.exact,
            -- compare.scopes,
            -- compare.kind,
            -- compare.sort_text,
            compare.length,
            -- compare.order,
          },
        },

        window = {
          completion = {
            border = 'single',
            winhighlight = 'Normal:FloatNormal,FloatBorder:FloatBorder,CursorLine:CursorLine',
            scrollbar = false,
          },

          documentation = {
            border = 'single',
            winhighlight = 'Normal:FloatNormal,FloatBorder:FloatBorder,CursorLine:CursorLine',
          },
        },

        preselect = cmp.PreselectMode.Item,

        mapping = {
          ['<C-e>'] = cmp.mapping(cmp.config.disable, { 'i', 'c' }),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-y>'] = cmp.mapping(cmp.mapping.confirm { select = true }, { 'i', 'c' }),
          ['<C-p>'] = cmp.mapping(
            cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
            { 'i', 'c' }
          ),
          ['<C-n>'] = cmp.mapping(
            cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
            { 'i', 'c' }
          ),
          ['<C-Space>'] = cmp.mapping(function(fallback)
            local complete = not cmp.visible() and cmp.mapping.complete {} or cmp.mapping.close()

            complete(fallback)
          end, { 'i', 'c' }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            local complete_or_next = not cmp.visible() and cmp.mapping.complete {}
              or cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert }

            complete_or_next(fallback)
          end, { 'c' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            local complete_or_prev = not cmp.visible() and cmp.mapping.complete {}
              or cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert }

            complete_or_prev(fallback)
          end, { 'c' }),
        },

        sources = cmp.config.sources({
          -- { name = 'nvim_lsp_signature_help' },
          { name = 'nvim_lsp' },
          { name = 'path' },
        }, {
          { name = 'buffer' },
        }),

        formatting = {
          format = function(_, vim_item)
            vim_item.kind = codicon_from_kind[vim_item.kind]
            return vim_item
          end,
        },
      }
    end,
    config = function(_, opts)
      local cmp = require('cmp')

      cmp.setup(opts)

      ---@diagnostic disable-next-line: missing-fields
      cmp.setup.cmdline(':', {
        sources = cmp.config.sources {
          { name = 'cmdline' },
        },
      })
    end,
  },

  -- nvim-cmp LuaSnip integration
  {
    'nvim-cmp',
    dependencies = {
      { 'LuaSnip' },
      { 'saadparwaiz1/cmp_luasnip' },
    },
    opts = function(_, opts)
      local cmp = require('cmp')
      vim.list_extend(opts.sources, cmp.config.sources { name = 'luasnip' })

      function opts.snippet.expand(args)
        require('luasnip').lsp_expand(args.body)
      end
    end,
  },
  {
    'ziontee113/syntax-tree-surfer',
    keys = {
      {
        'J',
        function()
          require('syntax-tree-surfer').surf('next', 'visual')
        end,
        mode = { 'x' },
      },
      {
        'K',
        function()
          require('syntax-tree-surfer').surf('prev', 'visual')
        end,
        mode = { 'x' },
      },
      {
        'H',
        function()
          require('syntax-tree-surfer').surf('parent', 'visual')
        end,
        mode = { 'x' },
      },
      {
        'L',
        function()
          require('syntax-tree-surfer').surf('child', 'visual')
        end,
        mode = { 'x' },
      },
      {
        '<M-j>',
        function()
          require('syntax-tree-surfer').surf('next', 'visual', true)
        end,
        mode = { 'x' },
      },
      {
        '<M-k>',
        function()
          require('syntax-tree-surfer').surf('prev', 'visual', true)
        end,
        mode = { 'x' },
      },
    },
  },
  {
    'altermo/ultimate-autopair.nvim',
    branch = 'development',
    event = { 'InsertEnter', 'CmdlineEnter' },
    opts = {},
  },
  {
    'mg979/vim-visual-multi',
    keys = {
      { '<C-n>', mode = { 'n' } },
    },
  },
  {
    'jbyuki/venn.nvim',
    cmd = {
      'VBox',
      'VFill',
      'VBoxH',
      'VBoxD',
      'VBoxO',
      'VBoxDO',
      'VBoxHO',
    },
  },
}
