-- enable lua module byte-compilation
if vim.loader then
  vim.loader.enable()
end

require('config.globals')

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim
    .system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim',
      lazypath,
    })
    :wait()
end
vim.opt.runtimepath:prepend(lazypath)

if not vim.g.vscode then
  require('config.options')
  require('config.keymaps')

  require('lazy').setup {
    spec = {
      { import = 'specs' },

      { import = 'specs.lang.lua' },
      { import = 'specs.lang.rust' },
      { import = 'specs.lang.c' },
      { import = 'specs.lang.python' },
      { import = 'specs.lang.typescript' },
      { import = 'specs.lang.solidity' },
      { import = 'specs.lang.markdown' },
      { import = 'specs.lang.nix' },
    },
    -- debug = true,
    defaults = {
      lazy = true,
    },
    ui = {
      border = 'single',
      pills = false,
    },
    dev = {
      path = '~/projects/',
    },
    install = {
      -- colorscheme = { 'lush', 'catppuccin' },
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
  }

  require('config.autocmds')
  require('config.commands')
  require('config.lsp')
  require('config.diagnostic')
else
  -- require('config.vscode')
end
