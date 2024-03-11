local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    -- My plugins here
    -- multi line cursor
    use {
        "mg979/vim-visual-multi"
    }
    -- auto pair parenthesis autocompletions
    use {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup {}
        end
    }
    -- telescope setup
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    -- color theme setup
    use 'navarasu/onedark.nvim'
    use("rebelot/kanagawa.nvim")

    -- treesitter
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate'})
    use("nvim-treesitter/playground")
    use("nvim-treesitter/nvim-treesitter-context")

    -- undotree
    use({ "mbbill/undotree" })

    -- fugitive / aka git for neovim
    use({ "tpope/vim-fugitive" })

    -- commentary / aka comment stuff out
    use({ "tpope/vim-commentary" })

    -- git gutter (git in the left-most side of screen)
    --use({"airblade/vim-gitgutter"})
    use({"lewis6991/gitsigns.nvim"})

    -- harpoon  2
    use{
        "theprimeagen/harpoon",
        branch = "harpoon2",
        requires = { {"nvim-lua/plenary.nvim"} }
    }
    -- trouble / diagnostics
    use({
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup {
                icons = false,
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    })
    -- copilot
    -- use("github/copilot.vim")

    -- netrw icons
    use ('nvim-tree/nvim-web-devicons')
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    --- lsp config
    use {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
    }
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            --- Uncomment these if you want to manage LSP servers from neovim
            -- {'williamboman/mason.nvim'},
            -- {'williamboman/mason-lspconfig.nvim'},

            -- LSP Support
            {'neovim/nvim-lspconfig'},
            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'L3MON4D3/LuaSnip'},
        }
    }
    use 'folke/neodev.nvim'
    use 'willothy/wezterm.nvim'
    use('mrjones2014/smart-splits.nvim')
    -- autocompletions
    use {'hrsh7th/nvim-cmp'}  -- The completion plugin
    use {'hrsh7th/cmp-buffer'}  -- Buffer completions
    use {'hrsh7th/cmp-path'}  -- Path completions
    use {'hrsh7th/cmp-cmdline'}  -- Cmdline completions
    use {'hrsh7th/cmp-nvim-lsp'}  -- LSP completions
    use {'hrsh7th/cmp-nvim-lua'}  -- Lua completions for the NeoVim API

    -- For snippet support, which some completions require:
    use {'L3MON4D3/LuaSnip'}  -- Snippet engine
    use {'saadparwaiz1/cmp_luasnip'}  -- Snippet completions

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
