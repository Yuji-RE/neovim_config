-- キーマップを簡単に設定するためのヘルパー関数
-- これにより、毎回 vim.keymap.set と長く書く必要がなくなる
local map = function(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- =============================================================================
-- グローバル設定
-- =============================================================================
-- リーダーキーをスペースに設定
-- <leader> は多くのプラグインで使われるカスタムキーの起点
-- これにより、<Space>w で保存、<Space>f で検索、などが可能になる
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- ==============================================================================
-- ノーマルモードのキーマップ
-- ==============================================================================

-- ウィンドウ操作
map('n', '<leader>wv', '<C-w>v') -- 垂直分割
map('n', '<leader>wh', '<C-w>s') -- 水平分割
map('n', '<C-h>', '<C-w>h') -- 左のウィンドウへ移動
map('n', '<C-j>', '<C-w>j') -- 下のウィンドウへ移動
map('n', '<C-k>', '<C-w>k') -- 上のウィンドウへ移動
map('n', '<C-l>', '<C-w>l') -- 右のウィンドウへ移動

-- ファイル保存
map('n', '<leader>w', ':w<CR>') -- 保存
map('n', '<leader>q', ':q<CR>') -- 閉じる

-- ==============================================================================
-- プラグイン関連のキーマップ
-- ==============================================================================

-- ==============================================================================
-- ここに、モード(n, i, v)ごとに設定を追加していく
-- 'n': ノーマルモード
-- 'i': インサートモード
-- 'v': ビジュアルモード
-- ==============================================================================

-- ==============================================================================
-- Jupytext 用ショートカット
-- ==============================================================================

--  下にコードセル (# %%) を作る
--  # %%
--  |      ← カーソル
--  <空白>
map('n', '<leader>cd', function()
  local row = vim.api.nvim_win_get_cursor(0)[1] -- 1-based

  vim.api.nvim_buf_set_lines(0, row, row, false, {
    '# %%',
    '', -- カーソルが来る行
    '', -- セルの下の空白行
  })

  -- 追加後:
  -- row+1: "# %%"
  -- row+2: ""   ← ここにカーソル
  -- row+3: ""   (空白)
  vim.api.nvim_win_set_cursor(0, { row + 2, 0 })
  vim.cmd 'startinsert'
end, {
  desc = 'Insert Jupytext code cell (below, spaced)',
})

--  上にコードセル (# %%) を作る（インデント無視でトップレベルに追加）
map('n', '<leader>cu', function()
  local row = vim.api.nvim_win_get_cursor(0)[1]

  vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, {
    '# %%',
    '',
    '',
  })

  vim.api.nvim_win_set_cursor(0, { row + 1, 0 })
  vim.cmd 'startinsert'
end, {
  desc = 'Insert Jupytext code cell (above, spaced)',
})

--  下にマークダウンセルを作る
--  # %% [markdown]
--  """
--  |      ← カーソル
--  <空白>
--  """
map('n', '<leader>mdd', function()
  local row = vim.api.nvim_win_get_cursor(0)[1]

  vim.api.nvim_buf_set_lines(0, row, row, false, {
    '# %% [markdown]',
    '"""',
    '', -- カーソルが来る行
    '', -- カーソルの下の空白行
    '"""',
  })

  vim.api.nvim_win_set_cursor(0, { row + 3, 0 })
  vim.cmd 'startinsert'
end, {
  desc = 'Insert Jupytext markdown cell (below, spaced)',
})

--  上にマークダウンセルを作る
map('n', '<leader>mdu', function()
  local row = vim.api.nvim_win_get_cursor(0)[1]

  vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, {
    '# %% [markdown]',
    '"""',
    '',
    '',
    '"""',
  })

  vim.api.nvim_win_set_cursor(0, { row + 2, 0 })
  vim.cmd 'startinsert'
end, {
  desc = 'Insert Jupytext markdown cell (above, spaced)',
})
