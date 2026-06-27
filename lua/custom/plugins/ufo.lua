-- [[ nvim-ufo (Code Folding) configuration ]]

local function gh(repo) return 'https://github.com/' .. repo end

-- UFO needs promise-async
vim.pack.add { gh 'kevinhwang91/promise-async' }
vim.pack.add { gh 'kevinhwang91/nvim-ufo' }

-- Setup folds
vim.o.foldcolumn = '1' -- '0' is also fine if you don't want a fold column
vim.o.foldlevel = 99 -- Using ufo provider needs a large value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Configure UFO options
require('ufo').setup({
  provider_selector = function(bufnr, filetype, buftype)
    return {'treesitter', 'indent'}
  end
})

-- Keymaps
vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = 'Open all folds' })
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = 'Close all folds' })
vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds, { desc = 'Open fold except kinds' })
vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith, { desc = 'Close folds with level' })
vim.keymap.set('n', 'zK', function()
  local winid = require('ufo').peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end, { desc = 'Peek folded lines or show hover' })
