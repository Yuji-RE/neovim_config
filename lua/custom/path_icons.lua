-- ~/.config/nvim/lua/custom/path_icons.lua
local M = {}

-- 好きなルールをここに追加していく
M.path_rules = {
  { pattern = '/data_analysis_projects/', hl = 'MyIconData' },
  { pattern = '/dotfiles/', hl = 'MyIconDotfiles' },
  { pattern = '/obsidian/', hl = 'MyIconNotes' },
}

-- パスからハイライトを選ぶ共通関数
function M.hl_for_path(path, default_hl)
  for _, rule in ipairs(M.path_rules) do
    if path:find(rule.pattern, 1, true) then
      return rule.hl
    end
  end
  return default_hl
end

-- mini.icons と組み合わせて、statusline 用アイコン文字列を返す
function M.statusline_icon()
  local icons = require 'mini.icons'
  local bufname = vim.api.nvim_buf_get_name(0)
  if bufname == '' then
    return ''
  end

  local icon, default_hl = icons.get('file', bufname)
  local path = vim.fn.fnamemodify(bufname, ':p')

  local hl = M.hl_for_path(path, default_hl or 'MiniIconsYellow')
  return string.format('%%#%s#%s%%*', hl, icon)
end

return M
