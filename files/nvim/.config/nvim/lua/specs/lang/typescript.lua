return {
  {
    'pmizio/typescript-tools.nvim',
    ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
    config = function()
      require('typescript-tools').setup {
        settings = {
          tsserver_logs = 'verbose',
          -- spawn additional tsserver instance to calculate diagnostics on it
          separate_diagnostic_server = true,
          -- "change"|"insert_leave" determine when the client asks the server about diagnostic
          publish_diagnostic_on = 'insert_leave',
          -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
          -- (see 💅 `styled-components` support section)
          tsserver_plugins = {},
          -- described below
          tsserver_file_preferences = {
            includeInlayParameterNameHints = 'all',
            includeCompletionsForModuleExports = true,
            quotePreference = 'auto',
          },
        },
      }
    end,
  },
  {
    'conform.nvim',
    opts = {
      formatters_by_ft = {
        typescript = { { 'prettierd', 'prettier' } },
        typescriptreact = { { 'prettierd', 'prettier' } },
        javascript = { { 'prettierd', 'prettier' } },
        javascriptreact = { { 'prettierd', 'prettier' } },
      },
    },
  },
  {
    'nvim-lspconfig',
    ft = {
      'typescript',
      'typescriptreact',
      'javascript',
      'javascriptreact',
      'html',
      'css',
    },
    opts = {
      servers = {
        html = {},
        cssls = {},
        eslint = {},
        tailwindcss = {},
      },
    },
  },
}
