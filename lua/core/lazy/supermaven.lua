return {
    "supermaven-nvim",
    -- default opts if we ever decide to use them. we'll need to add a config section
    opts = {
        keymaps = {
            accept_suggestion = "<Tab>",
            clear_suggestion = "<C-]>",
            accept_word = "<C-j>",
        },
        ignore_filetypes = { cpp = true, env = true },
        color = {
            suggestion_color = "#ffffff",
            cterm = 244,
        },
        disable_inline_completion = false, -- disables inline completion for use with cmp
        disable_keymaps = false,       -- disables built in keymaps for more manual control,,
    }
}

