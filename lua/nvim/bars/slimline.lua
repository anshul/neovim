require('lze').load {
  {
    'slimline-nvim',
    dep = { 'noice.nvim', 'grapple.nvim' },
    after = function(_)
      local grapple_status = function()
        local status_ok, grapple = pcall(require, 'grapple')
        if not status_ok then
          return ''
        end
        local grapple_status_text = grapple.statusline {}
        if grapple_status_text == '' or grapple_status_text == nil then
          return ''
        end
        local output_text_lhs = '󰛢'
        local output_text_rhs = string.sub(grapple_status_text, 6):gsub('%s+$', '')
        if output_text_rhs == '' then
          return ''
        end
        return output_text_lhs .. ' ' .. output_text_rhs
      end

      require('slimline').setup {
        style = 'bg',
        components = {
          left = { 'mode', 'git' },
          center = { 'path', grapple_status },
          right = { 'recording', 'diagnostics', 'filetype_lsp', 'progress' },
        },
        spaces = { components = '─', left = '', right = '' },
        sep = {
          hide = { first = false, last = false },
          left = '',
          right = '',
        },
        configs = {
          mode = {
            verbose = true,
          },
          path = {
            directory = true,
            icons = { folder = ' ', modified = '', read_only = '' },
          },
          git = {
            icons = {
              branch = '',
              added = ' ',
              modified = ' ',
              removed = ' ',
            },
          },
          diagnostics = {
            verbose = true,
            icons = {
              ERROR = ' ',
              WARN = ' ',
              HINT = ' ',
              INFO = ' ',
            },
          },
          filetype_lsp = {},
          progress = { follow = 'mode', column = false, icon = ' ' },
          recording = {
            hl = { primary = 'Error' },
            icon = '󰻂 ',
          },
        },
      }
      require('slimline.highlights').create_hls()
      local colors = require('catppuccin.palettes').get_palette 'mocha'
      local set_hl_primary = function(name, fg_color, bg_color)
        vim.api.nvim_set_hl(0, name, { fg = fg_color, bg = bg_color, italic = true, bold = true })
      end
      local set_hl_secondary = function(name, fg_color, bg_color)
        vim.api.nvim_set_hl(0, name, { fg = fg_color, bg = bg_color })
      end
      local set_hl_tertiary = function(name, fg_color, bg_color)
        vim.api.nvim_set_hl(0, name, { fg = fg_color, bg = bg_color, bold = true })
      end
      -- modes
      set_hl_tertiary('SlimlineModeNormal', colors.crust, colors.yellow)
      set_hl_tertiary('SlimlineModeInsert', colors.crust, colors.green)
      set_hl_tertiary('SlimlineModeVisual', colors.crust, colors.mauve)
      set_hl_tertiary('SlimlineModeCommand', colors.crust, colors.peach)
      set_hl_tertiary('SlimlineModePending', colors.crust, colors.red)
      -- other primary
      set_hl_primary('SlimlinePathPrimary', colors.crust, colors.mauve)
      set_hl_primary('SlimlineGitPrimary', colors.crust, colors.blue)
      set_hl_tertiary('SlimlineDiagnosticsPrimary', colors.crust, colors.peach)
      set_hl_primary('SlimlineFiletype_lspPrimary', colors.crust, colors.green)
      -- secondary
      set_hl_secondary('SlimlinePathSecondary', colors.text, colors.surface0)
      set_hl_secondary('SlimlineGitSecondary', colors.text, colors.surface0)
      set_hl_secondary('SlimlineDiagnosticsSecondary', colors.text, colors.surface0)
      set_hl_secondary('SlimlineFiletype_lspSecondary', colors.text, colors.surface0)
    end,
  },
}
