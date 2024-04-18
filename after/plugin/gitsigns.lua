require('gitsigns').setup{
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Actions
        map('n', '<leader>gs', gs.stage_hunk)
        -- map('n', '<leader>gr', gs.reset_hunk)
        map('n', '<leader>gu', gs.undo_stage_hunk)
        map('n', '<leader>gp', gs.preview_hunk)
        map('n', '<leader>gb', function() gs.blame_line{full=true} end)

        -- diff against staged version
        map('n', '<leader>fd', gs.diffthis)

        -- diff against last committed version
        map('n', '<leader>fD', function() gs.diffthis('~') end)

        map('n', '<leader>td', gs.toggle_deleted)

        -- map('v', '<leader>gs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
        map('v', '<leader>gr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)

    end
}
vim.cmd("set statusline+=%{get(b:,'gitsigns_status','')}");
