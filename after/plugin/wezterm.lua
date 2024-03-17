local w = require("wezterm");
w.setup({});

-- Switch tab by index using vim.v.count
vim.keymap.set("n", "<leader>wt", w.switch_tab.index);

-- Define a keymap to open a new vertical split
vim.keymap.set("n", '<leader>wl', function()
    w.split_pane.horizontal({ domain = "CurrentPaneDomain" })
end, { desc = 'open new horizontal terminal'})

-- Define a keymap to open a new horizontal split
vim.keymap.set("n", '<leader>wb', function()
    w.split_pane.vertical({ domain = "CurrentPaneDomain" })
end, { desc = 'open new vertical terminal'})
