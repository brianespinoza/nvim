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
    require("neodev").setup({}))

local lsp = require('lspconfig')


local function lsp_references_telescope()
    local original_handler = vim.lsp.handlers['textDocument/references']
    local temp_handler = function(err, result, ctx, config)
        vim.lsp.handlers['textDocument/references'] = original_handler

        if not result or vim.tbl_isempty(result) then
            vim.notify("No references found", vim.log.levels.INFO)
            return
        end

        local client = vim.lsp.get_client_by_id(ctx.client_id)
        if not client or not client.offset_encoding then
            vim.notify("LSP client not found or missing offset_encoding", vim.log.levels.ERROR)
            return
        end

        local locations = vim.lsp.util.locations_to_items(result, client.offset_encoding)

        require('telescope.pickers').new({}, {
            prompt_title = "LSP References",
            finder = require('telescope.finders').new_table {
                results = locations,
                entry_maker = function(entry)
                    -- Prepend the filename, line number, and column number to the display text
                    local display_text = string.format("[%d:%d] %s", entry.lnum, entry.col, entry.text )
                    return {
                        value = entry,
                        display = display_text,
                        ordinal = display_text,
                        filename = entry.filename,
                        lnum = entry.lnum,
                        col = entry.col
                    }
                end
            },
            sorter = require('telescope.sorters').get_generic_fuzzy_sorter(),
            previewer = require('telescope.previewers').vim_buffer_qflist.new({}),
            attach_mappings = function(prompt_bufnr, map)
                map('i', '<CR>', function()
                    local selection = require('telescope.actions.state').get_selected_entry()
                    require('telescope.actions').close(prompt_bufnr)
                    vim.cmd('write')  -- Save the current buffer before opening another file
                    vim.cmd('e ' .. selection.value.filename)  -- Open the file
                    vim.api.nvim_win_set_cursor(0, {selection.value.lnum, selection.value.col - 1})  -- Set cursor
                end)
                map('n', '<CR>', function()
                    local selection = require('telescope.actions.state').get_selected_entry()
                    require('telescope.actions').close(prompt_bufnr)
                    vim.cmd('write')  -- Save the current buffer before opening another file
                    vim.cmd('e ' .. selection.value.filename)  -- Open the file
                    vim.api.nvim_win_set_cursor(0, {selection.value.lnum, selection.value.col - 1})  -- Set cursor
                end)
                return true
            end,
        }):find()
    end

    vim.lsp.handlers['textDocument/references'] = temp_handler
    vim.lsp.buf.references()
    vim.lsp.handlers['textDocument/references'] = original_handler
end

vim.keymap.set('n', '<leader>gr', lsp_references_telescope, { buffer = true, noremap = true, silent = true })


-- ctrl k to show method signature
vim.keymap.set('i', '<C-.>', vim.lsp.buf.signature_help, { buffer = true })
vim.keymap.set('n', '<C-k>', vim.lsp.buf.hover, { buffer = true })
vim.keymap.set('n', '<leader>=', vim.lsp.buf.format, { buffer = true })
vim.keymap.set('n', '<leader>R', vim.lsp.buf.rename, { buffer = true })
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, { buffer = true })
--vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, { buffer = true })
-- view outgoing
vim.keymap.set('n', '<leader>vo', vim.lsp.buf.outgoing_calls, { buffer = true })
-- view incoming
vim.keymap.set('n', '<leader>vi', vim.lsp.buf.incoming_calls, { buffer = true }) 


lsp.tailwindcss.setup {}

-- lua lsp config
lsp.lua_ls.setup {
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT', -- For LuaJIT, which is used by NeoVim
            },
            diagnostics = {
                globals = { 'vim' }, -- Recognize the 'vim' global
            },
            workspace = {
                -- Make the Neovim runtime files discoverable to the server
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false, -- Disable telemetry collection
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
        prefix = '●', -- Could be '■', '▎', 'x'
        source = "always", -- Or "if_many"
        format = function(diagnostic)
            return diagnostic.message
        end
    }
})
