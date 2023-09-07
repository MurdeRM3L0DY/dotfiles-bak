return {
  {
    'stevearc/conform.nvim',
    keys = function()
      local function format(opts, cb)
        require('conform').format(opts, cb)
      end

      -- override default lsp format keymap
      require('config.lsp.keys').update {
        {
          '<leader>F',
          mode = { 'n' },
          function()
            format({ lsp_fallback = true }, nil)
          end,
        },
      }

      return {
        {
          '<leader>F',
          mode = { 'n' },
          function()
            format({}, nil)
          end,
        },
      }
    end,

    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    opts = {
      format = {
        timeout_ms = 3000,
        async = false, -- not recommended to change
        quiet = false, -- not recommended to change
      },
      formatters_by_ft = {},
      formatters = {},
    },
  },
}
