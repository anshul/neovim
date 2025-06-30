local fold_handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (' ───────────────┤ 󰘕 %d lines ├─────╌╌╌╌╌'):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
      -- table.insert(newVirtText, { chunkText, 'MoreMsg' })
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      -- table.insert(newVirtText, { chunkText, 'MoreMsg' })
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, 'UfoFoldedFg' })
  return newVirtText
end

require('lze').load {
  {
    'nvim-ufo',
    load = function(name)
      require('lzextras').loaders.multi {
        'promise-async',
        name,
      }
    end,
    keys = {
      {
        'zR',
        function()
          require('ufo').openAllFolds()
        end,
        desc = 'Open all folds',
      },
      {
        'zM',
        function()
          require('ufo').closeAllFolds()
        end,
        desc = 'Close all folds',
      },
      {
        'zK',
        function()
          local winid = require('ufo').peekFoldedLinesUnderCursor()
          if not winid then
            vim.lsp.buf.hover()
          end
        end,
      },
      {
        'z1',
        function()
          require('ufo').closeFoldsWith(1)
        end,
        desc = 'Close folds with level 1',
      },
      {
        'z2',
        function()
          require('ufo').closeFoldsWith(2)
        end,
        desc = 'Close folds with level 2',
      },
      {
        'z3',
        function()
          require('ufo').closeFoldsWith(3)
        end,
        desc = 'Close folds with level 3',
      },
      {
        'z4',
        function()
          require('ufo').closeFoldsWith(4)
        end,
        desc = 'Close folds with level 4',
      },
      {
        'z5',
        function()
          require('ufo').closeFoldsWith(5)
        end,
        desc = 'Close folds with level 5',
      },
      {
        'zz',
        'za',
        desc = 'Toggle fold',
      },
    },
    event = { 'DeferredUIEnter' },
    after = function(_)
      require('ufo').setup {
        enable_get_fold_virt_text = true,
        provider_selector = function(bufnr, filetype, buftype)
          return { 'treesitter', 'indent' }
        end,
        fold_virt_text_handler = fold_handler,
        preview = {
          win_config = { border = 'rounded', winblend = 0 },
        },
      }
    end,
  },
}
