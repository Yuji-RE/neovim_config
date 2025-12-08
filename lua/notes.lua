-- -- init.luaで読み込むためのモジュール

-- =========================
-- 既存コードそのまま：基本のパス
-- =========================
local function get_notes_path()
  local bufname = vim.api.nvim_buf_get_name(0)
  if bufname == '' then
    vim.notify('まだこのバッファにはファイル名がないよ', vim.log.levels.WARN)
    return nil
  end

  local dir = vim.fn.fnamemodify(bufname, ':h')
  local base = vim.fn.fnamemodify(bufname, ':t:r')
  return dir .. '/' .. base .. '_notes.md'
end

-- =========================
-- 追加: 新規ノート用のユニークなファイル名
--   foo_notes_01.md, 02, 03, ...
-- =========================
local function get_new_notes_path()
  local bufname = vim.api.nvim_buf_get_name(0)
  if bufname == '' then
    vim.notify('まだこのバッファにはファイル名がないよ', vim.log.levels.WARN)
    return nil
  end

  local dir = vim.fn.fnamemodify(bufname, ':h')
  local base = vim.fn.fnamemodify(bufname, ':t:r')

  local idx = 1
  while true do
    local candidate = string.format('%s/%s_notes_%02d.md', dir, base, idx)
    if vim.fn.filereadable(candidate) == 0 then
      return candidate
    end
    idx = idx + 1
  end
end

-- =========================
-- 追加: このファイルに紐づく既存ノート一覧を取得
-- =========================
local function list_existing_notes()
  local bufname = vim.api.nvim_buf_get_name(0)
  if bufname == '' then
    return {}
  end

  local dir = vim.fn.fnamemodify(bufname, ':h')
  local base = vim.fn.fnamemodify(bufname, ':t:r')

  -- foo_notes*.md を全部拾う
  local pattern = base .. '_notes*.md'
  local files = vim.fn.globpath(dir, pattern, false, true) -- list
  table.sort(files)
  return files
end

-- =========================
-- 既存のウィンドウ設定関数（そのまま）
-- =========================
local function setup_notes_window(win)
  local buf = vim.api.nvim_win_get_buf(win)
  vim.bo[buf].filetype = 'markdown'

  vim.wo[win].wrap = true
  vim.wo[win].linebreak = true
  vim.wo[win].number = false
  vim.wo[win].relativenumber = false
  vim.wo[win].signcolumn = 'no'
end

-- =========================
-- 既存どおり: デフォルトノートを開く vsplit
-- =========================
local function open_notes_vsplit()
  local notes_path = get_notes_path()
  if not notes_path then
    return
  end
  vim.cmd('vsplit ' .. vim.fn.fnameescape(notes_path))
  vim.cmd 'vertical resize 60'
  local win = vim.api.nvim_get_current_win()
  setup_notes_window(win)
end

-- =========================
-- 既存どおり: hsplit / float
-- =========================
local function open_notes_hsplit()
  local notes_path = get_notes_path()
  if not notes_path then
    return
  end
  vim.cmd('split ' .. vim.fn.fnameescape(notes_path))
  vim.cmd 'resize 10'
  local win = vim.api.nvim_get_current_win()
  setup_notes_window(win)
end

local function open_notes_float()
  local notes_path = get_notes_path()
  if not notes_path then
    return
  end

  local buf = vim.fn.bufadd(notes_path)
  vim.fn.bufload(buf)

  local columns = vim.o.columns
  local lines = vim.o.lines

  local width = math.floor(columns * 0.6)
  local height = math.floor(lines * 0.4)
  local row = math.floor((lines - height) / 2)
  local col = math.floor((columns - width) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    row = row,
    col = col,
    width = width,
    height = height,
    style = 'minimal',
    border = 'rounded',
  })

  setup_notes_window(win)
end

-- =========================
-- ★追加: 新規ノートを必ず作る vsplit
-- =========================
local function open_new_notes_vsplit()
  local notes_path = get_new_notes_path()
  if not notes_path then
    return
  end
  vim.cmd('vsplit ' .. vim.fn.fnameescape(notes_path))
  vim.cmd 'vertical resize 60'
  local win = vim.api.nvim_get_current_win()
  setup_notes_window(win)
end

-- =========================
-- ★追加: 新規ノートを必ず作る float  ← ★ここを select_... の「外」に出す
-- =========================
local function open_new_notes_float()
  local notes_path = get_new_notes_path()
  if not notes_path then
    return
  end

  local buf = vim.fn.bufadd(notes_path)
  vim.fn.bufload(buf)

  local columns = vim.o.columns
  local lines = vim.o.lines

  local width = math.floor(columns * 0.6)
  local height = math.floor(lines * 0.4)
  local row = math.floor((lines - height) / 2)
  local col = math.floor((columns - width) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    row = row,
    col = col,
    width = width,
    height = height,
    style = 'minimal',
    border = 'rounded',
  })

  setup_notes_window(win)
end

-- =========================
-- ★既存 or 新規を選んで vsplit で開く
-- =========================
local function select_or_new_notes_vsplit()
  local existing = list_existing_notes()
  local items = {}

  table.insert(items, { label = '[New note]', path = nil })

  for _, path in ipairs(existing) do
    table.insert(items, {
      label = vim.fn.fnamemodify(path, ':t'),
      path = path,
    })
  end

  if #items == 1 then
    open_new_notes_vsplit()
    return
  end

  vim.ui.select(items, {
    prompt = 'Which note？',
    format_item = function(item)
      return item.label
    end,
  }, function(choice)
    if not choice then
      return
    end

    local path = choice.path
    if not path then
      path = get_new_notes_path()
    end

    vim.cmd('vsplit ' .. vim.fn.fnameescape(path))
    vim.cmd 'vertical resize 60'
    local win = vim.api.nvim_get_current_win()
    setup_notes_window(win)
  end)
end

-- =========================
-- キーマップ
-- =========================
vim.keymap.set('n', '<leader>nv', open_notes_vsplit, { desc = 'Open notes (vsplit, default)' })
vim.keymap.set('n', '<leader>NV', select_or_new_notes_vsplit, { desc = 'Select or new notes (vsplit)' })
vim.keymap.set('n', '<leader>nh', open_notes_hsplit, { desc = 'Open notes (hsplit)' })
vim.keymap.set('n', '<leader>nf', open_notes_float, { desc = 'Open notes (float, default)' })

-- 新規ノートを即作る（float）
vim.keymap.set('n', '<leader>nn', open_new_notes_float, { desc = 'Open NEW notes (float)' })

--
-- local function get_notes_path()
--   local bufname = vim.api.nvim_buf_get_name(0)
--   if bufname == '' then
--     vim.notify('まだこのバッファにはファイル名がないよ', vim.log.levels.WARN)
--     return nil
--   end
--
--   local dir = vim.fn.fnamemodify(bufname, ':h')
--   local base = vim.fn.fnamemodify(bufname, ':t:r')
--   return dir .. '/' .. base .. '_notes.md'
-- end
--
-- local function setup_notes_window(win)
--   local buf = vim.api.nvim_win_get_buf(win)
--   vim.bo[buf].filetype = 'markdown'
--
--   vim.wo[win].wrap = true
--   vim.wo[win].linebreak = true
--   vim.wo[win].number = false
--   vim.wo[win].relativenumber = false
--   vim.wo[win].signcolumn = 'no'
-- end
--
-- local function open_notes_vsplit()
--   local notes_path = get_notes_path()
--   if not notes_path then
--     return
--   end
--   vim.cmd('vsplit ' .. vim.fn.fnameescape(notes_path))
--   vim.cmd 'vertical resize 60'
--   local win = vim.api.nvim_get_current_win()
--   setup_notes_window(win)
-- end
--
-- local function open_notes_hsplit()
--   local notes_path = get_notes_path()
--   if not notes_path then
--     return
--   end
--   vim.cmd('split ' .. vim.fn.fnameescape(notes_path))
--   vim.cmd 'resize 10'
--   local win = vim.api.nvim_get_current_win()
--   setup_notes_window(win)
-- end
--
-- local function open_notes_float()
--   local notes_path = get_notes_path()
--   if not notes_path then
--     return
--   end
--
--   local buf = vim.fn.bufadd(notes_path)
--   vim.fn.bufload(buf)
--
--   local columns = vim.o.columns
--   local lines = vim.o.lines
--
--   local width = math.floor(columns * 0.6)
--   local height = math.floor(lines * 0.4)
--   local row = math.floor((lines - height) / 2)
--   local col = math.floor((columns - width) / 2)
--
--   local win = vim.api.nvim_open_win(buf, true, {
--     relative = 'editor',
--     row = row,
--     col = col,
--     width = width,
--     height = height,
--     style = 'minimal',
--     border = 'rounded',
--   })
--
--   setup_notes_window(win)
-- end
--
-- -- キーマップ
-- vim.keymap.set('n', '<leader>nv', open_notes_vsplit, { desc = 'Open notes (vsplit)' })
-- vim.keymap.set('n', '<leader>nh', open_notes_hsplit, { desc = 'Open notes (hsplit)' })
-- vim.keymap.set('n', '<leader>nf', open_notes_float, { desc = 'Open notes (float)' })
