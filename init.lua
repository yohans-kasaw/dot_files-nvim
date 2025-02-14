Icons = require("user.icons")

require("user.options")
require("user.plugins")
require("user.lsp")
require("user.diagnostic")
require("user.cmp")
require("user.nvim_tree")
require("user.keymaps")

vim.cmd("colorscheme kanagawa")

vim.g.neovide_transparency = 0.6
vim.cmd [[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
]]
