

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

-- which-key
local which_key_table = {
  "folke/which-key.nvim",
  event = "VeryLazy",
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

require("lazy").setup({
  which_key_table
})

