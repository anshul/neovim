require('lze').load {
  {
    'nvim-treesitter',
    event = 'DeferredUIEnter',
    load = function(name)
      require('lzextras').loaders.multi {
        name,
        'nvim-treesitter-textobjects',
        'treesitter-context',
        'nvim-ts-autotag',
      }
    end,
    after = function(_)
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('nvim_treesitter_highlight', { clear = true }),
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) then
          pcall(vim.treesitter.start, buf)
        end
      end

      require('nvim-treesitter-textobjects').setup {
        select = {
          lookahead = true,
        },
        move = {
          set_jumps = true,
        },
      }

      local select = require 'nvim-treesitter-textobjects.select'
      local select_keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
        ['al'] = '@loop.outer',
        ['il'] = '@loop.inner',
        ['as'] = '@conditional.outer',
        ['is'] = '@conditional.inner',
      }
      for key, query in pairs(select_keymaps) do
        vim.keymap.set({ 'x', 'o' }, key, function()
          select.select_textobject(query, 'textobjects')
        end, { desc = 'Select ' .. query })
      end

      local move = require 'nvim-treesitter-textobjects.move'
      local move_keymaps = {
        goto_next_start = {
          [']f'] = '@function.outer',
          [']c'] = '@class.outer',
          [']l'] = '@loop.outer',
          [']s'] = '@conditional.outer',
          [']p'] = '@parameter.outer',
          [']j'] = '@cellseparator',
        },
        goto_next_end = {
          [']F'] = '@function.outer',
          [']C'] = '@class.outer',
          [']L'] = '@loop.outer',
          [']S'] = '@conditional.outer',
          [']P'] = '@parameter.outer',
        },
        goto_previous_start = {
          ['[f'] = '@function.outer',
          ['[c'] = '@class.outer',
          ['[l'] = '@loop.outer',
          ['[s'] = '@conditional.outer',
          ['[p'] = '@parameter.outer',
          ['[j'] = '@cellseparator',
        },
        goto_previous_end = {
          ['[F'] = '@function.outer',
          ['[C'] = '@class.outer',
          ['[L'] = '@loop.outer',
          ['[S'] = '@conditional.outer',
          ['[P'] = '@parameter.outer',
        },
      }
      for fn, keymaps in pairs(move_keymaps) do
        for key, query in pairs(keymaps) do
          vim.keymap.set({ 'n', 'x', 'o' }, key, function()
            move[fn](query, 'textobjects')
          end, { desc = fn .. ' ' .. query })
        end
      end

      local swap = require 'nvim-treesitter-textobjects.swap'
      vim.keymap.set('n', 'gpl', function()
        swap.swap_next('@parameter.inner', 'textobjects')
      end, { desc = 'Swap next parameter' })
      vim.keymap.set('n', 'gph', function()
        swap.swap_previous('@parameter.inner', 'textobjects')
      end, { desc = 'Swap previous parameter' })

      require('treesitter-context').setup {
        enable = true,
        max_lines = 0,
        mode = 'topline',
        separator = '-',
        on_attach = function(bufnr)
          return vim.bo[bufnr].filetype ~= 'markdown'
        end,
      }

      require('nvim-ts-autotag').setup {
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = true,
        },
      }
    end,
  },
}
