vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard

vim.opt.showtabline = 2
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.autoindent = true

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.opt.number = true
vim.opt.fillchars = { eob = " " }

vim.opt.signcolumn = "yes"
vim.g.airline_theme = "oceanicnext"
vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert" }
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"
vim.g.airline_theme = "oceanicnext"
vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert" }
vim.opt.smartcase = true

vim.opt.relativenumber = true

local function enable_spell()
	vim.opt_local.spell = true
	vim.opt_local.spelllang = { "en_us" } -- Using table for multiple languages
end

vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
	desc = "Conditional spell checking activation",
	callback = function(args)
		local ft = vim.bo[args.buf].filetype
		if vim.tbl_contains({ "markdown", "text" }, ft) or ft == "" then
			enable_spell()
		end
	end,
})
