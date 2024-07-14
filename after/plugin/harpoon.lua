local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

-- mark current file
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
-- remove current file
vim.keymap.set("n", "<leader>A", function() harpoon:list():remove() end)
-- open the harpoon ui
vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)


-- Toggle previous & next buffers stored within Harpoon list
-- Previous and next buffer
vim.keymap.set("n", "<leader>n", function() harpoon:list():next() end)
vim.keymap.set("n", "<leader>p", function() harpoon:list():prev() end)
