local keymap = require('utils.keymap')
local lsputils = require('utils.lsp')

local config = {}

config.flags = {
  allow_incremental_sync = true,
}

config.handlers = {
  ['language/status'] = function() end,
}

config.settings = {
  java = {
    signatureHelp = { enabled = true },
    contentProvider = { preferred = 'fernflower' },
    -- saveActions = {
    --   organizeImports = true,
    -- },
    completion = {
      favoriteStaticMembers = {
        'org.hamcrest.MatcherAssert.assertThat',
        'org.hamcrest.Matchers.*',
        'org.hamcrest.CoreMatchers.*',
        'org.junit.jupiter.api.Assertions.*',
        'java.util.Objects.requireNonNull',
        'java.util.Objects.requireNonNullElse',
        'org.mockito.Mockito.*',
      },
    },
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = '${object.className} { ${member.name()}=${member.value}, ${otherMembers} }',
      },
    },
    configuration = {
      runtimes = {
        -- {
        --   name = 'JavaSE-11',
        --   path = ('%s/.sdkman/candidates/java/11.0.12-open/'):format(os.getenv 'HOME'),
        -- },
      },
    },
  },
}

config.on_attach = function(_, bufnr)
  local jdtls = require('jdtls')

  local opts = { buffer = bufnr }

  keymap.set('n', '<A-o>', function()
    jdtls.organize_imports()
  end, opts)
  keymap.set('n', 'crc', function()
    jdtls.extract_constant()
  end, opts)
  keymap.set('n', 'crv', function()
    jdtls.extract_variable()
  end, opts)
  keymap.set('n', 'crm', function()
    jdtls.extract_method()
  end, opts)

  keymap.set('v', 'crc', "<ESC><CMD>lua require('jdtls').extract_constant(true)<CR>", opts)
  keymap.set('v', 'crv', "<ESC><CMD>lua require('jdtls').extract_variable(true)<CR>", opts)
  keymap.set('v', 'crm', "<ESC><CMD>lua require('jdtls').extract_method(true)<CR>", opts)
end

config.before_init = function(_, conf)
  local extendedClientCapabilities = conf.init_options.extendedClientCapabilities
  extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
  extendedClientCapabilities.onCompletionItemSelectedCommand = 'editor.action.triggerParameterHints'
end

config.init_options = {
  bundles = {},
}

return {
  'mfussenegger/nvim-jdtls',
  init = function()
    lsputils.setup({ 'java' }, function(ctx)
      config.root_dir = vim.fs.dirname(
        vim.fs.find({ 'gradlew', 'settings.gradle', 'mvnw', 'pom.xml' }, { upward = true })[1]
      )
      config.cmd = {
        'jdt-language-server',
        '-data',
        vim.fs.normalize('$HOME/.jdtls/' .. vim.fn.fnamemodify(config.root_dir, ':t')),
      }

      require('jdtls').start_or_attach(lsputils.make_config(config))
    end)
  end,
}
