require("lspconfig").eslint.setup({
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	on_attach = function(client, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end,
})

require("lspconfig").volar.setup({
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

require("lspconfig").cssls.setup({
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

require("lspconfig").dartls.setup({
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

require("lspconfig").gopls.setup({
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

require("lspconfig").lua_ls.setup({
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

require("lspconfig").pyright.setup({
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

require("lspconfig").rust_analyzer.setup({
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

require("lspconfig").ts_ls.setup({
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

function show_diagnostics()
	vim.diagnostic.open_float(nil, opts)
end

vim.api.nvim_set_keymap("n", "gl", "<cmd>lua show_diagnostics()<CR>", { noremap = true, silent = true })
