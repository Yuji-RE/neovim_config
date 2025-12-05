-- this will be activated via `init.lua`

local M = {}

local default_config = {
  enabled = true,
  filetypes = { 'python' },
  cell_pattern = '^# %%%%.*$',

  -- 幅の設定（半角文字数換算）
  code_width = 88,
  markdown_width = 125, -- かな65文字分

  left_col = 2,

  -- ハイライトグループ名の設定（分けて定義）
  code_border_hl = 'JupyCellBorderCode',
  markdown_border_hl = 'JupyCellBorderMd',

  use_top_border = true,
  use_bottom_border = true,
  draw_vertical = true,
}

M.config = vim.deepcopy(default_config)

local ns = vim.api.nvim_create_namespace 'jupy_cells'

local function is_ft_enabled(bufnr)
  local cfg = M.config
  if not cfg.enabled then
    return false
  end
  local ft = vim.bo[bufnr].filetype
  for _, f in ipairs(cfg.filetypes or {}) do
    if f == ft then
      return true
    end
  end
  return false
end

local function collect_cell_ranges(lines, pattern)
  local starts = {}
  for i, line in ipairs(lines) do
    if line:match(pattern) then
      local is_md = (line:match '%[markdown%]' ~= nil)
      table.insert(starts, { row = i - 1, is_markdown = is_md })
    end
  end

  if #starts == 0 then
    return {}
  end

  local ranges = {}
  local last_line = #lines - 1

  for idx, item in ipairs(starts) do
    local start_row = item.row
    local next_item = starts[idx + 1]
    local end_row = next_item and (next_item.row - 1) or last_line

    table.insert(ranges, {
      start_row = start_row,
      end_row = end_row,
      is_markdown = item.is_markdown,
    })
  end

  return ranges
end

local function can_use_fixed_col()
  return vim.fn.has 'nvim-0.10' == 1
end

function M.update(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if not is_ft_enabled(bufnr) then
    vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
    return
  end

  local cfg = M.config
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  if not lines or #lines == 0 then
    vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
    return
  end

  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

  local ranges = collect_cell_ranges(lines, cfg.cell_pattern or default_config.cell_pattern)
  if #ranges == 0 then
    return
  end

  local have_fixed_col = can_use_fixed_col()
  local left_col = cfg.left_col or 0
  local pad = string.rep(' ', left_col)
  local dash = '─'

  for _, range in ipairs(ranges) do
    -- 幅とハイライトグループの切り替え
    local width, hl_group
    if range.is_markdown then
      width = cfg.markdown_width
      hl_group = cfg.markdown_border_hl
    else
      width = cfg.code_width
      hl_group = cfg.code_border_hl
    end

    if width < 2 then
      width = 2
    end

    -- 横線の作成
    local inner_len = width - 1
    local line_body = string.rep(dash, inner_len)

    local top_line_text = pad .. line_body .. '╮'
    local bot_line_text = pad .. line_body .. '╯'

    -- ■ 上枠
    if cfg.use_top_border then
      vim.api.nvim_buf_set_extmark(bufnr, ns, range.start_row, 0, {
        virt_lines = { { { top_line_text, hl_group } } },
        virt_lines_above = true,
        priority = 200,
      })
    end

    -- ■ 下枠
    if cfg.use_bottom_border then
      vim.api.nvim_buf_set_extmark(bufnr, ns, range.end_row, 0, {
        virt_lines = { { { bot_line_text, hl_group } } },
        virt_lines_above = false,
        priority = 200,
      })
    end

    -- ■ 右縦枠
    if cfg.draw_vertical and have_fixed_col then
      local right_border_col = left_col + width - 1
      for row = range.start_row, range.end_row do
        vim.api.nvim_buf_set_extmark(bufnr, ns, row, 0, {
          virt_text = { { '╎', hl_group } },
          virt_text_win_col = right_border_col,
          priority = 200,
          hl_mode = 'combine',
        })
      end
    end
  end
end

function M.setup(opts)
  M.config = vim.tbl_deep_extend('force', default_config, opts or {})

  -- ■ 色のデフォルト設定（お好みでここで調整可能）
  pcall(function()
    -- コードセル用の色（少し明るめ＝少し太く見える）
    vim.api.nvim_set_hl(0, M.config.code_border_hl, {
      fg = '#554e44',
      bg = 'NONE',
      nocombine = true,
    })

    -- Markdownセル用の色（少し暗め＝薄く見える、あるいは青っぽくするなど）
    vim.api.nvim_set_hl(0, M.config.markdown_border_hl, {
      fg = '#444455', -- ちょっと青みがかった暗いグレー
      bg = 'NONE',
      nocombine = true,
    })
  end)

  local group = vim.api.nvim_create_augroup('JupyCellsAugroup', { clear = true })
  local update_fn = function(args)
    if is_ft_enabled(args.buf) then
      M.update(args.buf)
    end
  end

  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter', 'TextChanged', 'TextChangedI' }, {
    group = group,
    callback = update_fn,
  })

  vim.api.nvim_create_autocmd('WinResized', {
    group = group,
    callback = function()
      local b = vim.api.nvim_get_current_buf()
      if is_ft_enabled(b) then
        M.update(b)
      end
    end,
  })
end

return M
