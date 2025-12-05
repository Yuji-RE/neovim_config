-- lua/plugins/hlchunk.lua
return {
  'shellRaining/hlchunk.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  main = 'hlchunk',
  opts = {
    chunk = { enable = false, treesitter = true },
    indent = {
      enable = true,

      -- 細くて細かい破線にする：より細かいのは「┊」、少し太めは「┆」
      -- お好みで { "┊" } / { "┆" } / { "┊", "┆" }（深度で切替）なども可
      chars = { '┊' },

      -- 深度ごとのカラー（上から第1レベル, 第2レベル…）
      -- 例は落ち着いたトーン。好みの16進カラーやHLグループ名でもOK
      style = {
        { fg = '#7ca196' },
      },
      line_num = { enable = false },
      blank = { enable = false },
    },
  },
}
