-- azy loading and installing
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
    opts = {
    },
    config = function()
      require("toggleterm").setup({
        size = vim.o.columns * 0.4,
        open_mapping = [[<C-Space>]],
        direction = 'float',
      })
    end,
  },
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
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
	},
  {"airblade/vim-rooter"},
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
		"ggandor/leap.nvim",
		config = function()
			require("leap").add_default_mappings()
			vim.keymap.set("n", "s", "<Plug>(leap)")
			vim.keymap.set("n", "S", "<Plug>(leap-from-window)")
			vim.keymap.set({ "x", "o" }, "s", "<Plug>(leap-forward)")
			vim.keymap.set({ "x", "o" }, "S", "<Plug>(leap-backward)")
		end,
	},
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
		opts = {}, -- your configuration
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				-- Other configuration options...
				top_down = false,
			})
		end,
	},
	{
		"m4xshen/hardtime.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
		opts = {
			showmode = true,
			max_count = 10,
			disable_mouse = false,
			hint = false,
		},
	},
	{ "ThePrimeagen/vim-be-good" },
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
		"petertriho/nvim-scrollbar",
		config = function()
			require("scrollbar").setup()
		end,
	},
	{
		"kevinhwang91/nvim-hlslens",
		config = function()
			-- require("hlslens").setup({})
			require("scrollbar.handlers.search").setup({
				-- hlslens config overrides
			})
			local kopts = { noremap = true, silent = true }

			vim.api.nvim_set_keymap(
				"n",
				"n",
				[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
				kopts
			)
			vim.api.nvim_set_keymap(
				"n",
				"N",
				[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
				kopts
			)
			vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

			vim.api.nvim_set_keymap("n", "<C-n>", "<Cmd>noh<CR>", kopts)
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
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
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
	{
		"github/copilot.vim",
		event = "InsertEnter",
		lazy = false,
		autoStart = true,
		config = function()
			vim.g.copilot_assume_mapped = true
			vim.api.nvim_set_keymap("i", "<A-h>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
			vim.g.copilot_no_tab_map = true
		end,
	},
})
