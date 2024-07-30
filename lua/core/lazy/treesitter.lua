return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        vim.wo.foldmethod = "expr"
        vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
        vim.wo.foldlevel = 99
        require("nvim-treesitter.configs").setup({
            modules = {},
            -- A list of parser names, or "all"
            ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "yaml", "typescript", "jsdoc",
                "javascript", "html", "gitignore", "go", "dockerfile", "cpp", "cmake", "bash",
                "json", "latex", "python", "rust", "sql", "xml" },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
            auto_install = true,

            indent = {
                enable = true
            },

            highlight = {
                -- `false` will disable the whole extension
                enable = true,

                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = { "markdown" },
            },
            -- Incremental selection based on the named nodes from the grammar
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "gnn",
                    node_incremental = "grn",
                    scope_incremental = "grc",
                },
            },

        })
    end
}
