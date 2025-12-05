-- init.luaで読み込むためのモジュール

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

local function setup_notes_window(win)
  local buf = vim.api.nvim_win_get_buf(win)
  vim.bo[buf].filetype = 'markdown'

  vim.wo[win].wrap = true
  vim.wo[win].linebreak = true
  vim.wo[win].number = false
  vim.wo[win].relativenumber = false
  vim.wo[win].signcolumn = 'no'
end

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

-- キーマップ
vim.keymap.set('n', '<leader>nv', open_notes_vsplit, { desc = 'Open notes (vsplit)' })
vim.keymap.set('n', '<leader>nh', open_notes_hsplit, { desc = 'Open notes (hsplit)' })
vim.keymap.set('n', '<leader>nf', open_notes_float, { desc = 'Open notes (float)' })
