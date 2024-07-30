-- git gutter (git in the left-most side of screen)
--{ "airblade/vim-gitgutter" },
return {
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            vim.cmd("set statusline+=%{get(b:,'gitsigns_status','')}");
        end,
        opts = {
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigate to the next hunk
                map('n', ']h', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ ']h', bang = true })
                    else
                        gs.nav_hunk('next')
                    end
                end)

                -- Navigate to the previous hunk
                map('n', '[h', function()
                    if vim.wo.diff then
                        vim.cmd.normal({ '[h', bang = true })
                    else
                        gs.nav_hunk('prev')
                    end
                end)

                -- Actions
                -- map('n', '<leader>gs', gs.stage_hunk)
                -- map('n', '<leader>gr', gs.reset_hunk)
                map('n', '<leader>hu', gs.undo_stage_hunk)
                -- map('n', '<leader>hp', gs.preview_hunk)
                -- map('n', '<leader>gb', function() gs.blame_line { full = true } end)

                -- diff against staged version
                map('n', '<leader>hd', gs.diffthis)

                -- diff against last committed version
                map('n', '<leader>hD', function() gs.diffthis('~') end)

                map('n', '<leader>td', gs.toggle_deleted)

                -- map('v', '<leader>gs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
                map('v', '<leader>gr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
            end
        }
    }
}
