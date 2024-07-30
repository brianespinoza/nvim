return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'supermaven-inc/supermaven-nvim',
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'l3mon4d3/luasnip',
        'saadparwaiz1/cmp_luasnip',
        'mrcjkb/rustaceanvim',
    },
    config = function()
        -- Key mappings for LSP features
        vim.keymap.set('i', '<C-.>', vim.lsp.buf.signature_help, { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>ga', vim.lsp.buf.code_action, { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>R', vim.lsp.buf.rename, { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, { noremap = true, silent = true })
        vim.keymap.set('n', '<leader>=', function() vim.lsp.buf.format({ async = true }) end,
            { noremap = true, silent = true })

        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "tailwindcss",
                "tsserver",
                "jsonls",
                "html",
                "cssls",
                "lua_ls",
            },
            automatic_installation = false,
            handlers = {
                function(server_name) -- Default handler
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
                                    library = vim.api.nvim_get_runtime_file("", true),
                                },
                                telemetry = {
                                    enable = false,
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
                                vim.lsp.codelens.refresh() -- Refresh CodeLens immediately
                            end

                            -- Print capabilities for debugging
                            -- print(vim.inspect(client.server_capabilities))
                        end,
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
                if client ~= nil and client.supports_method("textDocument/completion") then
                    vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
                end
                if client ~= nil and client.supports_method("textDocument/definition") then
                    vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
                end
            end,
        })

        vim.diagnostic.config({
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "if_many",
                header = "",
                prefix = "",
            },
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local function has_words_before()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = "supermaven" },
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            }, {
                { name = 'buffer' },
            })
        })

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
