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

local function get_run_command(filetype)
	if filetype == "typescript" then
		return ":!echo & ts-node %"
	elseif filetype == "javascript" then
		return ":!echo & cat test | node %"
	elseif filetype == "python" then
		return ":!echo & cat test | python %"
	elseif filetype == "go" then
		return ":! echo && cat test | go run ."
	elseif filetype == "lua" then
		return ":!echo & lua %"
	elseif filetype == "cs" then
		return ":!echo & dotnet run"
	elseif filetype == "rust" then
		return ":! echo && cat test | cargo run --quiet"
	elseif filetype == "dart" then
		return ":! echo && cat test | dart %"
	else
		return ":!echo & cat %"
	end
end

vim.api.nvim_set_keymap("n", "<Tab>", ":lua  RunCodeOnFiletype()<CR>", { noremap = true, silent = true })

function RunCodeOnFiletype()
	local filetype = vim.bo.filetype
	local cmd = get_run_command(filetype)
	vim.api.nvim_command(cmd)
end

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

-- disable copiolet and supermaven
-- vim.cmd("Copilot disable")
--
-- vim.cmd("SupermavenStop")

vim.cmd("colorscheme sonokai")
vim.g.sonokai_style = "𝐌𝐚𝐢𝐚"
-- vim.cmd("colorscheme sonokai")
-- set relativenumber
vim.opt.relativenumber = true
