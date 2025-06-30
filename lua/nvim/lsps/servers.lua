local servers = {}

servers.lua_ls = {
  filetypes = { 'lua' },
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      formatters = { ignoreComments = true },
      signatureHelp = { enabled = true },
      diagnostics = {
        globals = { 'nixCats', 'vim' },
        disable = { 'missing-fields' },
      },
      telemetry = { enabled = false },
    },
  },
}

servers.basedpyright = {
  settings = {
    basedpyright = {
      analysis = { typeCheckingMode = 'standard' },
    },
  },
}

servers.nixd = {
  filetypes = { 'nix' },
  settings = {
    nixd = {
      nixpkgs = { expr = 'import <nixpkgs> {}' },
      options = {
        nixos = {
          expr = '(builtins.getFlake "github:dileep-kishore/nixos-hyprland").nixosConfigurations.tsuki.options',
        },
        home_manger = {
          expr = '(builtins.getFlake "github:dileep-kishore/nixos-hyprland").homeConfigurations."g8k@lap135849".options',
        },
      },
    },
  },
}

servers.gopls = {}

servers.astro = {}

servers.bashls = {}

servers.dockerls = {}

servers.eslint = {}

servers.jsonls = {}

servers.harper_ls = {
  filetypes = { 'markdown', 'gitcommit', 'typst', 'html', 'text' },
}

servers.ltex_plus = {
  filetypes = {
    'bib',
    'org',
    'plaintex',
    'rst',
    'rnoweb',
    'tex',
    'pandoc',
    'quarto',
    'rmd',
    'context',
  },
  settings = {
    check_frequency = 'save',
  },
}

servers.texlab = {}

servers.marksman = {}

-- NOTE: julials must be installed manually
-- julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer")'
-- julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.update()'
servers.julials = {}

servers.ts_ls = {
  filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
}

servers.rust_analyzer = {
  settings = {
    ['rust-analyzer'] = {
      cargo = { features = 'all' },
      check = { command = 'clippy', features = 'all' },
      inlayHints = {
        bindingModeHints = { enable = false },
        chainingHints = { enable = true },
        closingBraceHints = { enable = true, minLines = 25 },
        closureReturnTypeHints = { enable = 'never' },
        lifetimeElisionHints = { enable = 'never', useParameterNames = false },
        maxLength = 25,
        parameterHints = { enable = true },
        reborrowHints = { enable = 'never' },
        renderColons = true,
        typeHints = { enable = true, hideClosureInitialization = false, hideNamedConstructor = false },
      },
    },
  },
}

servers.svelte = {}

servers.tailwindcss = {}

servers.tinymist = {}

servers.cssls = {}

servers.html = {}

servers.lexical = {
  filetypes = { 'elixir', 'eelixir', 'heex', 'surface' },
  cmd = { 'lexical' },
  root_dir = function(fname)
    return vim.fs.dirname(vim.fs.find({ 'mix.exs' }, { path = fname, upward = true })[1])
  end,
  settings = {
    lexical = {
      dialyzerEnabled = true,
      fetchDeps = true,
      formatOnSave = true,
      suggestSpecs = true,
    },
  },
  capabilities = {
    textDocument = {
      definition = { linkSupport = true },
      declaration = { linkSupport = true },
      implementation = { linkSupport = true },
      typeDefinition = { linkSupport = true },
      references = { includeDeclaration = true },
      documentSymbol = {
        hierarchicalDocumentSymbolSupport = true,
        symbolKind = {
          valueSet = {
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8,
            9,
            10,
            11,
            12,
            13,
            14,
            15,
            16,
            17,
            18,
            19,
            20,
            21,
            22,
            23,
            24,
            25,
            26,
          },
        },
      },
      workspaceSymbol = {
        symbolKind = {
          valueSet = {
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8,
            9,
            10,
            11,
            12,
            13,
            14,
            15,
            16,
            17,
            18,
            19,
            20,
            21,
            22,
            23,
            24,
            25,
            26,
          },
        },
      },
    },
  },
  on_attach = function(client, bufnr)
    if client.server_capabilities.definitionProvider then
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'Go to definition' })
    end
    if client.server_capabilities.declarationProvider then
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'Go to declaration' })
    end
    if client.server_capabilities.implementationProvider then
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = bufnr, desc = 'Go to implementation' })
    end
    if client.server_capabilities.typeDefinitionProvider then
      vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { buffer = bufnr, desc = 'Go to type definition' })
    end
    if client.server_capabilities.referencesProvider then
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, desc = 'Find references' })
    end
  end,
}

return servers
