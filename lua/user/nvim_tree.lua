local use_icons = true

local function on_attach(bufnr)
	local api = require("nvim-tree.api")

	-- local function telescope_find_files(_)
	--   require("jovim.core.nvimtree").start_telescope "find_files"
	-- end

	-- local function telescope_live_grep(_)
	--   require("jovim.core.nvimtree").start_telescope "live_grep"
	-- end

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	api.config.mappings.default_on_attach(bufnr)

	local useful_keys = {
		["l"] = { api.node.open.edit, opts("Open") },
		["<CR>"] = { api.node.open.edit, opts("Open") },
		["v"] = { api.node.open.vertical, opts("Open: Vertical Split") },
		["C"] = { api.tree.change_root_to_node, opts("CD") },
		["h"] = { api.node.navigate.parent_close, opts("Close Directory") },
		-- ["gtg"] = { telescope_live_grep, opts "Telescope Live Grep" },
		-- ["gtf"] = { telescope_find_files, opts "Telescope Find File" },
	}

	for key, value in pairs(useful_keys) do
		vim.keymap.set("n", key, value[1], value[2])
	end
	vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
end

require("nvim-tree").setup({
	on_attach = on_attach,
	respect_buf_cwd = true,
	hijack_cursor = true,
	update_cwd = true,
	disable_netrw = false,
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
	view = {
		adaptive_size = false,
		centralize_selection = true,
		width = 30,
		debounce_delay = 15,
		side = "right",
		preserve_window_proportions = false,
		signcolumn = "yes",
	},

	filters = {
		dotfiles = false,
		git_clean = false,
		git_ignored = false,
		no_bookmark = false,
		no_buffer = false,
		custom = { "node_modules", "\\.cache" },
		exclude = {},
	},

	diagnostics = {
		enable = use_icons,
		show_on_dirs = true,
		show_on_open_dirs = true,
		debounce_delay = 50,
		severity = {
			min = vim.diagnostic.severity.HINT,
			max = vim.diagnostic.severity.ERROR,
		},
		icons = {
			hint = Icons.diagnostics.BoldHint,
			info = Icons.diagnostics.BoldInformation,
			warning = Icons.diagnostics.BoldWarning,
			error = Icons.diagnostics.BoldError,
		},
	},

	renderer = {
		add_trailing = true,
		group_empty = true,
		highlight_opened_files = "name",
		-- highlight_modified = "all",
		root_folder_label = ":t",
		full_name = true,
		indent_width = 3,
		special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
		symlink_destination = true,
		indent_markers = {
			enable = true,
			inline_arrows = true,
			icons = {
				corner = "└",
				edge = "│",
				item = "│",
				bottom = "─",
				none = " ",
			},
		},
		icons = {
			webdev_colors = use_icons,
			web_devicons = {
				file = {
					enable = use_icons,
					color = use_icons,
				},
				folder = {
					enable = true,
					color = use_icons,
				},
			},
			git_placement = "before",
			padding = " ",
			symlink_arrow = " ➛ ",
			modified_placement = "after",
			diagnostics_placement = "signcolumn",
			bookmarks_placement = "signcolumn",
			show = {
				file = use_icons,
				folder = use_icons,
				folder_arrow = use_icons,
				git = use_icons,
				modified = use_icons,
				diagnostics = use_icons,
				bookmarks = use_icons,
			},
			glyphs = {
				default = Icons.ui.Text,
				symlink = Icons.ui.FileSymlink,
				bookmark = Icons.ui.BookMark,
				modified = Icons.ui.Circle,
				folder = {
					arrow_closed = Icons.ui.TriangleShortArrowRight,
					arrow_open = Icons.ui.TriangleShortArrowDown,
					default = Icons.ui.Folder,
					open = Icons.ui.FolderOpen,
					empty = Icons.ui.EmptyFolder,
					empty_open = Icons.ui.EmptyFolderOpen,
					symlink = Icons.ui.FolderSymlink,
					symlink_open = Icons.ui.FolderOpen,
				},
				git = {
					unstaged = Icons.git.FileUnstaged,
					staged = Icons.git.FileStaged,
					unmerged = Icons.git.FileUnmerged,
					renamed = Icons.git.FileRenamed,
					untracked = Icons.git.FileUntracked,
					deleted = Icons.git.FileDeleted,
					ignored = Icons.git.FileIgnored,
				},
			},
		},
	},
})
