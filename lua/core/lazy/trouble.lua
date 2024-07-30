return {
    {
        "folke/trouble.nvim",
        keys = {
            {
                "<leader>tt",
                "<cmd>Trouble diagnostics toggle focus=true<cr>",
                desc = "[T]oggle [T]rouble",
            },
            {
                "<leader>tb",
                "<cmd>Trouble diagnostics toggle filter.buf=0 focus=true<cr>",
                desc = "[T]rouble [B]uffer Diagnostics",
            },
            {
                "<leader>to",
                "<cmd>Trouble symbols toggle focus=true<cr>",
                desc = "[T]rouble [O]outline",
            },
            {
                "<leader>tr",
                "<cmd>Trouble lsp toggle focus=true<cr>",
                desc = "[T]oggle [R]eferences / ...",
            },
            {
                "<leader>tl",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "[T]rouble [L]ocation List",
            },
            {
                "<leader>tq",
                "<cmd>Trouble qflist toggle focus=true<cr>",
                desc = "[T]rouble [Q]uickfix List",
            },
        },
        opts = {}, -- for default options, refer to the configuration section for custom setup.

        config = function()
            require("trouble").setup({
                icons = false,
            })

            vim.keymap.set("n", "<leader>tt", function()
                require("trouble").toggle()
            end)

            vim.keymap.set("n", "[t", function()
                require("trouble").next({skip_groups = true, jump = true});
            end)

            vim.keymap.set("n", "]t", function()
                require("trouble").previous({skip_groups = true, jump = true});
            end)

        end
    },
}
-- Lua
--vim.keymap.set("n", "<leader>d", function() require("trouble").toggle("symbols") end)
-- vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end)
-- vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end)
-- vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end)
-- vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end)
-- vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end)
