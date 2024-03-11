local w = require("wezterm");
w.setup({});

-- Switch tab by index using vim.v.count
vim.keymap.set("n", "<leader>wt", w.switch_tab.index);

-- Define a keymap to open a new horizontal split
vim.keymap.set("n", '<leader>wv', function()
    w.split_pane.horizontal({ domain = "CurrentPaneDomain" })
end, { desc = 'open new horizontal terminal'})

-- Define a keymap to open a new vertical split
vim.keymap.set("n", '<leader>wh', function()
    w.split_pane.vertical({ domain = "CurrentPaneDomain" })
end, { desc = 'open new vertical terminal'})
