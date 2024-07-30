-- harpoon  2
return {
    "theprimeagen/harpoon",
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup()
        -- open the harpoon ui
        vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

        -- harpoon add
        vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
        -- harpoon del
        vim.keymap.set("n", "<leader>hd", function() harpoon:list():remove() end)
        -- harpoon next/prev
        vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end)
        vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end)
    end,
    branch = "harpoon2",
    dependencies = { { "nvim-lua/plenary.nvim" } },
}
