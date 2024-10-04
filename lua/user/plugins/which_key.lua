local M = {
	"folke/which-key.nvim",
	event = "VeryLazy",
	-- lazy = true,
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
}

return M
