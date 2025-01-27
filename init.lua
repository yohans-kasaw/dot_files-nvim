---call plug#end()

-- used for complition
vim.api.nvim_set_keymap("n", "<A-d>", "", { noremap = true, silent = true })

Icons = require("user.icons")

require("user.options")
require("user.plugins")
require("user.lsp")
require("user.diagnostic")
require("user.cmp")
require("user.nvim_tree")
require("user.keymaps")
require("user.telescope")
vim.opt.signcolumn = "yes"
vim.g.airline_theme = "oceanicnext"
vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert" }
vim.opt.smartcase = true

local function enable_zen_mode_for_note_files()
	local file_ext = vim.fn.expand("%:e")
	if file_ext == "note" then
		require("zen-mode").toggle()
	end
end

vim.api.nvim_create_autocmd("BufRead", {
	pattern = "*.note",
	callback = enable_zen_mode_for_note_files,
})

vim.api.nvim_create_autocmd("BufNewFile", {
	pattern = "*.note",
	callback = enable_zen_mode_for_note_files,
})

vim.cmd("colorscheme kanagawa")
vim.opt.relativenumber = true

-- Initialize spell checking for Markdown and text files
vim.api.nvim_create_autocmd({"FileType"}, {
    pattern = {"markdown", "text"},
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "en_us" -- Change to your preferred language(s)
    end,
})

-- Enable spell checking for files with no detected filetype
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    callback = function()
        if vim.bo.filetype == "" then
            vim.opt_local.spell = true
            vim.opt_local.spelllang = "en_us" -- Change to your preferred language(s)
        end
    end,
})

