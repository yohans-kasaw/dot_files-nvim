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
    {"nvim-treesitter/nvim-treesitter-refactor"},
    {"nvim-treesitter/nvim-treesitter-textobjects"},
    {"nvim-treesitter/nvim-treesitter-context"},
    {"HiPhish/rainbow-delimiters.nvim"},
})

