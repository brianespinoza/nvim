require('neodev').setup()

-- lsp manager
require("mason").setup()
require("mason-lspconfig").setup({
        ensure_installed = {
            "tailwindcss",
            "tsserver",
            -- "eslint",
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


-- custom function to pipe lsp references into telescope
local function lsp_telescope_picker(lsp_method, prompt_title)
    local original_handler = vim.lsp.handlers[lsp_method]
    local temp_handler = function(err, result, ctx, config)
        vim.lsp.handlers[lsp_method] = original_handler

        if not result or vim.tbl_isempty(result) then
            vim.notify(prompt_title .. " not found", vim.log.levels.INFO)
            return
        end

        local client = vim.lsp.get_client_by_id(ctx.client_id)
        if not client or not client.offset_encoding then
            vim.notify("LSP client not found or missing offset_encoding", vim.log.levels.ERROR)
            return
        end

        local locations = vim.lsp.util.locations_to_items(result, client.offset_encoding)

        require('telescope.pickers').new({}, {
            prompt_title = prompt_title,
            finder = require('telescope.finders').new_table {
                results = locations,
                entry_maker = function(entry)
                    local display_text = string.format("[%d:%d] %s", entry.lnum, entry.col, entry.text)
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
                    vim.cmd('write')
                    vim.cmd('e ' .. selection.value.filename)
                    vim.api.nvim_win_set_cursor(0, { selection.value.lnum, selection.value.col - 1 })
                end)
                map('n', '<CR>', function()
                    local selection = require('telescope.actions.state').get_selected_entry()
                    require('telescope.actions').close(prompt_bufnr)
                    vim.cmd('write')
                    vim.cmd('e ' .. selection.value.filename)
                    vim.api.nvim_win_set_cursor(0, { selection.value.lnum, selection.value.col - 1 })
                end)
                return true
            end,
        }):find()
    end

    vim.lsp.handlers[lsp_method] = temp_handler
    vim.lsp.buf[lsp_method]()
    vim.lsp.handlers[lsp_method] = original_handler
end




-- Signature Help
vim.keymap.set('i', '<C-.>', vim.lsp.buf.signature_help, { noremap = true, silent = true })

-- Hover
vim.keymap.set('n', '<C-k>', vim.lsp.buf.hover, { noremap = true, silent = true })

-- Rename
vim.keymap.set('n', '<leader>R', vim.lsp.buf.rename, { noremap = true, silent = true })

-- Go to definition
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, { noremap = true, silent = true })

-- References using Telescope
vim.keymap.set('n', '<leader>gr', function()
    lsp_telescope_picker('textDocument/references', 'LSP References')
end, { noremap = true, silent = true })

-- View outgoing calls using Telescope
vim.keymap.set('n', '<leader>vo', function()
    lsp_telescope_picker('textDocument/outgoingCalls', 'Outgoing Calls')
end, { noremap = true, silent = true })

-- View incoming calls using Telescope
vim.keymap.set('n', '<leader>vi', function()
    lsp_telescope_picker('textDocument/incomingCalls', 'Incoming Calls')
end, { noremap = true, silent = true })

-- Formatting
vim.keymap.set('n', '<leader>=', function()
    vim.lsp.buf.format({ async = true })
end, { noremap = true, silent = true })


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
-- lsp.eslint.setup {
--     -- Add custom settings as needed
--     settings = {
--         -- For example, configuring ESLint options
--         format = {
--             enable = true, -- Enable ESLint formatting
--         },
--     },
--     on_attach = function(client, bufnr)
--         -- Additional custom settings or keybindings can be set here
--     end
-- }


vim.diagnostic.config({
    virtual_text = {
        prefix = '●', -- Could be '■', '▎', 'x'
        source = "always", -- Or "if_many"
        format = function(diagnostic)
            return diagnostic.message
        end
    }
})
