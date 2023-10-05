vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

return require('lazy').setup({
    -- Code Parsing and navigation
	{
		'nvim-telescope/telescope.nvim',
		dependencies = { {'nvim-lua/plenary.nvim'} }
	},
    {
        -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
          'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
    },
	'nvim-treesitter/playground',
	'mbbill/undotree',
    -- LSP
	{
		'VonHeikemen/lsp-zero.nvim',
		dependencies = {
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
	},

    -- Navigation
    -- use("preservim/nerdtree") -- File explorer
    "christoomey/vim-tmux-navigator", -- Navigate via nvim and tmux
	'theprimeagen/harpoon', -- Marking files

    -- Editor Features
	'tpope/vim-fugitive', -- Git
    "junegunn/vim-easy-align", -- Allignment
    {'kevinhwang91/nvim-ufo', dependencies = 'kevinhwang91/promise-async'}, -- Folding
    'mattn/vim-goimports', -- Imports and formatting
    'github/copilot.vim',
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }, -- Commenting

    -- Debugging
    'mfussenegger/nvim-dap',
    'rcarriga/nvim-dap-ui',
    'leoluz/nvim-dap-go',
    'nvim-telescope/telescope-dap.nvim',
    'theHamsta/nvim-dap-virtual-text',
    { 'mhanberg/elixir.nvim', dependencies = { 'nvim-lua/plenary.nvim' }},

    -- Visuals
    "folke/zen-mode.nvim", -- Focus single file
	'rebelot/kanagawa.nvim', -- Color theme
    -- use('xiyaowong/nvim-transparent') -- Transparent background
    {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    }, -- See nvim info at bottom of page
    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }, -- Comment highlighting
})
