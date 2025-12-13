return {
  -- Neogit
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
    },
    opts = {
      integrations = {
        diffview = true,
      },
    },
    keys = {
      {
        '<leader>gg',
        function()
          require('neogit').open()
        end,
        desc = 'Git: Neogit',
      },
      {
        '<leader>gC',
        function()
          require('neogit').open { 'commit' }
        end,
        desc = 'Git: Commit',
      },
      {
        '<leader>gP',
        function()
          require('neogit').open { 'push' }
        end,
        desc = 'Git: Push',
      },
      {
        '<leader>gl',
        function()
          require('neogit').open { 'log' }
        end,
        desc = 'Git: Log',
      },
    },
  },

  -- Diffview（単体でも呼べるように）
  {
    'sindrets/diffview.nvim',
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Git: Diffview open' },
      { '<leader>gc', '<cmd>DiffviewClose<cr>', desc = 'Git: Diffview close' },
      { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'Git: File history' },
    },
  },
}
