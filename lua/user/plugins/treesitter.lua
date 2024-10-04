return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")
      configs.setup({
          ensure_installed = "all",
          sync_install = false,
          auto_install = true,
          highlight = { enable = true},
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
    end
}
