vim.cmd [[
let g:undotree_WindowLayout = 2
]]

-- toggle undotree and set focus to the undo tree window
vim.keymap.set("n", "<leader>u", ':UndotreeToggle<CR><C-w>w<C-w>k', {
  desc = 'Show [U]ndo tree'
})


