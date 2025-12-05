return {
  {
    'kiyoon/jupynium.nvim',
    build = 'pip install --user .',
    config = function()
      require 'user.jupynium' -- 詳細設定は user/jupynium.lua に書く
    end,
  },
  {
    'rcarriga/nvim-notify', -- optional, for Jupynium notifications
  },
  {
    'stevearc/dressing.nvim', -- optional, UI for kernel selection
  },
}
