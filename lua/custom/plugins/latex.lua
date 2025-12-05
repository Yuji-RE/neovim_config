return {
  -- 1. LuaSnip本体
  {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    build = 'make install_jsregexp', -- 正規表現に必要なので必須
    config = function()
      require('luasnip').setup {
        -- オートトリガーを有効にする設定など
        enable_autosnippets = true,
        update_events = 'TextChanged,TextChangedI',
      }
    end,
  },

  -- 2. VimTeX (コンテキスト検知に必要)
  {
    'lervag/vimtex',
    init = function()
      vim.g.vimtex_view_method = 'zathura' -- お好みのPDFビューア
      -- その他VimTeXの設定
    end,
  },

  -- 3. LaTeX Suiteの移植版
  {
    'iurimateus/luasnip-latex-snippets.nvim',
    dependencies = { 'L3MON4D3/LuaSnip', 'lervag/vimtex' },
    config = function()
      require('luasnip-latex-snippets').setup {
        use_treesitter = true, -- treesitterを使って数式判定する場合
        -- vimtexを使う場合は false にして vimtex の設定に依存させることも可能
      }

      -- 以下のコマンドでMarkdownでも有効化できます
      -- ObsidianユーザーならMarkdown内で使いたいと思うので必須
      require('luasnip').filetype_extend('markdown', { 'latex' })
      require('luasnip').filetype_extend('rmarkdown', { 'latex' })
      require('luasnip').filetype_extend('pandoc', { 'latex' })
    end,
  },
}
