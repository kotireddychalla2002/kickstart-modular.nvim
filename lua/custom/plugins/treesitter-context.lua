-- [[ nvim-treesitter-context configuration ]]

local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'nvim-treesitter/nvim-treesitter-context' }

require('treesitter-context').setup({
  enable = true, -- Enable this plugin
  max_lines = 4, -- Limit the context header to a maximum of 4 lines
  min_window_height = 15, -- Only enable when window has a decent height
  line_numbers = true,
  multiline_threshold = 20, -- Maximum number of lines to show for a single context
  trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded
  mode = 'cursor',  -- Line used to calculate context
  zindex = 20, -- Z-index of the context window
})

-- Keymap to jump to the parent context (e.g. up to the function header)
vim.keymap.set("n", "[t", function()
  require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true, desc = "Go to [t]reesitter context parent" })
