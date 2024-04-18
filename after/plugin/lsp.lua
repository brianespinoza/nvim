require('neodev').setup()

-- lsp manager
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "tailwindcss",
        "tsserver",
        "eslint",
        "jsonls",
        "html",
        "cssls",
        "lua_ls",
    },
    -- no relation to ensure_installed. will install everything
    automatic_installation = false
},


    -- MUST BE BEFORE LSPCONFIG SETUP
    require("neodev").setup({ }))

local lsp = require('lspconfig')

-- ctrl k to show method signature
vim.keymap.set('i', '<Tab>', vim.lsp.buf.signature_help, {buffer=true})
vim.keymap.set('i', '<leader>=', vim.lsp.buf.format, {buffer=true})
vim.keymap.set('i', '<leader>R', vim.lsp.buf.rename, {buffer=true})
vim.keymap.set('i', '<leader>gr', vim.lsp.buf.references, {buffer=true})
vim.keymap.set('i', '<C-.>', vim.lsp.buf.completion, {buffer=true})


lsp.tailwindcss.setup {}

-- lua lsp config
lsp.lua_ls.setup {
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',  -- For LuaJIT, which is used by NeoVim
            },
            diagnostics = {
                globals = {'vim'},  -- Recognize the 'vim' global
            },
            workspace = {
                -- Make the Neovim runtime files discoverable to the server
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,  -- Disable telemetry collection
            },
            completion = {
                callSnippet = "Replace"
            }
        },
    },
}

-- tsserver config
lsp.tsserver.setup {
    on_attach = function(client, bufnr)
        -- Disable tsserver formatting if you plan to use eslint or prettier for formatting
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false

        -- Additional custom settings or keybindings can be set here
    end
}

-- eslint config
lsp.eslint.setup {
    -- Add custom settings as needed
    settings = {
        -- For example, configuring ESLint options
        format = {
            enable = true, -- Enable ESLint formatting
        },
    },
    on_attach = function(client, bufnr)
        -- Additional custom settings or keybindings can be set here
    end
}


vim.diagnostic.config({
    virtual_text = {
        prefix = '●',  -- Could be '■', '▎', 'x'
        source = "always",  -- Or "if_many"
        format = function(diagnostic)
            return diagnostic.message
        end
    }
})
