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
    -- telescope setup
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    -- color theme setup
    use 'navarasu/onedark.nvim'

    -- treesitter
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate'})
    use("nvim-treesitter/playground")
    use("nvim-treesitter/nvim-treesitter-context")

    -- undotree
    use({ "jiaoshijie/undotree" })

    -- fugitive / aka git for neovim
    use({ "tpope/vim-fugitive" })

    -- commentary / aka comment stuff out
    use({ "tpope/vim-commentary" })

    -- git gitter (git in the left-most side of screen)
    use({"airblade/vim-gitgutter"})

    -- harpoon 
    use("theprimeagen/harpoon")

    -- copilot
    use("github/copilot.vim")

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
