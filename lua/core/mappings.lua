
vim.g.mapleader = " "
-- open explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("i", "<C-c>", "<Esc>")


vim.keymap.set('n', '<leader>e', ':Lexplore<cr> :vertical resize 30<cr>', { desc = 'Go to [E]xplorer'})
vim.keymap.set('n', '<leader>q', ':q<cr>', { desc = '[q]uit (buffer)'})
vim.keymap.set('n', '<leader>ct', ':sp<cr>:term<cr>:resize 20N<cr>i', { desc = '[c]onsole [t]terminal'})

-- Indent whole file and jump back to last edit position
vim.keymap.set("n", "<leader>=", "ggVG=`.", { desc = '[=] Reindent file' })


-- Previous and next buffer
vim.keymap.set('n', '<leader>n', '<esc>:bn<cr>', { desc = '[N]ext buffer' })
vim.keymap.set('n', '<leader>N', '<esc>:bp<cr>', { desc = '[P]previous buffer' })

-- Open fugitive menu
vim.keymap.set("n", "<leader>G", vim.cmd.Git, { desc = '[G]it interface' })

-- Remove last search term highlight
vim.keymap.set("n", "<leader>h", vim.cmd.noh, { desc = 'Hide search [H]ighlighs'})
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

