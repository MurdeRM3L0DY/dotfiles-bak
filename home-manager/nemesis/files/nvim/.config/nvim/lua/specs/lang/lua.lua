return {
  {
    'folke/neodev.nvim',
    config = function()
      require('neodev').setup {
        library = {
          vimruntime = true,
          types = true,
          plugins = true,
        },
        lspconfig = false,
      }
    end,
  },
  {
    'nvim-lspconfig',
    ft = { 'lua' },
    opts = {
      servers = {
        ['lua_ls'] = {
          before_init = function(...)
            require('neodev.lsp').before_init(...)
          end,
          settings = {
            Lua = {
              telemetry = {
                enable = false,
              },
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = 'Replace',
                showWord = 'Disable',
              },
              hint = {
                enable = true,
              },
            },
          },
        },
      },
    },
  },
  {
    'conform.nvim',
    opts = function(_, opts)
      opts.formatters_by_ft = {
        lua = { 'stylua' },
      }
    end,
  },
}
