-- my custom mappings 

vim.g.mapleader = " "
-- open explorer
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<cr> :vertical resize 30<cr>', { desc = 'Go to [E]xplorer'})

vim.keymap.set("i", "<C-c>", "<Esc>")

-- quit
vim.keymap.set('n', '<leader>q', ':q<cr>', { desc = '[q]uit (buffer)'})
-- save and close
vim.api.nvim_set_keymap('n', '<leader>s', ':write | bdelete<CR>', { noremap = true, silent = true })

vim.keymap.set('n', 'Y', 'Vy<Esc>', { desc = '[Y]ank whole line'})


-- focus left right bottom top "screen"
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {noremap = true, silent = true})


local terminal_buffer = nil

function ToggleTerminal()
    if terminal_buffer ~= nil and vim.api.nvim_buf_is_loaded(terminal_buffer) then
        -- Check if the terminal is already open in a window
        for _, win in pairs(vim.api.nvim_list_wins()) do
            if vim.api.nvim_win_get_buf(win) == terminal_buffer then
                vim.api.nvim_win_hide(win)
                return
            end
        end
        -- Terminal is not open, so open it
        vim.cmd('belowright sp | term')
        vim.api.nvim_win_set_buf(0, terminal_buffer)
    else
        -- Terminal buffer does not exist, so create it
        vim.cmd('belowright sp | term')
        terminal_buffer = vim.api.nvim_get_current_buf()
    end
end


vim.keymap.set('n', '<leader>t', ToggleTerminal, { desc = '[t]erminal'})
vim.api.nvim_set_keymap('t', '<C-x>', [[<C-\><C-n>]], { desc = 'exit terminal mode', noremap = true, silent = true})

-- Indent whole file and jump back to last edit position
vim.keymap.set("n", "<leader>=", "ggVG=`.", { desc = '[=] Reindent file' })



-- Open fugitive menu
vim.keymap.set("n", "<leader>G", vim.cmd.Git, { desc = '[G]it interface' })

-- Remove last search term highlight
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- "" Region indent/outdent
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<S-Tab>', '<gv')
vim.keymap.set('v', '<Tab>', '>gv')

-- Move cursor across soft wraps
vim.keymap.set('v', '<Right>', 'l', { silent = true })
vim.keymap.set('v', '<Left>', 'h', { silent = true })
vim.keymap.set('v', '<Up>', 'gk', { silent = true })
vim.keymap.set('v', '<Down>', 'gj', { silent = true })
vim.keymap.set('n', '<Right>', 'l', { silent = true })
vim.keymap.set('n', '<Left>', 'h', { silent = true })
vim.keymap.set('n', '<Up>', 'gk', { silent = true })
vim.keymap.set('n', '<Down>', 'gj', { silent = true })
vim.keymap.set('i', '<Up>', '<C-o>gk', { silent = true })
vim.keymap.set('i', '<Down>', '<C-o>gj', { silent = true })

-- "" Bubbling Text
-- " Bubble single lines
vim.keymap.set('n', '<C-Up>', 'ddkP')
vim.keymap.set('n', '<C-Down>', 'ddp')
vim.keymap.set('n', '<C-k>', 'ddkP')
vim.keymap.set('n', '<C-j>', 'ddp')


-- " Bubble multiple lines
vim.keymap.set('v', '<C-Up>', 'xkP`[V`]=gv')
vim.keymap.set('v', '<C-Down>', 'xp`[V`]=gv')
vim.keymap.set('v', '<C-k>', 'xkP`[V`]=gv')
vim.keymap.set('v', '<C-j>', 'xp`[V`]=gv')

-- search the current word under the cursor and puts you in insert mode,
-- then you change the word, press esc, n to find the next instance, . to reapply the change
vim.keymap.set('n', '<leader>cw', function()
    vim.fn.setreg('/', '\\<' .. vim.fn.expand('<cword>') .. '\\>')
    vim.api.nvim_input('"_ciw')
end, { noremap = true, silent = true })

