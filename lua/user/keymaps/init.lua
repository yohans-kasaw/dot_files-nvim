
vim.g.mapleader = " "

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = false }

vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("i", "<A-h>", 'copilot#Accept("<CR>") . "<Esc>"', { expr = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>o", ":w<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>z", "<cmd>ZenMode<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", opts)
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", opts)
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", opts)
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", opts)
vim.api.nvim_set_keymap("n", "<C-v>", ":vsplit<CR>", opts)

vim.api.nvim_set_keymap("n", "ta", [[:lua CloseOtherBuffers()<CR>]], { noremap = true, silent = true })
map("n", "tn", "<cmd>bnext<CR>", opts)
map("n", "th", "<cmd>bprev<CR>", opts)
map("n", "td", "<cmd>bd<CR>", opts)
function CloseOtherBuffers()
	local current_buf = vim.api.nvim_get_current_buf()
	local buffers = vim.api.nvim_list_bufs()

	for _, buf in ipairs(buffers) do
		if buf ~= current_buf and vim.api.nvim_buf_is_loaded(buf) then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
end

-- Direct Telescope access with 't'
map("n", "<leader>t", "<cmd>Telescope<CR>", opts) -- Direct Telescope command

map("n", "<leader>u", "<cmd>Telescope find_files<CR>", opts) -- Find files

map("n", "<leader>g", "<cmd>Telescope live_grep<CR>", opts) -- Live grep
map("n", "<leader>a", "<cmd>Telescope oldfiles<CR>", opts) -- Recently opened files
map("n", "<leader>r", "<cmd>Telescope repo list=fd<CR>", opts) -- open repo list
map("n", "<leader>.", "<cmd>Telescope zoxide list<CR>", opts) -- open repo list
map("n", "<leader>h", "<cmd>Telescope frecency<CR>", opts) -- open repo list
map("n", "<leader>c", "<cmd>Telescope project<CR>", opts) -- open repo list

-- Other file operations
map("n", "<leader>sb", "<cmd>Telescope buffers<CR>", opts) -- Buffer list
map("n", "<leader>sh", "<cmd>Telescope help_tags<CR>", opts) -- Help tags
map("n", "<leader>sk", "<cmd>Telescope keymaps<CR>", opts) -- Keymaps

-- LSP related operations
map("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>", opts)
map("n", "<leader>lS", "<cmd>Telescope lsp_workspace_symbols<CR>", opts)
map("n", "<leader>ld", "<cmd>Telescope lsp_definitions<CR>", opts)
map("n", "<leader>lR", "<cmd>Telescope lsp_references<CR>", opts)
map("n", "<leader>li", "<cmd>Telescope lsp_implementations<CR>", opts)
map("n", "<leader>lt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
map("n", "<leader>la", "<cmd>Telescope lsp_code_actions<CR>", opts)
map("n", "<leader>lD", "<cmd>Telescope diagnostics<CR>", opts)

-- Git operations
map("n", "<leader>gs", "<cmd>Telescope git_status<CR>", opts)
map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", opts)
map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", opts)
map("n", "<leader>gC", "<cmd>Telescope git_bcommits<CR>", opts)


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
