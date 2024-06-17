vim.diagnostic.config({
    virtual_text = true,  -- Show diagnostics inline with the code
    signs = true,         -- Show signs in the sign column
    underline = true,     -- Underline the section of code with an issue
    update_in_insert = false,  -- Update diagnostics while in insert mode (can be distracting)
})
