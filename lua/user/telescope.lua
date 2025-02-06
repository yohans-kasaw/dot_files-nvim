require("telescope").load_extension("fzf")
require("telescope").load_extension("repo")
require("telescope").load_extension("zoxide")
require("telescope").load_extension("neoclip")
require("neoclip").setup()

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = false }

-- Direct Telescope access with 't'
map("n", "<leader>t", "<cmd>Telescope<CR>", opts) -- Direct Telescope command

map("n", "<leader>u", "<cmd>Telescope find_files<CR>", opts) -- Find files

map("n", "<leader>g", "<cmd>Telescope live_grep<CR>", opts) -- Live grep
map("n", "<leader>a", "<cmd>Telescope oldfiles<CR>", opts) -- Recently opened files
map("n", "<leader>r", "<cmd>Telescope repo list=fd<CR>", opts) -- open repo list
map("n", "<leader>k", "<cmd>Telescope keymaps<CR>", opts) -- Keymaps

-- LSP related operations
map("n", "<leader>ld", "<cmd>Telescope lsp_definitions<CR>", opts)
map("n", "<leader>lR", "<cmd>Telescope lsp_references<CR>", opts)
map("n", "<leader>li", "<cmd>Telescope lsp_implementations<CR>", opts)
map("n", "<leader>lt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
map("n", "<leader>la", "<cmd>Telescope lsp_code_actions<CR>", opts)
map("n", "<leader>lD", "<cmd>Telescope diagnostics<CR>", opts)
