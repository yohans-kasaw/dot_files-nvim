local M = {
  "folke/which-key.nvim",
  event = "VeryLazy",
  -- lazy = true,
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    window = {
        border = "single", -- none, single, double, shadow
        position = "top", -- bottom, top
        winblend = 20, -- value between 0-100 0 for fully opaque and 100 for fully transparent
      },
  }
}


return M
