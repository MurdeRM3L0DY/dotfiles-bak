return {
  {
    'kndndrj/nvim-dbee',
    keys = {
      {
        '<leader>db',
        function()
          require('dbee').open()
        end,
        mode = { 'n' },
      },
    },
    config = function()
      require('dbee').setup {
        sources = {
          require('dbee.sources').EnvSource:new('DBEE_CONNECTIONS'),
        },
      }
    end,
  },
  {
    'andymass/vim-matchup',
    event = { 'BufReadPost' },
    dependencies = {
      { 'nvim-treesitter' },
    },
    init = function()
      vim.g.matchup_matchparen_offscreen = {}
    end,
    config = function()
      require('nvim-treesitter.configs').setup {
        matchup = {
          enable = true,
          include_match_words = true,
          disable_virtual_text = true,
        },
      }
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost' },
    build = function()
      pcall(require('nvim-treesitter.install').update { with_sync = false })
    end,
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'vim',
          'c',
          'regex',
          'make',
          'cmake',
          'meson',
          'ninja',
          'lua',
          'bash',
          'query',
          'json',
          'jsonc',
          'javascript',
          'jsdoc',
          'typescript',
          'tsx',
          'prisma',
          'html',
          'htmldjango',
          'css',
          'graphql',
          'python',
          'java',
          'rust',
          'toml',
          'yaml',
          'go',
          'gomod',
          'godot_resource',
          'dockerfile',
          'cpp',
          'latex',
          'markdown',
          'markdown_inline',
          'nix',
          'kotlin',
          'solidity',
          'zig',
        },
        highlight = {
          enable = true,
          disable = {},
        },
        incremental_selection = {
          enable = false,
        },
        indent = {
          enable = true,
          disable = {},
        },
      }
    end,
  },
  {
    'folke/trouble.nvim',
    keys = {
      {
        '<leader>xx',
        function()
          require('trouble').toggle()
        end,
        mode = { 'n' },
      },

      {
        '<leader>xd',
        function()
          require('trouble').toggle { mode = 'lsp_document_diagnostics' }
        end,
        mode = { 'n' },
      },
    },
    config = function()
      require('trouble').setup {}
    end,
  },
  {
    'nvim-pack/nvim-spectre',
    cmd = { 'Spectre' },
  },
  {
    'folke/neoconf.nvim',
    opts = {},
  },
}
