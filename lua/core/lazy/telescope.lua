return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    -- or                            , branch = '0.1.x',
    dependencies = { { 'nvim-lua/plenary.nvim' } },

    config = function()
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
        vim.keymap.set('n', '<leader>sd', search_dotfiles, { desc = 'search dotfiles' })


        -- VIM PICKERS
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[f]ind [b]uffers' })
        vim.keymap.set('n', '<leader>fr', builtin.registers, { desc = '[f]ind [r]egisters' })
        vim.keymap.set('n', '<leader>fc', builtin.colorscheme, { desc = '[f]ind [c]olorscheme' })
        -- Switch tab by index using vim.v.count

        -- TREESITTER PICKER
        -- View function names, variables, methods, etc
        vim.keymap.set('n', '<leader>vm', builtin.treesitter, { desc = '[v]iew [m]ethods' })

        -- GIT PICKERS havent implemented. got lazy
        vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = '[g]it [b]ranches' })
        vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = '[g]it [c]ommits' })
        vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = '[g]it [s]tatus' })


        -- Find Help
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    end,
}
