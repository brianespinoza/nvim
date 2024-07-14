-- my custom mappings 

vim.g.mapleader = " "
-- open explorer
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<cr> :vertical resize 40<cr>', { desc = 'Go to [E]xplorer'})

vim.keymap.set("i", "<C-c>", "<Esc>")

-- quit
-- vim.keymap.set('n', '<leader>q', ':q<cr>', { desc = '[q]uit (buffer)'})
-- save and close

function SaveAndClose()
if vim.bo.buftype == '' then
    vim.cmd('write')
end
vim.cmd('bdelete')
end
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua SaveAndClose()<CR>', { noremap = true, silent = true })

vim.keymap.set('n', 'Y', 'Vy<Esc>', { desc = '[Y]ank whole line'})


-- focus left right bottom top "screen"
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {noremap = true, silent = true})



-- Indent whole file and jump back to last edit position
--vim.keymap.set("n", "<leader>=", "ggVG=`.", { desc = '[=] Reindent file' }) // using lsp instead

vim.api.nvim_set_keymap('n', '<leader>]', ':bnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>[', ':bprevious<CR>', { noremap = true, silent = true })


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

-- in visual mode, leader p will paste to the clipboard using the _ register
vim.keymap.set('v', '<leader>p', '"_P', { desc = '[p]aste to clipboard' })

-- search the current word under the cursor and puts you in insert mode,
-- then you change the word, press esc, n to find the next instance, . to reapply the change
vim.keymap.set('n', '<leader>cw', function()
    vim.fn.setreg('/', '\\<' .. vim.fn.expand('<cword>') .. '\\>')
    vim.api.nvim_input('"_ciw')
end, { noremap = true, silent = true })

