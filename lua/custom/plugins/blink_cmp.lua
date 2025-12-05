return {
  'saghen/blink.cmp',
  version = '*',
  event = { 'LspAttach' },
  dependencies = {
    'rafamadriz/friendly-snippets',
  },
  -- opts = {
  --   keymap = { preset = 'enter' },
  --   sources = {
  --     default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
  --     providers = {
  --       cmdline = {
  --         min_keyword_length = 2,
  --       },
  --       lazydev = {
  --         name = 'LazyDev',
  --         module = 'lazydev.integrations.blink',
  --         score_offset = 100,
  --       },
  --     },
  --   },
  opts = {
    keymap = {
      preset = 'default',
      ['<C-space'] = { 'show', 'show_documentation', 'hide_documentation' },
    },
    completion = {
      documentation = { window = { border = 'rounded' } },
      menu = { border = 'rounded', auto_show = false },
    },
    signature = { window = { border = 'rounded' } },
  },
  documentation = {
    auto_show_delay_ms = 0,
    auto_show = false,
  },
}
