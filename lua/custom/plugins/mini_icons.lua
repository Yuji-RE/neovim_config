return {
  'nvim-mini/mini.icons',
  version = false,
  config = function()
    local icons = require 'mini.icons'
    icons.setup()

    -- これがポイント：web-devicons 互換 API を生やす
    icons.mock_nvim_web_devicons()
  end,
}
