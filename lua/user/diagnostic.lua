vim.fn.sign_define("DiagnosticSignError", { text = Icons.diagnostics.Error, texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = Icons.diagnostics.Warning, texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignHint", { text = Icons.diagnostics.Hint, texthl = "DiagnosticSignHint" })
vim.fn.sign_define("DiagnosticSignInfo", { text = Icons.diagnostics.Information, texthl = "DiagnosticSignInfo" })

local default_diagnostic_config = {
  virtual_text = false,
  update_in_insert = false,
  underline = { severity = { min = vim.diagnostic.severity.WARN } },
  severity_sort = true,
  float = {
    focusable = true,
    style = "normal",
    border = "double",
    source = "always",
    header = "Diagnostics",
    prefix = ">>",
  },
}

vim.diagnostic.config(default_diagnostic_config)
