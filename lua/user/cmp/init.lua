local cmp = require("cmp")
local lspkind = require('lspkind')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

local cmp_mapping = require "cmp.config.mapping"
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

cmp.setup({
  window = {
      completion = cmp.config.window.bordered({
        winhighlight = "Normal:CmpCompletionNormal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
  
      }),
      documentation = cmp.config.window.bordered({
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
      }),
    },

  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', 
      before = function (entry, vim_item)
        vim_item.menu = ({
          nvim_lsp = "[LSP]",
          buffer = "[Buffer]",
          path = "[Path]",
          cmdline = "[Cmd]",
        })[entry.source.name]
        return vim_item
      end
    }),
  },


  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp_mapping(function(fallback)
    if cmp.visible() and has_words_before() then
      cmp.select_next_item()
    elseif has_words_before() then
      fallback()
    else
      fallback()
    end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp_mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    else
      fallback()
    end
    end, { "i", "s" }),
    ["<C-Space>"] = cmp_mapping.complete(),
    ["<C-e>"] = cmp_mapping.abort(),
    ["<CR>"] = cmp_mapping(function(fallback)
      if cmp.visible() and cmp.get_selected_entry() then
        cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
      else
        fallback()
      end
    end, { "i", "s" }),
  }),

  sources = cmp.config.sources(
    {{ name = 'nvim_lsp' },},
    {{ name = 'buffer' },},
    {{ name = 'path' },},
    {{ name = 'cmdline' },},
    {{ name = 'lazydev', group_index = 0},},
    {{name = 'treesitter'}},
    {{name = 'copilot'}}
  )

})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

-- cmp.event:on(
--   'confirm_done',
--   cmp_autopairs.on_confirm_done()
-- )
