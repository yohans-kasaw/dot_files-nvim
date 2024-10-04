require("user.lsp.python")
require("user.lsp.rust")
require("user.lsp.go")
require("user.lsp.typescript")
require("user.lsp.dart")
require("user.lsp.lua-language-server")


function show_diagnostics()
  vim.diagnostic.open_float(nil, opts)
end


--vim.api.nvim_create_autocmd("CursorHold", {
--  callback = show_diagnostics,
--})
--vim.o.updatetime = 300

-- bind gl to show diagnostic

vim.api.nvim_set_keymap('n', 'gl', '<cmd>lua show_diagnostics()<CR>', { noremap = true, silent = true })

