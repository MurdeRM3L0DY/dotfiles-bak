return {
  {
    'nvim-lspconfig',
    ft = { 'zig', 'zir' },
    dependencies = {
      {
        'mason.nvim',
        opts = function(_, opts)
          table.insert(opts.ensure_installed, 'zls')
        end,
      },
    },
    opts = {
      servers = {
        zls = {},
      },
    },
  },
}
