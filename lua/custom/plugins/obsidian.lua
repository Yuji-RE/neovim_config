return {
  'obsidian-nvim/obsidian.nvim',

  ft = 'markdown',

  dependencies = {

    'nvim-lua/plenary.nvim',

    'nvim-telescope/telescope.nvim',
  },

  opts = {
    -- Obsidian Vaultのパスを指定
    workspaces = {
      {
        name = 'datascience',
        path = '~/Data Science',
      },
    },

    -- エラーの原因となる古いコマンドを無効化
    legacy_commands = false,

    -- linterは別の lint.lua で管理するため
    diagnostics = {
      disable = { 'markdownlint' },
    },

    -- Telescopeを検索UIとして使用するための設定
    finder = 'Telescope',

    -- completion = {
    --   nvim_cmp = false,
    -- },

    -- デイリーノートを保存するフォルダと形式を指定
    daily_notes = {
      folder = 'Daily', -- フォルダ名に合わせてください
      date_format = '%Y-%m-%d',
    },

    -- ノート間のリンク表示などを綺麗にするための設定 (conceallevelと連携)
    ui = {
      enable = false,
      update_debounce = 200, -- ラグ対策: UI更新の頻度を少し落とす
    },
  },
}
