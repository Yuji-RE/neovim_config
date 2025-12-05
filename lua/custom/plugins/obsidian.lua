return {
  'obsidian-nvim/obsidian.nvim',

  -- lazy.nvim が賢く判断してくれることが多いですが、
  -- Markdownファイルを開いた時に読み込むようにすると確実です
  ft = 'markdown',

  -- obsidian.nvim は他のプラグインと連携して動くので、依存関係を明記します
  dependencies = {
    -- 多くのプラグインが必要とする便利ライブラリ
    'nvim-lua/plenary.nvim',

    -- finderとしてTelescopeを使うために必要
    'nvim-telescope/telescope.nvim',
  },

  -- ここからが、私たちが一緒に作り上げてきた設定の心臓部です
  opts = {
    -- あなたのObsidian Vaultの場所を指定します
    workspaces = {
      {
        name = 'datascience',
        path = '~/Data Science',
      },
    },

    -- 警告1の解決策: 古いコマンド名を無効化し、警告を消します
    legacy_commands = false,

    -- エラー2の解決策: obsidian.nvim自身によるlinterチェックを無効化します
    -- (linterは別の lint.lua で管理するため)
    diagnostics = {
      disable = { 'markdownlint' },
    },

    -- Telescopeを検索UIとして使用するための設定
    finder = 'Telescope',

    -- nvim-cmpの設定ファイルを作るまで、補完機能との連携を無効化しエラーを防ぎます
    completion = {
      nvim_cmp = false,
    },

    -- (おまけ: あると便利な設定)
    -- デイリーノートを保存するフォルダと形式を指定します
    daily_notes = {
      folder = 'Daily', -- 例: "Daily", "dailies/log" など、あなたのフォルダ名に合わせてください
      date_format = '%Y-%m-%d',
    },

    -- ノート間のリンク表示などを綺麗にするための設定 (conceallevelと連携)
    ui = {
      enable = false,
      update_debounce = 200, -- ラグ対策: UI更新の頻度を少し落とす
    },
  },
}
