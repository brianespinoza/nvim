return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        -- supermaven 
        "supermaven-inc/supermaven-nvim",
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        -- autocompletions
        'hrsh7th/cmp-buffer',       -- Buffer completions
        'hrsh7th/cmp-path',         -- Path completions
        'hrsh7th/cmp-cmdline',      -- Cmdline completions
        'hrsh7th/cmp-nvim-lsp',     -- LSP completions
        'hrsh7th/cmp-nvim-lua',     -- Lua completions for the NeoVim API
        'l3mon4d3/luasnip',
        'saadparwaiz1/cmp_luasnip', -- Snippet completions
        'mrcjkb/rustaceanvim',      -- rust lsp
    },
    config = function()
        -- Signature Help (insert) -- CTRL + . for signature help
        -- Signature Help (normal) -- K for signature help
        vim.keymap.set('i', '<C-.>', vim.lsp.buf.signature_help, { noremap = true, silent = true })


        -- ga for get actions
        vim.keymap.set('n', '<leader>ga', vim.lsp.buf.code_action, { noremap = true, silent = true })

        -- Rename
        vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, { noremap = true, silent = true })

        -- Rename
        vim.keymap.set('n', '<leader>R', vim.lsp.buf.rename, { noremap = true, silent = true })

        -- Go to definition
        vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, { noremap = true, silent = true })

        -- Formatting
        vim.keymap.set('n', '<leader>=', function()
            vim.lsp.buf.format({ async = true })
        end, { noremap = true, silent = true })

        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())
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
                -- "rust_analyzer"
            },
            -- no relation to ensure_installed. will install everything
            automatic_installation = false,
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                zls = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.zls.setup({
                        root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
                        settings = {
                            zls = {
                                enable_inlay_hints = true,
                                enable_snippets = true,
                                warn_style = true,
                            },
                        },
                    })
                    vim.g.zig_fmt_parse_errors = 0
                    vim.g.zig_fmt_autosave = 0
                end,
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "LuaJIT" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                },
                                workspace = {
                                    -- Make the Neovim runtime files discoverable to the server
                                    library = vim.api.nvim_get_runtime_file("", true),
                                },
                                telemetry = {
                                    enable = false, -- Disable telemetry collection
                                },
                                completion = {
                                    callSnippet = "Replace",
                                },

                            }
                        }
                    }
                end,
                ["tsserver"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.tsserver.setup {
                        on_attach = function(client, bufnr)
                            -- Ensure CodeLens is refreshed
                            if client.server_capabilities.codeLensProvider then
                                vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                                    buffer = bufnr,
                                    callback = function()
                                        vim.lsp.codelens.refresh()
                                    end,
                                })
                                -- Optional: Display CodeLens immediately after attaching
                                vim.lsp.codelens.refresh()
                            end

                            -- Print capabilities for debugging
                            -- print(vim.inspect(client.server_capabilities))
                        end,

                        -- Additional setup options for tsserver can be added here

                        capabilities = capabilities,
                    }
                end,
                ["tailwindcss"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.tailwindcss.setup {
                        capabilities = capabilities,
                    }
                end,
            }
        })


        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local bufnr = args.buf
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                -- if client is not nil
                if client ~= nil and client.supports_method("textDocument/completion") then
                    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
                end
                if client ~= nil and client.supports_method("textDocument/definition") then
                    vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
                end
            end,
        })
        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "if_many",
                header = "",
                prefix = "",
            },
            -- virtual_text = {
            --     prefix = '●', -- Could be '■', '▎', 'x'
            --     source = "if_many", -- Or "if_many"
            --     format = function(diagnostic)
            --         return diagnostic.message
            --     end
            -- }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        -- helps in deciding if we should trigger the completion menu
        local function has_words_before()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        -- cmp config
        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            -- primeagens config : testing it out
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),

            -- my old config, in case I want to go back
            -- mapping = cmp.mapping.preset.insert({
            --     ['<Tab>'] = cmp.mapping(function(fallback)
            --         if cmp.visible() then
            --             cmp.select_next_item()
            --         elseif has_words_before() then
            --             cmp.complete()
            --         else
            --             fallback()
            --         end
            --     end, { "i", "s" }),

            --     ['<S-Tab>'] = cmp.mapping(function(fallback)
            --         if cmp.visible() then
            --             cmp.select_prev_item()
            --         else
            --             fallback()
            --         end
            --     end, { "i", "s" }),
            --     ['<C-j>'] = cmp.mapping.scroll_docs(-4),
            --     ['<C-k>'] = cmp.mapping.scroll_docs(4),
            --     ['<C-Space>'] = cmp.mapping.complete(),
            --     ['<C-e>'] = cmp.mapping.close(),
            --     ['<CR>'] = cmp.mapping.confirm({ select = true }),
            -- }),
            sources = cmp.config.sources({
                    { name = "supermaven" },
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' }, -- For luasnip users.
                },
                {
                    { name = 'buffer' },
                })
        })

        -- Use buffer source for `/` (searching) and `:` (command line)
        cmp.setup.cmdline('/', {
            sources = {
                { name = 'buffer' }
            }
        })
        cmp.setup.cmdline(':', {
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            })
        })
    end
}
