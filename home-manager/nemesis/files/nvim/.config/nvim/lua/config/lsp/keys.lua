local M = {}

local keys = {
  {
    'K',
    function()
      vim.lsp.buf.hover()
    end,
    mode = { 'n' },
  },
  {
    '<leader>ca',
    function()
      vim.lsp.buf.code_action()
    end,
    mode = { 'n', 'x' },
  },
  {
    '<leader>rn',
    function()
      vim.lsp.buf.rename()
    end,
    mode = { 'n' },
  },
  {
    'gD',
    function()
      vim.lsp.buf.declaration()
    end,
    mode = { 'n' },
  },
  {
    'gd',
    function()
      vim.lsp.buf.definition()
    end,
    mode = { 'n' },
  },
  {
    'gt',
    function()
      vim.lsp.buf.type_definition()
    end,
    mode = { 'n' },
  },
  {
    'gi',
    function()
      vim.lsp.buf.implementation()
    end,
    mode = { 'n' },
  },
  {
    'gr',
    function()
      vim.lsp.buf.references()
    end,
    mode = { 'n' },
  },
  {
    '<leader>sd',
    function()
      vim.lsp.buf.document_symbol()
    end,
    mode = { 'n' },
  },
  {
    '<leader>ss',
    function()
      vim.lsp.buf.workspace_symbol()
    end,
    mode = { 'n' },
  },
  {
    '<C-s>',
    function()
      vim.lsp.buf.signature_help()
    end,
    mode = { 'i' },
  },
  {
    '<leader>F',
    function()
      vim.lsp.buf.format()
    end,
    mode = { 'n', 'x' },
  },
}

function M.update(override)
  vim.list_extend(keys, override or {})
end

function M.apply(client, bufnr)
  local Keys = require('lazy.core.handler.keys')
  local keymaps = Keys.resolve(keys)
  for _, key in pairs(keymaps) do
    local opts = Keys.opts(key)
    opts.silent = opts.silent ~= false
    opts.buffer = bufnr
    require('utils.keymap').set(key.mode or 'n', key.lhs, key.rhs, opts)
  end
end

return M
