return {
  'akinsho/toggleterm.nvim',
  version = '*',
  -- jupynium と同じように、詳細設定は user ディレクトリに分離する
  config = function()
    require 'user.toggleterm' -- user.toggleterm.lua を呼び出す
  end,
}
