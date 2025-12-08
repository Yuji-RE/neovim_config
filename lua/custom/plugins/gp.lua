-- ~/.config/nvim/lua/custom/plugins/gp.lua
return {
  {
    'robitx/gp.nvim',
    event = 'VeryLazy',
    config = function()
      local gp = require 'gp'

      gp.setup {
        -- ★ ここで「環境変数から読む」と明示
        openai_api_key = os.getenv 'OPENAI_API_KEY',

        -- ★ さらに provider 側の secret も強制的に環境変数にする
        providers = {
          openai = {
            endpoint = 'https://api.openai.com/v1/chat/completions',
            secret = os.getenv 'OPENAI_API_KEY',
          },
        },

        -- GPT-5 mini をデフォルトにしたい場合
        default_chat_agent = 'ChatGPT5-mini',
        default_command_agent = 'ChatGPT5-mini',
        agents = {
          {
            name = 'ChatGPT5-mini',
            provider = 'openai',
            chat = true,
            command = true,
            model = { model = 'gpt-5-mini' }, -- 実際のモデルID
            system_prompt = require('gp.defaults').chat_system_prompt,
          },
        },
      }

      local map = vim.keymap.set
      local function opts(desc)
        return { noremap = true, silent = true, desc = desc }
      end

      -- ノーマルモードで <leader>ac でチャット開始
      map('n', '<leader>ac', '<cmd>GpChatNew<CR>', opts 'AI Chat (gpt-5-mini)')

      -- 今開いてるファイル全体をコンテキストにしてチャット
      map('n', '<leader>aa', '<cmd>%GpChatNew<CR>', opts 'AI Chat (whole file)')

      -- ファイル全体を一括リライト（やる前に必ず git で保存推奨）
      map('n', '<leader>alr', '<cmd>%GpRewrite<CR>', opts 'AI Rewrite All (gpt-5-mini)')

      -- 選択範囲を書き換え（インラインリライト）
      map('v', '<leader>ar', ":<C-u>'<,'>GpRewrite<CR>", opts 'AI Rewrite')

      -- 選択範囲をポップアップで解説
      map('v', '<leader>ae', ":<C-u>'<,'>GpPopup Explain this code in Japanese, line by line.<CR>", opts 'AI Explain')
    end,
  },
}
