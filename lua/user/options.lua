vim.opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard
vim.opt.completeopt = { "menuone", "preview","noselect"} -- show menu for even for one

vim.opt.cmdheight = 2                           -- more space in the neovim command line for displaying messages

vim.opt.ignorecase = true 
vim.opt.mouse="a"
vim.opt.pumheight = 10 -- pop up menu height/autocompletion
vim.opt.showmode = false                        -- we don't need to see things like -- INSERT -- anymore

vim.opt.showtabline = 2                         -- always show tabs

vim.opt.expandtab = true                        -- convert tabs to spaces

vim.opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

vim.opt.cursorline = true                       -- highlight the current line
vim.opt.undofile = false 			-- no undo after closing the window
vim.opt.updatetime = 500                        -- faster completion (4000ms default)
vim.opt.number = true                           -- set numbered lines

vim.opt.swapfile = false                        -- creates a swapfile
vim.opt.signcolumn = "yes"                      -- always show the sign column, otherwise it would shift the text each time

vim.opt.wrap = false -- display lines as one long line
vim.opt.scrolloff = 10                            -- is one of my fav
vim.opt.sidescrolloff = 999 


--vim.opt.guifont = "monospace:h8"               -- the font used in graphical neovim applications
--
vim.cmd "set whichwrap+=<,>,[,],h,l"
