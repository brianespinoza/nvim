-- colors.lua

function SetColor(color)
    if color == nil then
        color = "kanagawa-wave" -- have a default value
    end
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
    {
        'navarasu/onedark.nvim',
    },

    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        opts = {},
        config = function()
            SetColor("kanagawa-wave")
        end
    }
}
