-- ~/.config/nvim/lua/custom/plugins/gp.lua
return {
  {
    'robitx/gp.nvim',
    event = 'VeryLazy',
    config = function()
      local gp = require 'gp'

      gp.setup {
        -- セキュリティ強化のため、APIキーは必ず環境変数から取得
        openai_api_key = os.getenv 'OPENAI_API_KEY',

        -- ★ さらに provider 側の secret も強制的に環境変数
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
      -- map('v', '<leader>ae', ":<C-u>'<,'>GpPopup Explain this code in Japanese, line by line.<CR>", opts 'AI Explain')
      -- 解説 + クイズ
      map(
        'v',
        '<leader>ae',
        ":<C-u>'<,'>GpPopup あなたは優しいPython講師です。選択されたコードについて、(1) 各行の具体的な意味と使い方を日本語で丁寧に解説し、(2) 同じコードを題材に理解度チェック用のクイズを3問作成し、各問について「問題」「模範解答」「ワンポイント解説」をこの順番で出力してください。<CR>",
        opts 'AI Explain + Quiz'
      )

      -- クイズだけバリバリ出
      map(
        'v',
        '<leader>aq',
        ":<C-u>'<,'>GpPopup あなたは厳しめのPython試験官です。選択されたコードの理解度を測るために、日本語で難易度中級のクイズを5問作成してください。各問について「問題文」「模範解答」「詳細で網羅的な解説」を出力してください。コード自体を改変した例は出さず、あくまでこのコードの理解を問う問題に限定してください。<CR>",
        opts 'AI Quiz'
      )

      -- docstring だけ
      map(
        'v',
        '<leader>ad',
        ":<C-u>'<,'>GpPopup あなたはPythonスタイルガイドに詳しい開発者です。選択された関数やメソッドに対して、PEP257スタイルのdocstringを日本語で生成してください。引数・戻り値・処理内容をすべてカバーし、必要に応じて簡潔な使用例も1つだけ含めてください。出力はdocstring部分のみとし、前後に余計な説明文は書かないでください。<CR>",
        opts 'AI Docstring'
      )
    end,
  },
}
