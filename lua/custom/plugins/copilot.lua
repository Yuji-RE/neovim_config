-- ~/.config/nvim/lua/custom/plugins/copilot.lua
return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        suggestion = {
          enabled = true,
          auto_trigger = true, -- タイピング中に自動でゴーストテキスト出す
          debounce = 75,
          keymap = {
            accept = '<C-l>', -- 気に入ったらこれで確定（好きなキーに変えてOK）
            next = '<M-]>',
            prev = '<M-[>',
            dismiss = '<C-]>',
          },
        },
        filetypes = {
          markdown = true,
        },
        panel = {
          enabled = false, -- とりあえずパネルUIはオフでもOK
        },
      }
    end,
  },
}
