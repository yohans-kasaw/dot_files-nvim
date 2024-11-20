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
	require("user.plugins.which_key"),
	--require("user.plugins.oceanic_next"),
	require("user.plugins.treesitter"),
	require("user.plugins.nvim_ts_autotag"),
	require("user.plugins.formater"),
	require("user.plugins.telescope"),
	require("user.plugins.lualine"),
	require("user.plugins.github-theme"),
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{ "nvim-treesitter/nvim-treesitter-refactor" },
	{ "nvim-treesitter/nvim-treesitter-textobjects" },
	{ "HiPhish/rainbow-delimiters.nvim" },
	{ "folke/twilight.nvim" },
	{ "neovim/nvim-lspconfig" },
	{ "nvim-tree/nvim-tree.lua" },
	{ "github/copilot.vim" },
	{ "folke/zen-mode.nvim" },

	-- this are for complitions
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/nvim-cmp" },
	{ "onsails/lspkind.nvim" },
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},
	{ "nvim-tree/nvim-web-devicons" },
	{ "nvim-lua/plenary.nvim" },
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
	},
	{ "cljoly/telescope-repo.nvim" },
	{ "jvgrootveld/telescope-zoxide" },
	{ "AckslD/nvim-neoclip.lua" },
	{ "debugloop/telescope-undo.nvim" },

	{
		"nvim-telescope/telescope-frecency.nvim",
		config = function()
			require("telescope").load_extension("frecency")
		end,
	},

	{
		"nvim-telescope/telescope-project.nvim",
		config = function()
			require("telescope").load_extension("project")
		end,
	},

	{
		"akinsho/flutter-tools.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim", -- optional for vim.ui.select
		},
		config = true,
	},
	-- 	{
	-- 		"nvimdev/dashboard-nvim",
	-- 		event = "VimEnter",
	-- 		config = function()
	-- 			local logo = [[
	--      ██╗ ██████╗         ███████╗ ██████╗ ██████╗  ██████╗███████╗███████╗
	--      ██║██╔═══██╗        ██╔════╝██╔═══██╗██╔══██╗██╔════╝██╔════╝██╔════╝
	--      ██║██║   ██║        █████╗  ██║   ██║██████╔╝██║     █████╗  ███████╗
	-- ██   ██║██║   ██║        ██╔══╝  ██║   ██║██╔══██╗██║     ██╔══╝  ╚════██║
	-- ╚█████╔╝╚██████╔╝███████╗██║     ╚██████╔╝██║  ██║╚██████╗███████╗███████║
	--  ╚════╝  ╚═════╝ ╚══════╝╚═╝      ╚═════╝ ╚═╝  ╚═╝ ╚═════╝╚══════╝╚══════╝
	--
	--             ]]
	--
	-- 			logo = string.rep("\n", 8) .. logo .. "\n\n"
	-- 			require("dashboard").setup({
	-- 				config = {
	-- 					header = vim.split(logo, "\n"), --your header
	-- 					footer = {}, --your footer
	-- 				},
	-- 			})
	-- 		end,
	-- 		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	-- 	},
	--++++++
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
	-- {
	-- 	"supermaven-inc/supermaven-nvim",
	-- 	config = function()
	-- 		require("supermaven-nvim").setup({
	-- 			keymaps = {
	-- 				accept_suggestion = "<A-h>",
	-- 			},
	-- 			color = {
	-- 				--suggestion_color = "#A9A9A9",
	-- 				cterm = 244,
	-- 			},
	-- 			log_level = "info", -- set to "off" to disable logging completely
	-- 			disable_inline_completion = false, -- disables inline completion for use with cmp
	-- 			disable_keymaps = false, -- disables built in keymaps for more manual control
	-- 			condition = function()
	-- 				return false
	-- 			end, -- condition to check for stopping supermaven, `true` means to stop supermaven when the condition is true.
	-- 		})
	-- 	end,
	-- },
	{
		"sainnhe/sonokai",
		lazy = false, -- ensure it loads immediately
		priority = 1000, -- make it load before other plugins
		-- config = function()
		-- 	vim.cmd("colorscheme sonokai")
		-- end,
	},
	{
		{
			"akinsho/toggleterm.nvim",
			version = "*",
			opts = {--[[ things you want to change go here]]
			},
			config = function()
				require("toggleterm").setup({
					size = vim.o.columns * 0.4,
					open_mapping = [[<C-Space>]],
					hide_numbers = true,
					shade_filetypes = {},
					shade_terminals = true,
					shading_factor = 2,
					start_in_insert = true,
					insert_mappings = true,
					persist_size = true,
					direction = "vertical",
					close_on_exit = true,
					shell = vim.o.shell,
					float_opts = {
						border = "curved",
						winblend = 0,
						highlights = {
							border = "Normal",
							background = "Normal",
						},
					},
				})
			end,
		},
	},
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
		"razak17/tailwind-fold.nvim",
		opts = {},
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		ft = { "html", "svelte", "astro", "vue", "typescriptreact", "php", "blade" },
	},
	{
		"laytan/tailwind-sorter.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- Provides better parsing for various languages
			"nvim-lua/plenary.nvim", -- Required for utility functions
		},
		build = "cd formatter && npm ci && npm run build", -- Build command for the plugin
		config = function()
			require("tailwind-sorter").setup({
				on_save_enabled = true, -- Automatically sort on save if true
				on_save_pattern = { -- File patterns to watch and sort
					"*.html",
					"*.js",
					"*.jsx",
					"*.ts",
					"*.tsx",
					"*.twig",
					"*.hbs",
					"*.php",
					"*.heex",
					"*.astro",
				},
				node_path = "node", -- Path to the Node.js executable
				trim_spaces = true, -- Trim extra spaces after sorting if true
			})
		end,
	},
})
