return {
  { 'mortepau/codicons.nvim' },
  { 'nvim-tree/nvim-web-devicons' },
  { 'MunifTanjim/nui.nvim' },
  { 'ghostbuster91/nvim-next' },
  { 'nvim-lua/plenary.nvim' },
  { 'b0o/SchemaStore.nvim' },
  { 'svermeulen/nvim-lusc' },
  { '3rd/image.nvim' },
  {
    'williamboman/mason.nvim',
    enabled = function()
      local os_version = vim.loop.os_uname().version
      return not string.find(os_version, 'NixOS', 1, true)
    end,
    build = ':MasonUpdate',
    cmd = {
      'Mason',
      'MasonInstall',
      'MasonUninstall',
      'MasonUninstallAll',
      'MasonUpdate',
      'MasonLog',
    },
    opts = {
      ensure_installed = {},
    },
    config = function(_, opts)
      require('mason').setup {}

      local mr = require('mason-registry')
      mr:on('package:install:success', function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require('lazy.core.handler.event').trigger {
            event = 'FileType',
            buf = vim.api.nvim_get_current_buf(),
          }
        end, 100)
      end)

      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end

      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
}
