-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

    -- Code Parsing and navigation
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.x',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
	use {
		'nvim-treesitter/nvim-treesitter',
		run = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end,
	}
	use('nvim-treesitter/playground')
	use('mbbill/undotree')

    -- LSP
	use {
		'VonHeikemen/lsp-zero.nvim',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-buffer'},
			{'hrsh7th/cmp-path'},
			{'saadparwaiz1/cmp_luasnip'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'hrsh7th/cmp-nvim-lua'},

			-- Snippets
			{'L3MON4D3/LuaSnip'},
			{'rafamadriz/friendly-snippets'},

            -- Useful status updates for LSP
            'j-hui/fidget.nvim',

            -- Additional lua configuration, makes nvim stuff amazing
            'folke/neodev.nvim',
		}
	}

    -- Navigation
    use("preservim/nerdtree") -- File explorer
    use("christoomey/vim-tmux-navigator") -- Navigate via nvim and tmux
	use('theprimeagen/harpoon') -- Marking files

    -- Editor Features
	use('tpope/vim-fugitive') -- Git
    use("junegunn/vim-easy-align") -- Allignment
    use({'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async'}) -- Folding
    use('mattn/vim-goimports') -- Imports and formatting

    -- Debugging
    use('mfussenegger/nvim-dap')
    use('rcarriga/nvim-dap-ui')
    use('leoluz/nvim-dap-go')
    use('nvim-telescope/telescope-dap.nvim')
    use('theHamsta/nvim-dap-virtual-text')
    use({ 'mhanberg/elixir.nvim', requires = { 'nvim-lua/plenary.nvim' }})
    -- use('fatih/vim-go') -- not sure I like this

    -- Visuals
    -- use 'rktjmp/lush.nvim'
    use("folke/zen-mode.nvim") -- Focus single file
	use('rebelot/kanagawa.nvim') -- Color theme
    use('xiyaowong/nvim-transparent') -- Transparent background
    use({'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}) -- See buffers as tabs
    use({
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }) -- See nvim info at bottom of page
    use({
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }) -- Comment highlighting
end)
