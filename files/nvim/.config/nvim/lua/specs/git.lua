return {
  {
    'sindrets/diffview.nvim',
    keys = {
      { '<leader>do', '<cmd>DiffviewOpen<cr>', mode = { 'n' } },
      { '<leader>dc', '<cmd>DiffviewClose<cr>', mode = { 'n' } },
    },
  },
  {
    'tpope/vim-fugitive',
    cmd = { 'G' },
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPost' },
    config = function()
      local keymap = require('utils.keymap')

      require('gitsigns').setup {
        signs = {
          add = { text = '│' },
          change = { text = '│' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, lhs, rhs, opts)
            opts = opts or {}
            opts.buffer = bufnr
            keymap.set(mode, lhs, rhs, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then
              return ']c'
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return '<Ignore>'
          end, { expr = true })

          map('n', '[c', function()
            if vim.wo.diff then
              return '[c'
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return '<Ignore>'
          end, { expr = true })

          -- Actions
          map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
          map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
          map('n', '<leader>hS', gs.stage_buffer)
          map('n', '<leader>hu', gs.undo_stage_hunk)
          map('n', '<leader>hR', gs.reset_buffer)
          map('n', '<leader>hp', gs.preview_hunk)
          map('n', '<leader>hb', function()
            gs.blame_line { full = true }
          end)
          map('n', '<leader>tb', gs.toggle_current_line_blame)
          map('n', '<leader>hd', gs.diffthis)
          map('n', '<leader>td', gs.toggle_deleted)

          -- Text object
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end,
      }
    end,
  },
  {
    'NeogitOrg/neogit',
    cmd = { 'Neogit' },
    keys = {
      {
        '<leader>gg',
        function()
          require('neogit').open {}
        end,
        mode = { 'n' },
      },
    },

    config = function()
      require('neogit').setup {}
    end,
  },
}
