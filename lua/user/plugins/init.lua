-- lazy loading and installing
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			top_down = false,
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	-- {
	-- 	"github/copilot.vim",
	-- 	event = "InsertEnter",
	-- 	lazy = false,
	-- 	autoStart = true,
	-- 	config = function()
	-- 		vim.g.copilot_assume_mapped = true
	-- 		vim.g.copilot_no_tab_map = true
	-- 	end,
	-- },
	{ "nvim-treesitter/nvim-treesitter-refactor" },
	{ "nvim-treesitter/nvim-treesitter-textobjects" },
	{ "HiPhish/rainbow-delimiters.nvim" },
	{ "folke/twilight.nvim" },
	{ "neovim/nvim-lspconfig" },
	{ "nvim-tree/nvim-tree.lua" },
	{ "folke/zen-mode.nvim" },

	-- this are for complitions
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/nvim-cmp" },
	{ "onsails/lspkind.nvim" },
	{ "nvim-tree/nvim-web-devicons" },
	{ "nvim-lua/plenary.nvim" },
	{ "airblade/vim-rooter" },
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
	},
	{
		"luckasRanarison/tailwind-tools.nvim",
		name = "tailwind-tools",
		build = ":UpdateRemotePlugins",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim", -- optional
			"neovim/nvim-lspconfig", -- optional
		},
	},
	{
		"m4xshen/hardtime.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		opts = {
			showmode = true,
			max_count = 10,
			disable_mouse = true,
			hint = true,
		},
	},
	{ "ThePrimeagen/vim-be-good" },
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		opts = {
			-- configurations go here
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		-- lazy = true,
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				modules = {},
				ignore_install = {},
				ensure_installed = "all",
				sync_install = true,
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-CR>",
						node_incremental = ".",
						scope_incremental = "nill",
						node_decremental = "nill",
					},
				},
				refactor = {
					smart_rename = {
						enable = true,
						keymaps = {
							smart_rename = "grr",
						},
					},
				},
			})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				pickers = {
					find_files = {
						theme = "dropdown",
					},
				},
			})
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				tabline = {
					lualine_a = { "buffers" },
				},
			})
		end,
	},
	{
		"projekt0n/github-nvim-theme",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("github-theme").setup({})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
			require("scrollbar.handlers.gitsigns").setup()
		end,
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},
	{
		"cljoly/telescope-repo.nvim",
		config = function()
			require("telescope").load_extension("repo")
		end,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {},
		config = function()
			require("toggleterm").setup({
				size = vim.o.columns * 0.4,
				open_mapping = [[<C-Space>]],
				direction = "float",
			})
		end,
	},
	{
		"ggandor/leap.nvim",
		dependencies = {
			{ "tpope/vim-repeat" },
		},
		config = function()
			local leap = require("leap")
			leap.opts.safe_labels = {}
			leap.opts.preview_filter = function()
				return false
			end

			vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)")
		end,
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				top_down = false,
				background_colour = "#000000",
			})
		end,
	},
	{
		"yamatsum/nvim-cursorline",
		config = function()
			require("nvim-cursorline").setup({
				cursorline = {
					enable = true,
					timeout = 1000,
					number = false,
				},
				cursorword = {
					enable = true,
					min_length = 3,
					hl = { underline = true },
				},
			})
		end,
	},
	{
		"petertriho/nvim-scrollbar",
		config = function()
			require("scrollbar").setup()
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		config = function()
			require("kanagawa").setup({
				theme = "dragon",
			})
		end,
	},
	{
		"kevinhwang91/nvim-hlslens",
		config = function()
			require("scrollbar.handlers.search").setup({})
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("codecompanion").setup({
				strategies = {
					chat = {},
					inline = {},
				},
			})
		end,
	},
	{
		"williamboman/mason.nvim",
	},
	{
		"williamboman/mason-lspconfig.nvim",
	},
	{
		"stevearc/conform.nvim",
		cmd = { "ConformInfo" },
		lazy = false,
	},
	{
		"supermaven-inc/supermaven-nvim",
		config = function()
			require("supermaven-nvim").setup({
				keymaps = {
					accept_suggestion = "<A-h>",
					clear_suggestion = "<A-c>",
					accept_word = "<A-n>",
				},
				ignore_filetypes = {
					"TelescopePrompt",
					"NvimTree",
					"neo-tree",
					"notify",
					"quickfix",
					"prompt",
					"text",
					"markdown",
					"md",
				},
				disable_inline_completion = false,
				disable_keymaps = false,
			})
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				transparent_background = true,
			})
		end,
	},
	{ "tris203/precognition.nvim" },
})
