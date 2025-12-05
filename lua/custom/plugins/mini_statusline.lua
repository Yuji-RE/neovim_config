return {
  'echasnovski/mini.statusline',
  config = function()
    local statusline = require 'mini.statusline'
    local path_icons = require 'custom.path_icons'

    statusline.setup {
      content = {
        active = function()
          -- 引数つきで呼ぶ（trunc_width は適当な値でOK）
          local mode, mode_hl = statusline.section_mode { trunc_width = 80 }

          local git = statusline.section_git { trunc_width = 75 }
          local diagnostics = statusline.section_diagnostics { trunc_width = 75 }
          local filename = statusline.section_filename { trunc_width = 140 }
          local fileinfo = statusline.section_fileinfo { trunc_width = 120 }
          local location = statusline.section_location { trunc_width = 75 }
          local search = statusline.section_searchcount { trunc_width = 75 }

          -- ディレクトリ別アイコン
          local icon = path_icons.statusline_icon()

          return statusline.combine_groups {
            { hl = mode_hl, strings = { mode } },
            { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics } },
            { hl = 'MiniStatuslineFilename', strings = { icon, filename } },
            '%<',
            { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
            { hl = 'MiniStatuslineLocation', strings = { search, location } },
          }
        end,
      },
    }
  end,
}
