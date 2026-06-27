-- [[ diffview.nvim configuration ]]

local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'sindrets/diffview.nvim' }

require('diffview').setup({
  enhanced_diff_hl = true,
  view = {
    merge_tool = {
      layout = "diff3_mixed",
      disable_diagnostics = true,
    },
  },
})

-- Keymaps
-- 1. Normal mode: File history (timeline) for current file
vim.keymap.set('n', '<leader>gh', '<cmd>DiffviewFileHistory %<CR>', { desc = 'Git [g]ile [h]istory (Timeline)' })

-- 2. Visual mode: File history for visual selection block
vim.keymap.set('v', '<leader>gh', ":DiffviewFileHistory<CR>", { desc = 'Git selection [g]ile [h]istory' })

-- 3. Open full git diff panel
vim.keymap.set('n', '<leader>gd', '<cmd>DiffviewOpen<CR>', { desc = 'Git [g]ile [d]iff (open panel)' })
vim.keymap.set('n', '<leader>gc', '<cmd>DiffviewClose<CR>', { desc = 'Git [g]ile [d]iff (close panel)' })
