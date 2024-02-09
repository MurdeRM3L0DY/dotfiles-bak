return {
  {
    'mason.nvim',
    opts = function(_, opts)
      table.insert(opts.ensure_installed, 'solidity-ls')
      table.insert(opts.ensure_installed, 'solidity')
      table.insert(opts.ensure_installed, 'solang')
    end,
  },
  {
    'nvim-lspconfig',
    ft = { 'solidity' },
    opts = {
      servers = {
        -- ['solc'] = {}
        ['solidity'] = {}
        -- ['solang'] = {}
      }
    }
  }
}
