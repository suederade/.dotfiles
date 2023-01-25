-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.0',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	use({
		'sainnhe/sonokai',
		as = 'sonokai',
		config = function()
            vim.g.sonokai_style = 'default'
            vim.g.sonokai_better_performance = 1
			vim.cmd('colorscheme sonokai')
		end
	})

	use {
		'nvim-treesitter/nvim-treesitter',
		run = function()
			local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
			ts_update()
		end,
	}

	use('nvim-treesitter/playground')
	use('theprimeagen/harpoon')
	use('mbbill/undotree')
	use('tpope/vim-fugitive')

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

    use("folke/zen-mode.nvim")
    use("github/copilot.vim")
    use("preservim/nerdtree")
    use("christoomey/vim-tmux-navigator")
    use("junegunn/vim-easy-align")
    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }
    -- code folding
    use {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async'}
    --use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}


    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use('mattn/vim-goimports')

    -- Debugging
    use('mfussenegger/nvim-dap')
    use('rcarriga/nvim-dap-ui')
    use('leoluz/nvim-dap-go')
    use('nvim-telescope/telescope-dap.nvim')
    use('theHamsta/nvim-dap-virtual-text')
    -- use('fatih/vim-go') -- not sure I like this
    use({ 'mhanberg/elixir.nvim', requires = { 'nvim-lua/plenary.nvim' }})


end)
