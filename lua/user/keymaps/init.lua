vim.g.mapleader = " "

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = false }


map("i", "<A-h>", 'copilot#Accept("<CR>") . "<Esc>"', { expr = true, silent = true })

map("n", "<leader>z", "<cmd>ZenMode<CR>", { noremap = true, silent = true })
map("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
map("n", "<leader>o", ":w<CR>", { noremap = true, silent = true })
map("n", "<Tab>", ":lua  RunCodeOnFiletype()<CR>", { noremap = true, silent = true })

map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)
map("n", "<C-v>", ":vsplit<CR>", opts)

map("n", "tn", "<cmd>bnext<CR>", opts)
map("n", "th", "<cmd>bprev<CR>", opts)
map("n", "td", "<cmd>bd<CR>", opts)
map("n", "ta", [[:lua CloseOtherBuffers()<CR>]], { noremap = true, silent = true })

map("n", "<leader>t", "<cmd>Telescope<CR>", opts) -- Direct Telescope command
map("n", "<leader>u", "<cmd>Telescope find_files<CR>", opts) -- Find files
map("n", "<leader>g", "<cmd>Telescope live_grep<CR>", opts) -- Live grep
map("n", "<leader>a", "<cmd>Telescope oldfiles<CR>", opts) -- Recently opened files
map("n", "<leader>r", "<cmd>Telescope repo cached_list<CR>", opts) -- open repo list
map("n", "<leader>k", "<cmd>Telescope keymaps<CR>", opts) -- Keymaps
map("n", "<leader>r", [[:lua  Telescop_repos()<CR>]], opts)

map("n", "<leader>ld", "<cmd>Telescope lsp_definitions<CR>", opts)
map("n", "<leader>lR", "<cmd>Telescope lsp_references<CR>", opts)
map("n", "<leader>li", "<cmd>Telescope lsp_implementations<CR>", opts)
map("n", "<leader>lt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
map("n", "<leader>la", "<cmd>Telescope lsp_code_actions<CR>", opts)
map("n", "<leader>lD", "<cmd>Telescope diagnostics<CR>", opts)

-- this is for hlslens
map("n","n",[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], opts)
map(
  "n","N",[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], opts)
map("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], opts)
vim.api.nvim_set_keymap("n", "<C-n>", "<Cmd>noh<CR>", opts)

-- leap for reamote and increamental
vim.keymap.set({'n', 'x', 'o'}, 'ga',  function ()
  require('leap.treesitter').select()
end)

vim.keymap.set({'n', 'x', 'o'}, 'gs', function ()
  require('leap.remote').action()
end)

function Telescop_repos()
  require('telescope').extensions.repo.cached_list{file_ignore_patterns={"^" .. vim.env.HOME .. "/%.cache/", "^" .. vim.env.HOME .. "/%.cargo/",  "^" .. vim.env.HOME .. "/.local/"}}
end

function CloseOtherBuffers()
	local current_buf = vim.api.nvim_get_current_buf()
	local buffers = vim.api.nvim_list_bufs()

	for _, buf in ipairs(buffers) do
		if buf ~= current_buf and vim.api.nvim_buf_is_loaded(buf) then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
end

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

function RunCodeOnFiletype()
	local filetype = vim.bo.filetype
	local cmd = get_run_command(filetype)
	vim.api.nvim_command(cmd)
end

