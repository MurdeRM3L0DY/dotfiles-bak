local function extend(s, o)
  return vim.tbl_deep_extend('force', s, o)
end

local function noop() end

require('lazy').setup({
  extend(require('plugins.treesitter'), { config = noop }),
  require('plugins.ai'),
  require('plugins.surround'),
  require('plugins.comment'),
  require('plugins.splitjoin'),
  require('plugins.move'),
  require('plugins.treesurfer'),
  require('plugins.leap'),
  require('plugins.flash'),
  require('plugins.matchup')
}, {
  defaults = {
    lazy = true,
  },
  checker = {
    enabled = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'rplugin',
        'shada',
        'spellfile',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})
