-- Rust language support configuration

require('lze').load {
  {
    'crates.nvim',
    ft = { 'rust', 'toml' },
    after = function()
      require('crates').setup {
        src = {
          cmp = {
            enabled = true,
          },
        },
        popup = {
          autofocus = true,
          hide_on_select = true,
          copy_register = '"',
          style = 'minimal',
          border = 'none',
          show_version_date = false,
          show_dependency_version = true,
          max_height = 30,
          min_width = 20,
          padding = 1,
        },
        null_ls = {
          enabled = true,
          name = 'crates.nvim',
        },
        lsp = {
          enabled = true,
          on_attach = function(client, bufnr)
            -- Enable completion triggered by <c-x><c-o>
            vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
          end,
          actions = true,
          completion = true,
          hover = true,
        },
      }
    end,
  },
}

require('lze').load {
  {
    'rustaceanvim',
    ft = { 'rust' },
    after = function()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(client, bufnr)
            -- Set up buffer-local keymaps for Rust
            local opts = { buffer = bufnr, silent = true }

            -- Code actions
            vim.keymap.set('n', '<leader>ca', function()
              vim.cmd.RustLsp 'codeAction'
            end, vim.tbl_extend('force', opts, { desc = 'Rust code action' }))

            -- Hover actions
            vim.keymap.set('n', 'K', function()
              vim.cmd.RustLsp { 'hover', 'actions' }
            end, vim.tbl_extend('force', opts, { desc = 'Rust hover actions' }))

            -- Rust-specific commands
            vim.keymap.set('n', '<leader>rr', function()
              vim.cmd.RustLsp 'run'
            end, vim.tbl_extend('force', opts, { desc = 'Rust run' }))

            vim.keymap.set('n', '<leader>rt', function()
              vim.cmd.RustLsp 'testables'
            end, vim.tbl_extend('force', opts, { desc = 'Rust test' }))

            vim.keymap.set('n', '<leader>rd', function()
              vim.cmd.RustLsp 'debuggables'
            end, vim.tbl_extend('force', opts, { desc = 'Rust debug' }))

            vim.keymap.set('n', '<leader>re', function()
              vim.cmd.RustLsp 'explainError'
            end, vim.tbl_extend('force', opts, { desc = 'Rust explain error' }))

            vim.keymap.set('n', '<leader>rc', function()
              vim.cmd.RustLsp 'openCargo'
            end, vim.tbl_extend('force', opts, { desc = 'Open Cargo.toml' }))

            vim.keymap.set('n', '<leader>rp', function()
              vim.cmd.RustLsp 'parentModule'
            end, vim.tbl_extend('force', opts, { desc = 'Parent module' }))
          end,
          settings = {
            ['rust-analyzer'] = {
              cargo = {
                features = 'all',
              },
              check = {
                command = 'clippy',
                features = 'all',
              },
              procMacro = {
                enable = true,
              },
            },
          },
        },
        tools = {
          hover_actions = {
            auto_focus = true,
          },
          inlay_hints = {
            auto = true,
          },
        },
        dap = {
          adapter = {
            type = 'executable',
            command = 'lldb-vscode',
            name = 'rt_lldb',
          },
        },
      }
    end,
  },
}
