--return {
--  {
--    'bluz71/vim-moonfly-colors',
--    name = 'moonfly',
--    lazy = false, -- 起動時に必ず読み込む
--    priority = 1000, -- 色を一番先に適用
--    config = function()
--      -- ここから Moonfly のオプション
--      -- 真っ黒背景にしたい場合は方法が2つあります。おすすめは(1)です。
--
--      -- (1) 透明背景にして、ターミナルの背景色（黒）を使う
--      --    → ターミナルのテーマ背景を黒にしている前提
--      vim.g.moonflyTransparent = true
--
--      -- (2) 透明は嫌で「エディタ側を濃い黒」に寄せたい場合
--      --    → 透明を使わず、ポップアップ等も暗めに寄せる
--      -- コメントアウトを外して試してみてください（好みで）
--      --vim.g.moonflyTransparent = true
--      vim.g.moonflyNormalFloat = true -- フロート背景を通常背景に揃える
--      vim.g.moonflyWinSeparator = 2 -- ウィンドウ境界線の色を強めに
--
--      -- 装飾の好み（任意）
--      vim.g.moonflyItalics = false -- イタリック無効
--      vim.g.moonflyUnderlineMatchParen = true
--      vim.g.moonflyCursorColor = true
--
--      -- 24bitカラー推奨
--      vim.o.termguicolors = true
--
--      -- Moonfly を有効化
--      vim.cmd.colorscheme 'moonfly'
--
--      -- 透明を使う場合、必要に応じてハイライトを完全透過に
--      if vim.g.moonflyTransparent then
--        vim.cmd [[
--          highlight Normal       ctermbg=NONE guibg=NONE
--          highlight NormalFloat  ctermbg=NONE guibg=NONE
--          highlight SignColumn   ctermbg=NONE guibg=NONE
--        ]]
--      end
--    end,
--  },
--}
-------------------------------------------------------------------------------------------------------

-- black metal color theme

-- return {
--   {
--     'metalelf0/black-metal-theme-neovim',
--     lazy = false,
--     priority = 1000,
--     config = function()
--       -- True colorを有効化（透明化の前提）
--       vim.opt.termguicolors = true
--
--       -- あなたの既存設定（中身はそのままでOK）
--       require('black-metal').setup {
--         theme = 'marduk',
--         variant = 'light',
--         favor_treesitter_hl = true,
--         alt_bg = true,
--         term_colors = true,
--         colors = {
--           accent1 = '#d97171',
--           accent2 = '#913327',
--           type_fg = '#9c5a86',
--           var_fg = '#f5d7c9',
--           dimbg = '#a32502',
--           bracket = '#e07253',
--           match_fg = '#c70491',
--         },
--         highlights = {
--           ['@keyword'] = { fg = '$accent1', fmt = 'italic' },
--           ['@function'] = { fg = '$accent2', fmt = 'italic' },
--           ['@type'] = { fg = '$type_fg', fmt = 'italic' },
--           ['@type.builtin'] = { fg = '#87874d', fmt = 'italic' },
--           ['@variable'] = { fg = '$var_fg', fmt = 'italic' },
--           ['@variable.parameter'] = { fg = '#257f8f', fmt = 'italic' },
--           ['@variable.builtin'] = { fg = '#cced26', fmt = 'italic' },
--           --['@punctuation.bracket'] = { fg = '#6a9190' },
--           ['@punctuation.delimiter'] = { fg = '$bracket' },
--           Comment = { fg = '#4d3d4b', fmt = 'italic' },
--           MatchParen = { fg = '$match_fg', fmt = 'bold' },
--         },
--       }
--       require('black-metal').load()
--       -- 括弧タイプ別の色（好みで変更OK）
--       local colors = {
--         paren = '#739994', -- ()
--         bracket = '#e07253', -- []
--         brace = '#c4cf80', -- {}
--       }
--
--       -- ハイライトグループ定義（色は上の colors を使用）
--       vim.api.nvim_set_hl(0, 'ParenColor', { fg = colors.paren })
--       vim.api.nvim_set_hl(0, 'BracketColor', { fg = colors.bracket })
--       vim.api.nvim_set_hl(0, 'BraceColor', { fg = colors.brace })
--
--       -- 今いるウィンドウにマッチを張り直す関数
--       local function apply_bracket_matches()
--         -- 既存のマッチを削除
--         if vim.w._bracket_match_ids then
--           for _, id in ipairs(vim.w._bracket_match_ids) do
--             pcall(vim.fn.matchdelete, id)
--           end
--         end
--         -- それぞれの括弧を1行パターンでハイライト
--         vim.w._bracket_match_ids = {
--           vim.fn.matchadd('ParenColor', '[()]'), -- ( または )
--           vim.fn.matchadd('BracketColor', '[\\[\\]]'), -- [ または ]
--           vim.fn.matchadd('BraceColor', '[{}]'), -- { または }
--         }
--       end
--
--       -- 起動直後 / 色変更時 / 新しいウィンドウ/バッファでも適用
--       vim.api.nvim_create_autocmd({ 'VimEnter', 'ColorScheme', 'WinEnter', 'BufWinEnter' }, {
--         callback = apply_bracket_matches,
--       })
--       -- ここから「透明化」上書き
--       local transparent_groups = {
--         'Normal',
--         'NormalNC',
--         'NormalFloat',
--         'FloatBorder',
--         'SignColumn',
--         'EndOfBuffer',
--         'LineNr',
--         --'CursorLine',
--         --'CursorLineNr',
--         'Folded',
--         'NonText',
--         'StatusLine',
--         'StatusLineNC',
--         --'TabLine',
--         'TabLineFill',
--         'Pmenu',
--         'PmenuSel',
--         'PmenuSbar',
--         'PmenuThumb',
--         'DiagnosticFloatingError',
--         'DiagnosticFloatingWarn',
--         'DiagnosticFloatingInfo',
--         'DiagnosticFloatingHint',
--         -- よく使うプラグイン系（必要なければ削ってOK）
--         'TelescopeNormal',
--         'TelescopeBorder',
--         'NvimTreeNormal',
--         'NeoTreeNormal',
--         'NeoTreeNormalNC',
--         'MsArea',
--         'MsSeparator',
--       }
--       for _, g in ipairs(transparent_groups) do
--         -- bgを"none"に（ctermbgも気になる場合は追加で消せます）
--         pcall(vim.api.nvim_set_hl, 0, g, { bg = 'none' })
--       end
--
--       -- カラースキームを切り替えた時も再適用
--       vim.api.nvim_create_autocmd('ColorScheme', {
--         pattern = '*',
--         callback = function()
--           for _, g in ipairs(transparent_groups) do
--             pcall(vim.api.nvim_set_hl, 0, g, { bg = 'none' })
--           end
--
--           vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'none', ctermbg = 'none' })
--           vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = 'none', ctermbg = 'none' })
--           vim.api.nvim_set_hl(0, 'MsgArea', { bg = 'none', ctermbg = 'none' })
--           vim.api.nvim_set_hl(0, 'MsgSeparator', { bg = 'none', ctermbg = 'none' })
--         end,
--       })
--     end,
--   },
-- }
------------------------------------------------------------------------------------------------

return {
  {
    -- プラグインとしてダウンロードせず、ローカル設定として読み込ませるためのダミー定義
    name = 'my-custom-marduk',
    dir = '.',
    lazy = false,
    priority = 1000,
    config = function()
      -- 1. 基本設定
      vim.opt.termguicolors = true
      vim.g.colors_name = 'my-marduk'

      -- ★ここを追加・変更: 縦横のカーソルラインを有効化
      vim.opt.cursorline = false
      vim.opt.cursorcolumn = false

      -- 下の情報バーを最下層に配置し画面を最大化
      vim.opt.laststatus = 3
      vim.opt.cmdheight = 0
      -- borderを設定
      vim.opt.winborder = 'rounded'
      -- 2. あなたの定義したカラーパレット
      local p = {
        accent1 = '#d97171', -- Keyword
        accent2 = '#913327', -- Function
        type_fg = '#9c5a86', -- Type
        var_fg = '#f5d7c9', -- Variable
        dimbg = '#a32502', -- Background accent
        bracket = '#c70c92', -- Bracket
        match_fg = '#07fa50', -- MatchParen

        fg = '#999c9e', -- 基本文字色
        bg = '#0d0847', -- 非透明時の背景色
        string = '#aaa9ab', -- 文字列
        comment = '#4d3d4b', -- コメント

        -- ★追加: カーソルライン用の「極めて薄い」色
        -- 完全な透明(None)にすると線が見えなくなるため、
        -- 背景(#121212)より「ほんの少しだけ明るい/赤い」色にします。
        -- お好みで調整してください: '#1a1a1a'(より暗く) ～ '#2d2222'(もう少し赤く)
        -- cursor_bg = '#b53721',
      }
      vim.api.nvim_set_hl(0, '@jupytest', { fg = '#ff0000', bold = true })
      -- 3. ハイライトグループの適用関数
      local function set_hl(group, opts)
        vim.api.nvim_set_hl(0, group, opts)
      end

      -- 画面をリセット
      vim.cmd 'hi clear'
      if vim.fn.exists 'syntax_on' then
        vim.cmd 'syntax reset'
      end

      -- =========================================
      -- ベースハイライト定義
      -- =========================================
      set_hl('Normal', { fg = p.fg, bg = 'NONE' })
      set_hl('NormalNC', { link = 'Normal' })
      set_hl('SignColumn', { bg = 'NONE' })
      set_hl('EndOfBuffer', { fg = p.dimbg, bg = 'NONE' })
      set_hl('Cursor', { bg = '#ffe600', fg = '#222222' })
      -- 構文ハイライト
      set_hl('@keyword', { fg = p.accent1, italic = true })
      set_hl('@function', { fg = p.accent2, italic = true })
      set_hl('@type', { fg = p.type_fg, italic = true })
      set_hl('@type.builtin', { fg = '#87874d', italic = true })
      set_hl('@variable', { fg = p.var_fg, italic = true })
      set_hl('@variable.parameter', { fg = '#207685', italic = true })
      set_hl('@variable.builtin', { fg = '#cced26', italic = true })
      set_hl('@punctuation.delimiter', { fg = p.bracket })
      set_hl('Comment', { fg = p.comment, italic = true })
      set_hl('MatchParen', { fg = '#07fa50', bg = 'NONE', bold = true })

      set_hl('String', { fg = p.string, italic = true })
      set_hl('Constant', { fg = p.accent1 })
      set_hl('Number', { fg = p.bracket })
      -- set_hl('PreProc', { fg = p.type_fg })
      -- set_hl('Operator', { fg = '#79d4c4' })

      -- ★追加: カーソルラインとカーソルカラムの色設定
      -- bg='NONE'にすると線が消えてしまうため、先ほど定義した極薄の色を使います
      --set_hl('CursorLine', { bg = p.cursor_bg })
      --set_hl('CursorColumn', { bg = p.cursor_bg })
      -- 行番号（カーソルがある行）を目立たせる場合
      set_hl('CursorLineNr', { fg = p.accent1, bold = true, bg = 'NONE' })

      -- =========================================
      -- エラー・警告・診断メッセージの色設定
      -- =========================================

      -- 1. エラー (Error) - 重大な問題
      --    fg: 文字色, bg: 背景色 (NONE推奨), sp: 下線の色
      set_hl('DiagnosticError', { fg = '#db4b4b' }) -- 基本色
      set_hl('DiagnosticSignError', { fg = '#db4b4b', bg = 'NONE' }) -- 左端のアイコン
      set_hl('DiagnosticUnderlineError', { sp = '#db4b4b', undercurl = true }) -- 波線の下線
      set_hl('DiagnosticVirtualTextError', { fg = '#db4b4b', bg = 'NONE' }) -- 行末のメッセージ

      -- 2. 警告 (Warn) - 注意喚起
      set_hl('DiagnosticWarn', { fg = '#5e5ed1' })
      set_hl('DiagnosticSignWarn', { fg = '#a86ec4', bg = 'NONE' })
      set_hl('DiagnosticUnderlineWarn', { sp = '#a86ec4', undercurl = true })
      set_hl('DiagnosticVirtualTextWarn', { fg = '#a86ec4', bg = 'NONE' })

      -- 3. 情報 (Info) - 参考情報
      set_hl('DiagnosticInfo', { fg = '#0db9d7' })
      set_hl('DiagnosticSignInfo', { fg = '#0db9d7', bg = 'NONE' })
      set_hl('DiagnosticUnderlineInfo', { sp = '#0db9d7', undercurl = true })
      set_hl('DiagnosticVirtualTextInfo', { fg = '#0db9d7', bg = 'NONE' })

      -- 4. ヒント (Hint) - 提案など
      set_hl('DiagnosticHint', { fg = '#1abc9c' })
      set_hl('DiagnosticSignHint', { fg = '#1abc9c', bg = 'NONE' })
      set_hl('DiagnosticUnderlineHint', { sp = '#1abc9c', undercurl = true })
      set_hl('DiagnosticVirtualTextHint', { fg = '#1abc9c', bg = 'NONE' })

      -- =========================================
      -- 括弧の色分けロジック
      -- =========================================
      local colors = {
        paren = '#6a9190',
        bracket = '#e07253',
        brace = '#cfba1b',
      }
      set_hl('ParenColor', { fg = colors.paren })
      set_hl('BracketColor', { fg = colors.bracket })
      set_hl('BraceColor', { fg = colors.brace })

      local function apply_bracket_matches()
        if vim.w._bracket_match_ids then
          for _, id in ipairs(vim.w._bracket_match_ids) do
            pcall(vim.fn.matchdelete, id)
          end
        end
        vim.w._bracket_match_ids = {
          vim.fn.matchadd('ParenColor', '[()]'),
          vim.fn.matchadd('BracketColor', '[\\[\\]]'),
          vim.fn.matchadd('BraceColor', '[{}]'),
          -- vim.fn.matchadd('QuoteColor1', "[']"),
          -- ★ 単語境界にある ' だけハイライト
          vim.fn.matchadd('QuoteColor1', [[\%(^\|\s\|\W\)\zs'\ze\S]]),
          vim.fn.matchadd('QuoteColor1', [[\S\zs'\ze\%($\|\s\|\W\)]]),
          -- vim.fn.matchadd('QuoteColor1', [[\%(^\|\s\|\W\)\zs'\ze\w]]),
          -- vim.fn.matchadd('QuoteColor1', [[\w\zs'\ze\%($\|\s\|\W\)]]),
          vim.fn.matchadd('QuoteColor2', '["]'),
        }
      end

      vim.api.nvim_create_autocmd({ 'VimEnter', 'ColorScheme', 'WinEnter', 'BufWinEnter' }, {
        callback = apply_bracket_matches,
      })
      -- vim.api.nvim_create_autocmd('FileType', {
      --   pattern = 'python',207
      --   callback = function()
      --     vim.api.nvim_set_hl(0, '@string.documentation', { fg = '#6b6734', italic = true })
      --   end,
      -- })
      -- =========================================
      -- 透明化設定
      -- =========================================
      local transparent_groups = {
        'Folded',
        -- 'NonText',
        --'LineNr',
        'SignColumn',
        'StatusLine',
        'StatusLineNC',
        --'Pmenu',
        --'PmenuSel',
        --'PmenuSbar',
        --'PmenuThumb',
        'DiagnosticFloatingError',
        'DiagnosticFloatingWarn',
        'DiagnosticFloatingInfo',
        'DiagnosticFloatingHint',
        'TelescopeNormal',
        'TelescopeBorder',
        'NvimTreeNormal',
        'NeoTreeNormal',
        'NeoTreeNormalNC',
        'MsgArea',
        --'MsgSeparator',
        -- 注意: ここに 'CursorLine' や 'CursorColumn' を入れてしまうと、
        -- せっかく設定した色が消えて透明(見えない状態)になるので入れないこと！
      }

      -- =========================================
      -- ポップアップメニュー（補完候補など）の設定
      -- =========================================

      -- 1. 枠線の色 (★ここが重要)
      --    fgを白にすることで、透明なウィンドウに白い枠がつきます
      set_hl('FloatBorder', { fg = '#9088d1', bg = 'NONE' })

      -- 2. 補完メニューのリスト（通常時）
      --    背景は透明のまま、文字色を見やすく
      set_hl('Pmenu', { fg = '#a3bf34', bg = 'NONE' })

      -- 3. 補完メニューの「選択中」の行
      --    ここも透明(bg=NONE)だとどれを選んでるかわかりにくいので、
      --    「薄いグレーの背景」をつけるか、「文字を太字+白」にするのがおすすめです。
      --    (以下の例は、背景を少しだけ明るくして選択感を出すパターン)
      set_hl('PmenuSel', { bg = '#496370' })
      --set_hl('PmenuSbar', { fg = '#b83030' })
      --set_hl('PmenuSbar', { bg = '#b83030' })
      -- 4. ドキュメント表示（関数の説明などが浮いて出るやつ）の本体
      set_hl('NormalFloat', { fg = '#9dadc4', bg = 'NONE' })

      -- 5. スクロールバー（もしリストが長いときに出る棒）
      --set_hl('PmenuSbar', { bg = 'NONE' }) -- バーの背景（透明）
      --set_hl('PmenuThumb', { bg = '#ffffff' }) -- つまみ部分（白）

      -- =========================================
      -- mini.starter (Dashboard) の色設定
      -- =========================================

      -- 1. ファイル名・項目名 (一番面積が広い部分)
      -- ここを好きな色に変えれば、黄色い部分はなくなります
      set_hl('MiniStarterItem', { fg = '#656875', bg = 'NONE', italic = true })

      -- 2. ショートカットキー ( [e] や [q] の部分 )
      set_hl('MiniStarterItemPrefix', { fg = '#a6483c' })

      -- 3. セクションのタイトル ( "Recent files", "Sessions" など )
      set_hl('MiniStarterSection', { fg = '#5f5a63', italic = true })

      -- 4.ヘッダー ( アスキーアートやロゴ )
      set_hl('MiniStarterHeader', { fg = '#35363d' })

      -- 5. フッター ( 画面下部のメッセージ )
      set_hl('MiniStarterFooter', { fg = '#a2a3a3' })

      -- 6. 現在選択している行 ( カーソルがある行 )
      --    文字色を変えたり、bg = '#222222' で背景をつけたり自由です
      -- set_hl('MiniStarterCurrent', { bold = true })

      -- 7. 特別なクエリ情報 ( 通常はあまり出ませんが念のため )
      set_hl('MiniStarterQuery', { fg = '#5de8d1' })

      -- =========================================
      -- 数字・演算子の色設定 (直接指定)
      -- =========================================

      -- 1. 数字 ( 100, 3.14, 0xFF など )
      --    整数も小数もまとめて指定します
      set_hl('Number', { fg = '#e6e1f7' })
      set_hl('Float', { fg = '#e6e1f7' })
      set_hl('@number', { link = 'Number' }) -- TreeSitterも連動
      set_hl('@float', { link = 'Float' })

      -- 2. 演算子 ( =, ==, !=, <, >, +, - など )
      --    ここを変えると、等号・不等号の色が変わります
      set_hl('Operator', { fg = '#637094' })
      set_hl('@operator', { link = 'Operator' }) -- TreeSitterも連動

      -- 3. Stringの記号("", '')
      set_hl('QuoteColor2', { fg = '#7b67a3' })
      set_hl('QuoteColor1', { fg = '#6ea367' })

      -- =========================================
      -- ステータスライン (下のバー全体)
      -- =========================================

      -- 1. アクティブなウィンドウのバー (右側に続く部分)
      --    bgをセットすると帯の色になり、bg='NONE'にすると透明になります
      set_hl('StatusLine', { fg = '#637094', bg = '#222222' })

      -- 2. 非アクティブなウィンドウのバー (暗くして目立たなくするのが一般的)
      set_hl('StatusLineNC', { fg = '#666666', bg = '#111111' })

      -- =========================================
      -- モード表示部分 (左下の Normal / Insert 等)
      -- =========================================
      -- ※ mini.statusline を使用している場合の主要設定です

      -- Normalモード (普段の状態) - 落ち着いた色
      set_hl('MiniStatuslineModeNormal', { fg = '#ededed', bg = '#412557' })

      -- Insertモード (入力中) - 目立つ色 (赤や明るい色)
      set_hl('MiniStatuslineModeInsert', { fg = '#ededed', bg = '#412557' })

      -- Visualモード (選択中) - 黄色やオレンジなど
      set_hl('MiniStatuslineModeVisual', { fg = '#451414', bg = '#e09987' })

      -- Replaceモード (置換)
      set_hl('MiniStatuslineModeReplace', { fg = '#121212', bg = '#913327', bold = true })

      -- Commandモード (:)
      set_hl('MiniStatuslineModeCommand', { fg = '#22254f', bg = '#e07253', bold = true })

      -- その他の情報部分 (ファイル名やGit情報など)
      set_hl('MiniStatuslineDevinfo', { fg = '#9dadc4', bg = '#352d3b' }) -- `Git master Diff - LSP`のところ
      --set_hl('MiniStatuslineFilename', { fg = 'NONE', bg = 'NONE' }) -- `~/今いるファイル名`のところ
      set_hl('MiniStatuslineFileinfo', { fg = '#c1f719', bg = 'NONE' }) -- `lua utf-8[unix] ~KiB`のところ

      -- =========================================
      -- (補足) ネイティブのモード表示
      -- =========================================
      -- プラグインを使わず "-- INSERT --" と文字が出るだけの箇所の設定
      set_hl('ModeMsg', { fg = '#d97171', bold = true })
      set_hl('MsgArea', { fg = '#c1f719', bg = '#e07253', bold = true }) -- コマンドラインエリア
      -- (おまけ) ブール値 ( true, false )
      --    数字と同じ色にするか、キーワード色にするかお好みで
      set_hl('Boolean', { fg = '#a4a642' })
      set_hl('@boolean', { link = 'Boolean' })

      -- =========================================
      -- Winbar (ウィンドウ上部の情報バー) の設定
      -- =========================================

      -- 1. Winbarの色設定
      set_hl('WinBar', { fg = '#c1f719', bg = 'NONE' })
      set_hl('WinBarNC', { fg = '#6e729c', bg = 'NONE' }) -- 非アクティブ時

      -- 2. Winbarにファイル名を表示する機能
      vim.opt.winbar = '%=%m %f  '
      -- 解説:
      -- %= : 右寄せにする
      -- %m : 変更があれば [+] を表示
      -- %f : ファイルパスを表示

      -- =========================================
      -- mini.statusline のカスタマイズ
      -- =========================================
      local statusline = require 'mini.statusline'

      -- ステータスラインの表示内容を再定義
      statusline.setup {
        content = {
          -- アクティブなウィンドウの表示内容
          active = function()
            local mode, mode_hl = statusline.section_mode { trunc_width = 120 }
            local git = statusline.section_git { trunc_width = 75 }
            local diff = statusline.section_diff { trunc_width = 75 }
            local diagnostics = statusline.section_diagnostics { trunc_width = 75 }
            -- local lsp           = statusline.section_lsp({ trunc_width = 75 }) -- LSP情報が必要ならコメント解除
            -- local filename      = statusline.section_filename({ trunc_width = 140 }) -- ★ここを消しました
            local fileinfo = statusline.section_fileinfo { trunc_width = 120 }
            local location = statusline.section_location { trunc_width = 75 }

            -- 表示する要素を組み立てて返す
            -- 以前あった filename を外しています
            return statusline.combine_groups {
              { hl = mode_hl, strings = { mode } },
              { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics } },
              { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
              '%<',
              '%=',
              { hl = mode_hl, strings = { location } },
            }
          end,
        },
      }

      -- =========================================
      -- カーソル下の単語の強調 (下線スタイル)
      -- =========================================

      -- bg='NONE' で背景を透明化し、sp(下線色)とunderlineで強調
      set_hl('LspReferenceText', { bg = '#212119', sp = '#a8fc62' })
      set_hl('LspReferenceRead', { bg = '#212619', sp = '#a8fc62' })
      set_hl('LspReferenceWrite', { bg = '#212619', sp = '#a8fc62' })

      ----------------------------------------------------------------------
      -- Telescope ハイライト
      ----------------------------------------------------------------------
      -- 枠線 & タイトル
      -- set_hl('TelescopeBorder', { fg = p.accent2, bg = 'NONE' })
      set_hl('TelescopePromptBorder', { fg = '#5de8d1', bg = 'NONE' })
      set_hl('TelescopeResultsBorder', { fg = '#46536e', bg = 'NONE' })
      set_hl('TelescopePreviewBorder', { fg = '#2d2a38', bg = 'NONE' })

      set_hl('TelescopePromptTitle', { fg = '#5de8d1', bg = 'NONE', bold = true })
      set_hl('TelescopeResultsTitle', { fg = '#41366e', bg = 'NONE', bold = true })
      set_hl('TelescopePreviewTitle', { fg = '#41366e', bg = 'NONE', bold = true })

      -- 検索語にマッチしている部分
      set_hl('TelescopeMatching', { fg = '#5de8d1', bg = 'NONE', bold = true })

      -- 結果リスト文字 & 選択行 & 先頭の ">"
      set_hl('TelescopeResultsNormal', { fg = '#b4b5bf', bg = 'NONE' })
      set_hl('TelescopeSelection', { bg = '#261d26' })
      set_hl('TelescopeSelectionCaret', { fg = '#c1f719', bg = 'NONE' })
      -- 必要ならプロンプト行の色も
      set_hl('TelescopePromptNormal', { fg = '#f5d7c9', bg = 'NONE' })
      set_hl('TelescopePromptPrefix', { fg = '#c1f719', bg = 'NONE' })

      -- set_hl('TelescopePreviewDirectory', { fg = '#c1f719', bold = true })

      -- set_hl('TelescopePathLevel1', { fg = '#7aa2f7' }) -- 例: 青
      -- set_hl('TelescopePathLevel2', { fg = '#9ece6a' }) -- 例: 緑
      -- set_hl('TelescopePathLevel3', { fg = '#e0af68' }) -- 例: オレンジ
      -- set_hl('TelescopePathLevel4', { fg = '#bb9af7' }) -- それ以降も必要なら追加
      -- set_hl('TelescopePathLevel5', { fg = '#c0caf5' })
      -- set_hl('TelescopePathFilename', { fg = '#c0caf5', bold = true })

      set_hl('TelescopePathDirLua', { fg = '#906594' }) -- lua
      set_hl('TelescopePathDirCustom', { fg = '#914071' }) -- custom
      set_hl('TelescopePathDirPlugins', { fg = '#87693e' }) -- plugins
      -- 追加分
      set_hl('TelescopePathDirUser', { fg = '#7a5d5d' }) -- user
      set_hl('TelescopePathDirAfter', { fg = '#f7768e' }) -- after
      set_hl('TelescopePathDirQueries', { fg = '#ff5f5f' }) -- queries
      set_hl('TelescopePathDirConfig', { fg = '#b56b48' }) -- config
      set_hl('TelescopePathDirDoc', { fg = '#7d855f' }) -- doc など
      set_hl('TelescopePathDirSnippets', { fg = '#b5b048' })
      set_hl('TelescopePathDirKickstart', { fg = '#4f7d70' })
      set_hl('TelescopePathDirOther', { fg = '#565f89' }) -- それ以外

      ----------------------------------------------------------------------
      -- which-key (Space 押したときのポップアップ)
      ----------------------------------------------------------------------
      set_hl('WhichKeyBorder', { fg = '#fafdff', bg = 'NONE' })
      set_hl('WhichKeyFloat', { fg = p.fg, bg = 'NONE' }) -- 中身の背景

      set_hl('WhichKey', { fg = p.accent1, bg = 'NONE' }) -- キーそのもの
      set_hl('WhichKeyGroup', { fg = p.type_fg, bg = 'NONE' }) -- グループ名
      set_hl('WhichKeyDesc', { fg = p.string, bg = 'NONE' }) -- 説明テキスト
      set_hl('WhichKeySeparator', { fg = p.comment, bg = 'NONE' })
      set_hl('WhichKeyValue', { fg = p.var_fg, bg = 'NONE' })

      ----------------------------------------------------------------------
      -- render-markdown.nvim 用ハイライト
      -- （デフォルト設定の「RenderMarkdownH1〜」などを上書きするイメージ）
      ----------------------------------------------------------------------

      -- 見出し (君がすでに Treesitter 側で使ってる色に揃えてある)

      -- コードブロック / インラインコード
      set_hl('RenderMarkdownCode', { fg = '#7a2828', bg = 'NONE' })
      set_hl('RenderMarkdownCodeBorder', { bg = 'NONE' })
      set_hl('RenderMarkdownCodeInline', { fg = '#7a2828', bg = 'NONE' })

      -- 引用
      set_hl('RenderMarkdownQuote1', { fg = '#5fafff', bg = 'NONE' })
      -- 必要に応じて 2〜6 まで増やせる
      -- set_hl('RenderMarkdownQuote2', { fg = '#...' })

      -- テーブル
      set_hl('RenderMarkdownTableHead', { fg = p.var_fg, bg = 'NONE', bold = true })
      set_hl('RenderMarkdownTableRow', { fg = p.fg, bg = 'NONE' })

      -- チェックボックス
      set_hl('RenderMarkdownUnchecked', { fg = '#7d997e', bg = 'NONE' })
      set_hl('RenderMarkdownChecked', { fg = '#74fa05', bg = 'NONE' })

      set_hl('RenderMarkdownDash', { fg = '#f23f3f', bg = 'NONE' })
      set_hl('RenderMarkdownBullet', { fg = '#5de8d1', bg = 'NONE' })
      set_hl('RenderMarkdownLink', { fg = '#525432', bg = 'NONE' })

      -- コールアウト (NOTE / WARNING / ERROR / SUCCESS)
      set_hl('RenderMarkdownInfo', { fg = '#5fafff', bg = 'NONE', bold = true })
      set_hl('RenderMarkdownWarn', { fg = '#ffd75f', bg = 'NONE', bold = true })
      set_hl('RenderMarkdownError', { fg = '#ff5f5f', bg = 'NONE', bold = true })
      set_hl('RenderMarkdownSuccess', { fg = '#5fd787', bg = 'NONE', bold = true })

      -- =========================================
      -- markdown の太字 (strong_emphasis) 用カスタム @my_bold
      -- =========================================

      -- 基本となるグループ（markdown / markdown_inline 共通）
      set_hl('@my_bold', {
        fg = '#4e5d66', -- 好きな色に変えてOK
        bold = true,
        bg = 'NONE',
      })

      -- 必要なら markdown_inline だけ個別に上書きすることもできる
      -- set_hl('@my_bold.markdown_inline', {
      --   fg = '#c9c23a',
      --   bold = true,
      --   bg = 'NONE',
      -- })

      set_hl('NonText', { fg = '#7981b5' })

      ----------------------------------------------------------------------
      -- Lazy.nvim (:Lazy) のウィンドウまわり
      ----------------------------------------------------------------------
      -- Lazy の中身（背景＋文字色）
      set_hl('LazyNormal', { fg = '#86a284', bg = 'NONE' })

      -- Lazy の枠線
      -- ここを変えると :Lazy ウィンドウの外枠の色が変わる
      --       set_hl('LazyBorder', { fg = '#6568bf', bg = 'NONE' })

      ----------------------------------------------------------------------
      -- lazy.nvim UI の色カスタム
      ----------------------------------------------------------------------

      -- 「Total: 63 plugins」や「Clean (19)」などの行のコメントっぽい部分
      set_hl('LazyComment', {
        fg = '#e6e1f7', -- 好きな色
        italic = false,
        bg = 'NONE',
      })

      -- 中タイトル（例: "Total: 63 plugins" の "Total" 部分 など）
      set_hl('LazyH2', {
        fg = '#c75a3c', -- 好きな色
        bg = 'NONE',
      })
      -- 左上の "Lazy.nvim" 見出し
      set_hl('LazyH1', {
        fg = '#ffffff', -- 好きな色に
        bg = '#424659',
      })

      for _, g in ipairs(transparent_groups) do
        local ok, prev = pcall(vim.api.nvim_get_hl, 0, { name = g })
        if ok then
          vim.api.nvim_set_hl(0, g, { bg = 'NONE', fg = prev.fg })
        else
          vim.api.nvim_set_hl(0, g, { bg = 'NONE' })
        end
      end

      -- python docstringの色設定を上書き
      set_hl('@string.documentation.python', { fg = '#444445', italic = true, bg = 'NONE' })
      -- render-markdownの色設定
      set_hl('@markup.heading.1.markdown', { fg = '#74fa05', bg = 'NONE' })
      set_hl('@markup.heading.2.markdown', { fg = '#cedb53', bg = 'NONE' })
      set_hl('@markup.heading.3.markdown', { fg = '#936b96', bg = 'NONE' })
      set_hl('@markup.heading.4.markdown', { fg = '#456ba1', bg = 'NONE' })
      set_hl('@markup.heading.5.markdown', { fg = '#559e8b', bg = 'NONE' })
      --set_hl('@markup.strong.markdown', { fg = '#c9c23a', bold = true })
    end,
  },
}
