return {
  'nvim-lspconfig',
  ft = { 'json', 'jsonc' },
  dependencies = {
    { 'SchemaStore.nvim' },
  },
  opts = {
    servers = {
      ['jsonls'] = {
        before_init = function(_, config)
          local schemas = vim.list_extend(
            require('schemastore').json.schemas {
              select = { 'tsconfig.json', 'package.json', '.eslintrc', 'prettierrc.json', 'Deno' },
            },

            {
              --- LuaLS settings schema
              {
                name = 'LuaLS Settings',
                url = 'https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json',
                fileMatch = { '.luarc.json', '.luarc.jsonc' },
              },
            }
          )

          config.settings.json = {
            validate = true,
            schemas = schemas,
          }
        end,
      },
    },
  },
}
