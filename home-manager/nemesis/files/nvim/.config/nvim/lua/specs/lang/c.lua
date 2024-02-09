return {
  {
    'nvim-lspconfig',
    ft = { 'c', 'cpp' },
    opts = {
      servers = {
        clangd = {
          cmd = {
            'clangd',
            '--suggest-missing-includes',
            '--header-insertion=iwyu',
          },
          capabilities = {
            offsetEncoding = { 'utf-16' },
          },
        },
        swift_mesonls = {},
      },
    },
  },
  {
    'nvim-lspconfig',
    ft = { 'meson' },
    dependencies = {
      {
        'mason.nvim',
        opts = function(_, opts)
          table.insert(opts, 'swift-mesonlsp')
        end,
      },
    },
    opts = {
      servers = {
        swift_mesonls = {},
      },
    },
  },
  {
    'conform.nvim',
    opts = {
      formatters_by_ft = {
        c = { 'clang_format' },
        cpp = { 'clang_format' },
      },
    },
  },
}
