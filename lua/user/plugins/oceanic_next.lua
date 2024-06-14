local M = {
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
}

return M
