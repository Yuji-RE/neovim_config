-- プラグイン本体の setup 関数を呼び出す
require('toggleterm').setup {
  direction = 'float',
  float_opts = {
    border = 'curved',
  },
  -- ここでキーマッピングも設定してしまうのが美しい
  open_mapping = [[<c-t>]],
  -- ターミナルモードから抜けるのを簡単にする
  on_open = function(term)
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], { noremap = true, silent = true, buffer = term.bufnr })
  end,
}
