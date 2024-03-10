--
-- COLORS --
--

vim.opt.termguicolors = true

function SetColor(color)
    color = "kanagawa-wave" -- have a default value : kanagawa-dragon for dark 
    vim.cmd.colorscheme(color)

    -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    -- vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#330000" })
end

SetColor() -- run at startup
