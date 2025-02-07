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
				ensure_installed = "all",
				sync_install = false,
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-CR>",
						node_incremental = "<C-CR>",
						-- scope_incremental = "<C-CR>",
						node_decremental = "<bs>",
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
				textobjects = {
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ab"] = "@block.outer",
							["ib"] = "@block.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
						goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
						goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
						goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
					},
				},
			})
		end,
	},
	{
		"mhartington/oceanic-next",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			vim.cmd([[

        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
        let g:oceanic_next_terminal_bold = 1
        let g:oceanic_next_terminal_italic = 1

        if (has("termguicolors"))
         set termguicolors
        endif
        colorscheme OceanicNext
      ]])
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = false, -- Auto close on trailing </
				},
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			vim.cmd([[colorscheme tokyonight]])
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
				options = {
					icons_enabled = true,
					theme = "onedark",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					ignore_focus = {},
					always_divide_middle = true,
					globalstatus = false,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					},
				},
				sections = {
					lualine_a = { "branch" },
					lualine_b = { "diff", "diagnostics" },
					lualine_c = {},
					lualine_x = { "filetype" },
					lualine_y = { "progress" },
					lualine_z = { { "datetime", style = "%H:%M" } },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {
					lualine_a = { "buffers" },
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
				winbar = {},
				inactive_winbar = {},
				extensions = {},
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
		"renerocksai/telekasten.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("telekasten").setup({
				home = vim.fn.expand("~/zettelkasten"), -- Put the name of your notes directory here
			})
		end,
	},
	{
		"epwalsh/obsidian.nvim",
		tag = "*", -- recommended, use latest release instead of latest commit
		requires = {
			-- Required.
			"nvim-lua/plenary.nvim",

			-- see below for full list of optional dependencies 👇
		},
		config = function()
			require("obsidian").setup({
				workspaces = {
					{
						name = "personal",
						path = "~/nots",
					},
				},

				-- see below for full list of options 👇
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
