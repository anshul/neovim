require 'nvim.options'

-- NOTE: Register another one from lzextras. This one makes it so that
-- you can set up lsps within lze specs,
-- and trigger lspconfig setup hooks only on the correct filetypes
require('lze').register_handlers(require('lzextras').lsp)

require 'nvim.themes'
require 'nvim.lsps'
require 'nvim.completions'
require 'nvim.treesitter'
require 'nvim.plugins'
require 'nvim.ui'
require 'nvim.bars'
require 'nvim.git'
require 'nvim.ai'
require 'nvim.literate'
require 'nvim.misc'
require 'nvim.debug'

require 'nvim.keymaps'
require 'nvim.autocmds'
