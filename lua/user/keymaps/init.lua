vim.g.mapleader = " "
vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<F5>", ":Copilot toggle<CR>", { noremap = true, silent = true })
--vim.api.nvim_set_keymap("i", "<A-h>", 'copilot#Accept("<CR>")', { expr = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-h>", 'copilot#Accept("<CR>") . "<Esc>"', { expr = true, silent = true })

-- vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>o", ":w<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>w", ":w<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>q", ":q!<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>z", "<cmd>ZenMode<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>bd", [[:lua CloseOtherBuffers()<CR>]], { noremap = true, silent = true })
function CloseOtherBuffers()
	local current_buf = vim.api.nvim_get_current_buf()
	local buffers = vim.api.nvim_list_bufs()

	for _, buf in ipairs(buffers) do
		if buf ~= current_buf and vim.api.nvim_buf_is_loaded(buf) then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
end

--- add formating
--vim.api.nvim_set_keymap('n', '<leader>f', ':lua vim.lsp.buf.formatting()<CR>', { noremap = true, silent = true })
--

-- Keymaps for Telescope
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = false }

-- Direct Telescope access with 't'
map("n", "<leader>t", "<cmd>Telescope<CR>", opts) -- Direct Telescope command

-- Single letters for most common file operations
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



--- spectial function
function current_directory_oldfiles()
    local opts = require('telescope.themes').get_dropdown{}  -- Uses dropdown theme, customize as needed
    require('telescope.builtin').oldfiles({
        cwd_only = true,  -- Restrict to current working directory
        prompt_title = 'Old Files in Current Directory',  -- Custom title
        opts
    })
end

map("n", "<leader>sc", "<cmd>lua current_directory_oldfiles()<CR>", opts)
-- key map for telescope repo


-- maps for buffers
-- th and tn for next and previous buffer
map("n", "tn", "<cmd>bnext<CR>", opts)
map("n", "th", "<cmd>bprev<CR>", opts)
map("n", "td", "<cmd>bd<CR>", opts)
map("n", "ta", "<cmd>bufdo bd<CR>", opts)

-- window maps
map("n", "ss", "<cmd>vs<CR>", opts)
-- map("n", "sh", "<C-w>h", opts)
-- map("n", "st", "<C-w>j", opts)

vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })


-- more 
-- c-a far select all
map("n", "<C-a>", "gg<S-v>G", opts)

vim.api.nvim_set_keymap('n', '<leader>d', ':cd %:p:h<CR>:pwd<CR>', { noremap = true, silent = true })
