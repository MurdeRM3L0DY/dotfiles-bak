local keymap = require('utils.keymap')
local lsputils = require('utils.lsp')

local methods = vim.lsp.protocol.Methods

-- vim.lsp.set_log_level('trace')

vim.lsp.handlers[methods.textDocument_hover] =
  vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' })
vim.lsp.handlers[methods.textDocument_signatureHelp] =
  vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single' })

local function on_attach(client, bufnr)
  require('config.lsp.keys').apply(client, bufnr)

  -- local function if_supports_method(method, on_true)
  --   if client.supports_method(method) then
  --     on_true()
  --   end
  -- end
  --
  -- local function fzf_lsp(picker, opts)
  --   opts = opts or {}
  --   require('fzf-lua')['lsp_' .. picker](
  --     vim.tbl_extend('force', { file_icons = false, git_icons = false }, opts)
  --   )
  -- end
  --
  -- if_supports_method(methods.textDocument_codeAction, function()
  --   keymap.set({ 'n', 'x' }, '<leader>ca', function()
  --     fzf_lsp('code_actions')
  --   end, { buffer = bufnr })
  -- end)
  --
  -- if_supports_method(methods.textDocument_rename, function()
  --   keymap.set('n', '<leader>rn', function()
  --     vim.lsp.buf.rename()
  --   end, { buffer = bufnr })
  -- end)
  --
  -- if_supports_method(methods.textDocument_declaration, function()
  --   keymap.set('n', 'gD', function()
  --     fzf_lsp('declarations')
  --   end)
  -- end)
  --
  -- if_supports_method(methods.textDocument_definition, function()
  --   keymap.set('n', 'gd', function()
  --     fzf_lsp('definitions', { jump_to_single_result = true })
  --   end, { buffer = bufnr })
  -- end)
  --
  -- if_supports_method(methods.textDocument_hover, function()
  --   keymap.set('n', 'K', function()
  --     vim.lsp.buf.hover()
  --   end, { buffer = bufnr })
  -- end)
  --
  -- if_supports_method(methods.textDocument_implementation, function()
  --   keymap.set('n', 'gi', function()
  --     fzf_lsp('implementations')
  --   end, { buffer = bufnr })
  -- end)
  --
  -- if_supports_method(methods.textDocument_signatureHelp, function()
  --   keymap.set('i', '<C-s>', function()
  --     vim.lsp.buf.signature_help()
  --   end, { buffer = bufnr })
  -- end)
  --
  -- if_supports_method(methods.textDocument_typeDefinition, function()
  --   keymap.set('n', 'gt', function()
  --     fzf_lsp('typedefs')
  --   end, { buffer = bufnr })
  -- end)
  --
  -- if_supports_method(methods.textDocument_references, function()
  --   keymap.set('n', 'gr', function()
  --     fzf_lsp('references')
  --   end, { buffer = bufnr })
  -- end)
  --
  -- if_supports_method(methods.textDocument_documentSymbol, function()
  --   keymap.set('n', '<leader>ds', function()
  --     fzf_lsp('document_symbols')
  --   end, { buffer = bufnr })
  -- end)
  --
  -- if_supports_method(methods.textDocument_codeLens, function()
  --   keymap.set('n', '<leader>cl', function()
  --     vim.lsp.codelens.run()
  --   end, { buffer = bufnr })
  --
  --   lsputils.AUGROUP(function(au)
  --     au.create({ 'CursorHold' }, {
  --       buffer = bufnr,
  --       callback = function()
  --         vim.lsp.codelens.refresh()
  --       end,
  --     })
  --   end)
  -- end)
  --
  -- if_supports_method(methods.textDocument_inlayHint, function()
  --   vim.b[bufnr].inlayhint_enable = false
  --
  --   vim.defer_fn(function()
  --     vim.lsp.inlay_hint(bufnr, vim.b[bufnr].inlayhint_enable)
  --   end, 500)
  --
  --   keymap.set({ 'n' }, '<leader>ti', function()
  --     local inlayhint_enable = vim.b[bufnr].inlayhint_enable
  --     vim.b[bufnr].inlayhint_enable = not inlayhint_enable
  --     vim.lsp.inlay_hint(bufnr, nil)
  --   end, { buffer = bufnr })
  --
  --   lsputils.AUGROUP(function(au)
  --     au.create({ 'ModeChanged' }, {
  --       pattern = { 'n:i', 'i:n' },
  --       callback = function(ctx)
  --         if vim.b[ctx.buf].inlayhint_enable then
  --           vim.lsp.inlay_hint(ctx.buf, nil)
  --         end
  --       end,
  --     })
  --
  --     au.create({ 'ModeChanged' }, {
  --       pattern = { '*:s', '*:i' },
  --       callback = function(ctx)
  --         if vim.b[ctx.buf].inlayhint_enable then
  --           vim.lsp.inlay_hint(ctx.buf, false)
  --         end
  --       end,
  --     })
  --   end)
  -- end)
  --
  -- if_supports_method(methods.workspace_symbol, function()
  --   keymap.set('n', '<leader>ws', function()
  --     fzf_lsp('workspace_symbols')
  --   end, { buffer = bufnr })
  -- end)
end

-- default on attach
lsputils.on_attach(on_attach)

-- Update mappings when registering dynamic capabilities.
local register_capability = vim.lsp.handlers[methods.client_registerCapability]
vim.lsp.handlers[methods.client_registerCapability] = function(err, res, ctx)
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  if not client then
    return
  end

  on_attach(client, vim.api.nvim_get_current_buf())

  return register_capability(err, res, ctx)
end

-- lspconfig.setup({ 'lua' }, function()
--   return {
--     name = 'lua_ls',
--     cmd = { 'lua-language-server' },
--     root_markers = { '.stylua.toml', 'stylua.toml', '.luarc.json' },
--     before_init = require('neodev.lsp').before_init,
--     settings = {
--       Lua = {
--         completion = {
--           callSnippet = 'Replace',
--           showWord = 'Disable',
--         },
--         telemetry = {
--           enable = false,
--         },
--         workspace = {
--           checkThirdParty = false,
--         },
--       },
--     },
--   }
-- end)

-- lspconfig.setup({ 'json', 'jsonc' }, function()
--   local schemas = vim.list_extend(
--     require('schemastore').json.schemas {
--       select = {
--         'compile_commands.json',
--         'tsconfig.json',
--         'package.json',
--         '.eslintrc',
--         'prettierrc.json',
--         'Deno',
--       },
--     },
--
--     {
--       --- LuaLS settings schema
--       {
--         name = 'LuaLS Settings',
--         url = 'https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json',
--         fileMatch = { '.luarc.json', '.luarc.jsonc' },
--       },
--     }
--   )
--
--   return {
--     name = 'jsonls',
--     cmd = { 'vscode-json-language-server', '--stdio' },
--     settings = {
--       json = {
--         validate = true,
--         schemas = schemas,
--       },
--     },
--   }
-- end)

-- lspconfig.setup({ 'css', 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' }, function(ctx)
--   return {
--     name = 'tailwindcss',
--     cmd = { 'tailwindcss-language-server', '--stdio' },
--     root_markers = { 'tailwind.config.js', 'tailwind.config.ts', 'tailwind.config.cjs', 'tailwind.config.cts' },
--   }
-- end)

-- lspconfig.setup({ 'css' }, function(ctx)
--   return {
--     name = 'cssls',
--     cmd = { 'vscode-css-language-server', '--stdio' },
--   }
-- end)

-- lspconfig.setup({ 'rust' }, function()
--   return {
--     name = 'rust-analyzer',
--     cmd = { 'rust-analyzer' },
--     root_markers = { 'Cargo.toml' },
--   }
-- end)

-- lspconfig.setup({ 'c', 'cpp' }, function()
--   return {
--     name = 'clangd',
--     cmd = {
--       'clangd',
--       '--suggest-missing-includes',
--       '--header-insertion=iwyu',
--     },
--   }
-- end)

-- lsputils.setup({ 'python' }, function()
--   -- local function set_python_path(path)
--   --   local clients = vim.lsp.get_clients {
--   --     bufnr = vim.api.nvim_get_current_buf(),
--   --     name = 'pylance',
--   --   }
--   --   for _, client in ipairs(clients) do
--   --     client.config.settings =
--   --       vim.tbl_deep_extend('force', client.config.settings, { python = { pythonPath = path } })
--   --     client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
--   --   end
--   -- end
--
--   -- local function organize_imports()
--   --   local params = {
--   --     command = "pylance.organizeimports",
--   --     arguments = { vim.uri_from_bufnr(0) },
--   --   }
--   --   vim.lsp.buf.execute_command(params)
--   -- end
--
--   return {
--     name = 'pylance',
--     cmd = { 'pylance' },
--     root_markers = {
--       'pyproject.toml',
--       'setup.py',
--       'setup.cfg',
--       'requirements.txt',
--       'Pipfile',
--     },
--     commands = {
--       ['pylance.moveSymbolWithFileSelection'] = function(command, context) end,
--       ['pylance.organizeImports'] = function(command, context) end,
--     },
--     settings = {
--       python = {
--         -- defaultInterpreterPath = '${workspaceFolder}/...',
--         defaultInterpreterPath = vim.fn.expand('$VIRTUAL_ENV/bin/python3'),
--       },
--     },
--   }
-- end)

-- lsputils.setup({ 'java' }, function()
--   return {
--     name = 'oracle-java',
--     cmd = {
--       'node',
--       '/home/nemesis/Downloads/javavscode/Oracle.oracle-java-1.0.0/extension/out/nbcode.js',
--     },
--     root_markers = { 'pom.xml' },
--   }
-- end)
