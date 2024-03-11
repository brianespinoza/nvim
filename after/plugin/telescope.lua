require('telescope').setup {
    defaults = {
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--glob', '!node_modules/**'
        },
    },
}
-- to select files, press escape and navigate with j/k
-- <C-t>: Open the file in a new tab.

local builtin = require('telescope.builtin')
local function live_grep_with_current_word()
    builtin.live_grep({
        default_text = vim.fn.expand("<cword>")

    })
end

local function search_dotfiles()
    builtin.live_grep({
        cwd = "~/.config/nvim/",
        prompt_title = "< .dotfiles >",
    });
end

-- FILE PICKERS
vim.keymap.set('n', '<leader>pf', builtin.git_files, { desc = '[p]roject [f]iles' })
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[f]ind [f]iles' })
vim.keymap.set('n', '<leader>fs', builtin.live_grep, { desc = '[f]ind [s]tring' })
vim.keymap.set('n', '<leader>fw', live_grep_with_current_word, { desc = '[f]ind [w]ord' })
vim.keymap.set('n', '<leader>sd', search_dotfiles, { desc = '[f]ind [w]ord' })

-- VIM PICKERS
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[f]ind [b]uffers' })
vim.keymap.set('n', '<leader>fc', builtin.colorscheme, { desc = '[f]ind [c]olorscheme' })

-- TREESITTER PICKER
-- View function names, variables, methods, etc
vim.keymap.set('n', '<leader>vm', builtin.treesitter, { desc = '[v]iew [m]ethods' })



-- NVIM LSP PICKERS
vim.keymap.set('n', '<leader>vi', builtin.lsp_incoming_calls, { desc = '[v]iew [i]ncoming calls' })
vim.keymap.set('n', '<leader>vo', builtin.lsp_incoming_calls, { desc = '[v]iew [o]utgoing calls' })
vim.keymap.set('n', '<leader>gi', builtin.lsp_implementations, { desc = '[g]oto [i]mplementations' })
vim.keymap.set('n', '<leader>gd', builtin.lsp_definitions, { desc = '[g]oto [d]efinitions' })

-- GIT PICKERS havent implemented. got lazy
--builtin.git_commits	-- builtin.git_branches	
-- builtin.git_status	-- builtin.git_stash	


vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

