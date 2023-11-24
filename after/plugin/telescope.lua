local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.git_files, { desc = '[p]roject [f]iles' })
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[f]ind [f]iles' })
vim.keymap.set('n', '<leader>fs', builtin.live_grep, { desc = '[f]ind [s]tring' })
vim.keymap.set('n', '<leader>fc', builtin.grep_string, { desc = '[f]ind [c]urrent string under cursor in cwd' })

vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

-- to select files, press escape and navigate with j/k
-- <C-t>: Open the file in a new tab.
