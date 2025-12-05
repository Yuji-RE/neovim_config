-- keymap setting
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open Oil' })

--
return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    -- netrw の代わりとして常に oil を使う
    default_file_explorer = true,

    -- 左にアイコン表示（mini.icons 使ってるのでOK）
    columns = { 'icon' },

    -- ドットファイルも見たいなら true 推奨
    view_options = {
      show_hidden = true,
      natural_order = 'fast',
    },

    -- 「単純な操作（新規ファイルとか）」のとき確認ダイアログを省略
    skip_confirm_for_simple_edits = true,

    -- 間違えて rm したとき怖いので、ゴミ箱に送るようにする（環境による）
    delete_to_trash = true,

    -- 既定マッピングはとりあえず全部オンでOK
    use_default_keymaps = true,
  },
  -- Optional dependencies
  dependencies = { { 'nvim-mini/mini.icons', opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}
