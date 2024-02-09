return {
  {
    'nvim-lspconfig',
    ft = { 'rust' },
    opts = {
      servers = {
        rust_analyzer = {
          settings = {},
        },
      },
    },
  },
  -- {
  --   'mrcjkb/rustaceanvim',
  --   version = '^3',
  --   ft = { 'rust' },
  -- },
  {
    'saecki/crates.nvim',
    event = { 'BufReadPost Cargo.toml' },
    dependencies = {
      {
        'nvim-cmp',
        opts = function(_, opts)
          local cmp = require('cmp')

          vim.list_extend(
            opts.sources,
            cmp.config.sources {
              { name = 'crates' },
            }
          )
        end,
      },
    },
    opts = {
      src = {
        cmp = {
          enabled = true,
        },
      },
    },
  },
  {
    'vxpm/ferris.nvim',
    ft = { 'rust' },
    keys = {
      {
        '<leader>me',
        mode = { 'n' },
        function()
          require('ferris.methods.expand_macro')()
        end,
      },
    },
  },
}
