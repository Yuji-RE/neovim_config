return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },
  opts = {
    -- ここが重要！Pythonなどのファイル内の埋め込みMarkdownも対象にする設定
    injections = {
      enabled = true,
    },

    heading = {
      position = 'inline',
      backgrounds = {},
      icons = { '', '', '', '', '', '' },
      signs = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
    },

    latex = {
      enabled = false,
      --render_modes = false,
      converter = { 'latex2text' },
      highlight = 'RenderMarkdownMath',
      position = 'center',
      top_pad = 0,
      bottom_pad = 0,
    },

    dash = { width = 7, icon = '-' },

    bullet = { icons = '-' },

    code = {
      width = 'block',
      border = 'thin',
      sign = true,
    },

    --ファイルタイプごとの設定（念のため）
    file_types = { 'markdown', 'python' },
  },
}
