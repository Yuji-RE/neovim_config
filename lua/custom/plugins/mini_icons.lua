return {
  'nvim-mini/mini.icons',
  version = false,
  config = function()
    local icons = require 'mini.icons'

    -- =========================================================
    -- 小さいユーティリティ
    -- =========================================================
    local function group(hl, exts)
      local t = {}
      for _, ext in ipairs(exts) do
        t[ext] = { hl = hl }
      end
      return t
    end

    local function merge(into, from)
      for k, v in pairs(from) do
        into[k] = v
      end
    end

    local extension = {}

    -- =========================================================
    -- Shell / スクリプト系
    -- =========================================================
    merge(
      extension,
      group('MiniIconsGreen', {
        'sh',
        'bash',
        'zsh',
        'fish',
        'ps1',
      })
    )

    -- =========================================================
    -- Python / Data Science / 数値解析
    -- =========================================================
    merge(
      extension,
      group('MiniIconsYellow', {
        'py',
        'pyi',
        'pyx', -- Python / 型スタブ / Cython
        'ipynb', -- Jupyter Notebook
        'r',
        'rmd', -- R / R Markdown
        'jl', -- Julia
      })
    )

    -- =========================================================
    -- C 系 / システム言語
    -- =========================================================
    merge(
      extension,
      group('MiniIconsCyan', {
        'c',
        'h',
        'cpp',
        'cc',
        'cxx',
        'hpp',
        'rs', -- Rust
        'go', -- Go
      })
    )

    -- =========================================================
    -- Web / フロントエンド系
    -- =========================================================
    merge(
      extension,
      group('MiniIconsOrange', {
        'html',
        'htm',
        'css',
        'scss',
        'less',
        'js',
        'mjs',
        'cjs',
        'jsx',
        'ts',
        'tsx',
        'vue',
        'svelte',
      })
    )

    -- =========================================================
    -- Lua / Neovim 関連
    -- =========================================================
    merge(
      extension,
      group('MiniIconsAzure', {
        'lua',
        'vim', -- vimrc 系ファイルも一応 extension として
      })
    )

    -- =========================================================
    -- マークアップ / ドキュメント
    -- =========================================================
    merge(
      extension,
      group('MiniIconsBlue', {
        'md',
        'markdown',
        'rst',
        'txt',
        'tex',
        'sty',
        'cls',
        'org',
        'pdf', -- 図や資料 PDF
      })
    )

    -- =========================================================
    -- 設定ファイル / Config / フォーマット系
    --   → コード本体とは別カラーにする
    -- =========================================================
    merge(
      extension,
      group('MiniIconsConfig', {
        'json',
        'jsonc',
        'yaml',
        'yml',
        'toml',
        'ini',
        'conf',
        'env',
        'lock',
      })
    )

    -- =========================================================
    -- データファイル系（テーブル / DB / バイナリ）
    -- =========================================================
    merge(
      extension,
      group('MiniIconsPurple', {
        -- テキスト系データ
        'csv',
        'tsv',

        -- カラムナ / 高速フォーマット
        'parquet',
        'feather',

        -- R / SPSS / Stata など
        'rds',
        'sav',
        'dta',

        -- numpy / pickle 系
        'pkl',
        'npy',
        'npz',

        -- DB / SQLite
        'db',
        'db3',
        'sqlite',

        -- BI ツールなどのエクスポート（ざっくり）
        'xls',
        'xlsx',
      })
    )

    -- =========================================================
    -- ログ / 一時ファイル
    -- =========================================================
    merge(
      extension,
      group('MiniIconsGrey', {
        'log',
        'out',
        'err',
        'tmp',
        'bak',
      })
    )

    -- =========================================================
    -- その他のメジャー言語
    -- =========================================================
    merge(
      extension,
      group('MiniIconsRed', {
        'java',
        'kt',
        'kts',
        'swift',
        'php',
        'rb', -- Ruby
        'hs', -- Haskell
        'scala',
        'cs', -- C#
      })
    )

    -- SQL / クエリ言語は「データ寄り」の色に寄せる
    merge(
      extension,
      group('MiniIconsPurple', {
        'sql',
      })
    )

    -- =========================================================
    -- Lisp / Scheme 系
    -- =========================================================
    merge(
      extension,
      group('MiniIconsPurple', {
        'scm', -- Scheme / Treesitter query file 等
        'lsp', -- Common Lisp-ish
        'el', -- Emacs Lisp
        'clj',
        'cljs',
        'cljc',
      })
    )

    -- =========================================================
    -- 画像 / 図 / アセット
    -- =========================================================
    merge(
      extension,
      group('MiniIconsBlue', {
        'png',
        'jpg',
        'jpeg',
        'svg',
        'webp',
      })
    )

    -- =========================================================
    -- アーカイブ / 圧縮ファイル
    -- =========================================================
    merge(
      extension,
      group('MiniIconsGrey', {
        'zip',
        'tar',
        'gz',
        'tgz',
        'bz2',
        'xz',
        '7z',
        'rar',
      })
    )

    -- =========================================================
    -- mini.icons 本体のセットアップ
    -- =========================================================
    icons.setup {
      extension = extension,
      file = {
        ['README.md'] = { hl = 'MiniIconsBlue' },
        ['readme.md'] = { hl = 'MiniIconsBlue' }, -- 念のため
        ['README'] = { hl = 'MiniIconsBlue' }, -- 拡張子なしケースもカバー
      },
    }

    -- =========================================================
    -- ハイライト定義
    --   ※ 本当は colorscheme 側に寄せるのが理想だけど、
    --     このファイルだけで完結するようにここで定義しておく
    -- =========================================================
    vim.api.nvim_set_hl(0, 'MiniIconsGreen', { fg = '#22c55e' })
    vim.api.nvim_set_hl(0, 'MiniIconsYellow', { fg = '#eab308' })
    vim.api.nvim_set_hl(0, 'MiniIconsOrange', { fg = '#f97316' })
    vim.api.nvim_set_hl(0, 'MiniIconsBlue', { fg = '#565ad6' })
    vim.api.nvim_set_hl(0, 'MiniIconsAzure', { fg = '#38bdf8' })
    vim.api.nvim_set_hl(0, 'MiniIconsCyan', { fg = '#d996d0' })
    vim.api.nvim_set_hl(0, 'MiniIconsPurple', { fg = '#a855f7' })
    vim.api.nvim_set_hl(0, 'MiniIconsRed', { fg = '#ef4444' })
    vim.api.nvim_set_hl(0, 'MiniIconsGrey', { fg = '#b6d996' })

    -- ~/.config/nvim/lua/custom/plugins/mini_icons.lua の config() の中あたり
    vim.api.nvim_set_hl(0, 'MyIconData', { fg = '#22c55e' })
    vim.api.nvim_set_hl(0, 'MyIconDotfiles', { fg = '#f97316' })
    vim.api.nvim_set_hl(0, 'MyIconNotes', { fg = '#565ad6' })

    -- Config 専用（コードの Yellow より少し淡く）
    vim.api.nvim_set_hl(0, 'MiniIconsConfig', { fg = '#facc15' })

    -- =========================================================
    -- web-devicons 互換 API（既存設定との互換用）
    -- =========================================================
    icons.mock_nvim_web_devicons()
  end,
}
