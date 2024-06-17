require "user.options"
-- require "user.keymaps"
require "user.plugins"
require "user.lsp"
require "user.diagnostic"

vim.opt.signcolumn = 'yes'
vim.g.airline_theme = 'oceanicnext'
vim.opt.completeopt = {'menu', 'menuone', 'noselect', 'noinsert'}
vim.opt.smartcase = true
