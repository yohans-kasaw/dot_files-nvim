-- Lazy loading and installing
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
	require("user.plugins.oceanic_next"),
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
}
)
