local cmp = require('cmp')
local cmp_mapping = require('cmp.config.mapping')

-- Local helper functions
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

-- Shared configurations
local matching_settings = {
  disallow_fuzzy_matching = false,
  disallow_partial_matching = false,
  disallow_prefix_unmatching = false,
  disallow_fullfuzzy_matching = false,
  disallow_partial_fuzzy_matching = false,
  disallow_symbol_nonprefix_matching = false,
}

local completion_settings = {
  ignore_case = true,
}

local source_menu_icons = {
  nvim_lsp = '[LSP]',
  buffer = '[Buffer]',
  path = '[Path]',
  cmdline = '[Cmd]',
}

-- Window configuration
local bordered_completion = cmp.config.window.bordered({
  winhighlight = 'Normal:CmpCompletionNormal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
})

local bordered_documentation = cmp.config.window.bordered({
  winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
})

-- Mapping helpers
local fallback = function(fb) fb() end

local handle_tab = function(fallback_fn)
  if cmp.visible() and has_words_before() then
    cmp.select_next_item()
  else
    fallback_fn()
  end
end

local handle_shift_tab = function(fallback_fn)
  if cmp.visible() then
    cmp.select_prev_item()
  else
    fallback_fn()
  end
end

local confirm_selection = function(fallback_fn)
  if cmp.visible() and cmp.get_selected_entry() then
    cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
  else
    fallback_fn()
  end
end

-- Main cmp setup
cmp.setup({
  window = {
    completion = bordered_completion,
    documentation = bordered_documentation,
  },

  formatting = {
    fields = { 'abbr', 'kind', 'menu' },
    expandable_indicator = true,
    format = require('lspkind').cmp_format({
      mode = 'symbol_text',
      before = function(entry, vim_item)
        vim_item = require('tailwind-tools.cmp').lspkind_format(entry, vim_item)
        vim_item.menu = source_menu_icons[entry.source.name] or vim_item.menu
        return vim_item
      end,
    }),
  },

  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp_mapping(handle_tab, { 'i', 's' }),
    ['<S-Tab>'] = cmp_mapping(handle_shift_tab, { 'i', 's' }),
    ['<C-Space>'] = cmp_mapping.complete(),
    ['<C-e>'] = cmp_mapping.abort(),
    ['<CR>'] = cmp_mapping(confirm_selection, { 'i', 's' }),
  }),

  matching = matching_settings,
  completion = completion_settings,

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'cmdline' },
    { name = 'lazydev', group_index = 0 },
    { name = 'treesitter' },
  }),
})

-- Cmdline configurations
local cmdline_mapping = cmp.mapping.preset.cmdline()

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmdline_mapping,
  matching = matching_settings,
  completion = completion_settings,
  sources = { { name = 'buffer' } },
})

cmp.setup.cmdline(':', {
  mapping = cmdline_mapping,
  sources = cmp.config.sources(
    { { name = 'path' } },
    { { name = 'cmdline' } }
  ),
  matching = matching_settings,
  completion = completion_settings,
})
