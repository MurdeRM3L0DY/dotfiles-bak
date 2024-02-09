local keymap = require 'utils.keymap'
local USER_AUGROUP = require 'config.autocmds'

vim.diagnostic.config {
  severity_sort = true,
  update_in_insert = true,
  virtual_text = false,
  signs = false,
  underline = true,
  float = {
    border = 'single',
    header = '',
    source = true,
  },
}

keymap.set('n', '<leader>dd', function()
  vim.diagnostic.open_float()
end)
keymap.set('n', '<leader>dk', function()
  vim.diagnostic.goto_prev()
end)
keymap.set('n', '<leader>dj', function()
  vim.diagnostic.goto_next()
end)
keymap.set('n', '<leader>dl', function()
  vim.diagnostic.setloclist()
end)

USER_AUGROUP(function(au)
  au.create({ 'ModeChanged' }, {
    pattern = { 'i:*' },
    callback = function(ctx)
      if vim.diagnostic.is_disabled(ctx.buf, nil) then
        vim.diagnostic.enable(ctx.buf, nil)
        -- vim.defer_fn(function()
        --   vim.diagnostic.open_float { bufnr = ctx.buf, scope = "cursor" }
        -- end, 200)
      end
    end
  })

  au.create({ 'ModeChanged' }, {
    pattern = { '*:i' },
    callback = function(ctx)
      if not vim.diagnostic.is_disabled(ctx.buf, nil) then
        vim.diagnostic.disable(ctx.buf, nil)
      end
    end
  })
end)
