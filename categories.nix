inputs: let
  inherit (inputs.nixCats) utils;
in
  {
    pkgs,
    settings,
    categories,
    name,
    extra,
    mkPlugin,
    ...
  } @ packageDef: {
    # environmentVariables:
    # this section is for environmentVariables that should be available
    # at RUN TIME for plugins. Will be available to path within neovim terminal
    environmentVariables = {
      test = {
        NVIM_VAR = "Nyaaan!";
      };
    };

    # lspsAndRuntimeDeps:
    # this section is for dependencies that should be available
    # at RUN TIME for plugins. Will be available to PATH within neovim terminal
    # this includes LSPs
    lspsAndRuntimeDeps = with pkgs; {
      general = [
        nodejs_24
        nodePackages.npm
        ripgrep
        fd
        imagemagick
        lazygit
        gh
        python3Packages.pylatexenc

        # lsps
        lua-language-server
        gopls
        basedpyright
        nixd
        astro-language-server
        bash-language-server
        dockerfile-language-server-nodejs
        vscode-langservers-extracted
        harper
        ltex-ls-plus
        texlab
        marksman
        typescript-language-server
        rust-analyzer
        svelte-language-server
        tailwindcss-language-server
        tinymist
        lexical

        # formatters
        stylua
        alejandra
        shfmt
        gofumpt
        rustfmt
        ruff
        prettierd
        typstyle
        yamlfix
        kdlfmt

        # linters
        rstcheck
        vale
        nodePackages.jsonlint
        stylelint
        hadolint
        eslint_d

        # dap
        python3Packages.debugpy

        # Rust development
        cargo-watch
        cargo-nextest
        lldb
      ];

      elixir = [
        elixir
        erlang
        # Note: credo should be added to your mix.exs dependencies
        # mix deps.get will install it in your project
      ];
    };

    # This is for plugins that will load at startup without using packadd:
    startupPlugins = {
      general = with pkgs.vimPlugins; [
        pkgs.neovimPlugins.lze
        pkgs.neovimPlugins.lzextras
        nui-nvim
        better-escape-nvim
        catppuccin-nvim
        rose-pine
        nvim-lspconfig
        nvim-treesitter.withAllGrammars
        nvim-treesitter-textobjects
        nvim-treesitter-context
        nvim-highlight-colors
        nvim-lint
        nvim-web-devicons
        tabby-nvim
        rainbow-delimiters-nvim
        vim-sleuth
        vim-matchup
        pkgs.neovimPlugins.incline-nvim
        pkgs.neovimPlugins.slimline-nvim
      ];
      # extra = with pkgs.neovimPlugins; [];
    };

    # not loaded automatically at startup.
    # use with packadd and an autocommand in config to achieve lazy loading
    optionalPlugins = {
      general = with pkgs.vimPlugins; [
        plenary-nvim
        blink-cmp
        blink-compat
        friendly-snippets
        lazydev-nvim
        lspsaga-nvim
        vim-illuminate
        promise-async
        nvim-ufo
        conform-nvim
        snacks-nvim
        nvim-notify
        noice-nvim
        inc-rename-nvim
        indent-blankline-nvim
        which-key-nvim
        gitsigns-nvim
        diffview-nvim
        neogit
        octo-nvim
        grapple-nvim
        oil-nvim
        comment-nvim
        nvim-ts-context-commentstring
        mini-indentscope
        mini-ai
        mini-animate
        mini-basics
        mini-files
        mini-icons
        mini-move
        mini-operators
        mini-surround
        treesj
        nvim-autopairs
        iron-nvim
        supermaven-nvim
        neogen
        nvim-dap
        nvim-dap-ui
        nvim-dap-python
        nvim-dap-virtual-text
        obsidian-nvim
        render-markdown-nvim
        ssr-nvim
        grug-far-nvim
        img-clip-nvim
        vim-repeat
        lspkind-nvim
        outline-nvim
        vim-tmux-navigator
        trouble-nvim
        todo-comments-nvim
        refactoring-nvim
        nvim-bqf
        marks-nvim
        markdown-preview-nvim
        cloak-nvim
        git-conflict-nvim
        nvim-ts-autotag
        flash-nvim
        tiny-inline-diagnostic-nvim
        zen-mode-nvim
        twilight-nvim
        smear-cursor-nvim
        pkgs.neovimPlugins.possession-nvim
        pkgs.neovimPlugins.websocket-nvim
        # pkgs.neovimPlugins.neopyter # Temporarily disabled due to loading error
        pkgs.neovimPlugins.colorful-winsep-nvim
        pkgs.neovimPlugins.reactive-nvim
        pkgs.neovimPlugins.symbol-usage-nvim
        pkgs.neovimPlugins.early-retirement-nvim
        pkgs.neovimPlugins.timber-nvim
        pkgs.neovimPlugins.maximize-nvim
        # Rust toolchain
        crates-nvim
        rustaceanvim
        neotest-rust
        # React/TypeScript toolchain
        # (typescript-language-server already in lspsAndRuntimeDeps)
        # Elixir enhanced support
        # (already configured in elixir section)
      ];

      elixir = with pkgs.vimPlugins; [
        elixir-tools-nvim
        neotest-elixir
        vim-endwise
      ];
    };

    # shared libraries to be added to LD_LIBRARY_PATH
    # variable available to nvim runtime
    sharedLibraries = {
      general = with pkgs; [
        # libgit2
      ];
    };

    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/setup-hooks/make-wrapper.sh
    extraWrapperArgs = {};

    # get the path to this python environment
    # in your lua config via
    # vim.g.python3_host_prog
    # or run from nvim terminal via :!<packagename>-python3
    python3.libraries = {
      python = py: [
        py.debugpy
        py.pylatexenc
      ];
    };

    # populates $LUA_PATH and $LUA_CPATH
    extraLuaPackages = {
      # vimagePreview = [ (lp: with lp; [ magick ]) ];
    };
  }
