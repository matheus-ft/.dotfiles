-- ESSENTIAL: run `:so % | PackerSync` everytime this file changes

-- Bootstrapping
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Plugins
return require('packer').startup{function()
  -- Packer manages itself
  use 'wbthomason/packer.nvim'

  -- Useful things
  use 'lukas-reineke/indent-blankline.nvim'   -- indentation lines
  use {
    'windwp/nvim-autopairs',                  -- completes the pair of surrounding chars
    config = function()
      require('nvim-autopairs').setup {}
    end
  }
  use 'tpope/vim-surround'                    -- to change surrounding characters easily
  use 'numToStr/Comment.nvim'                 -- toggle comments easily
  use 'numToStr/FTerm.nvim'                   -- floating terminal
  use {
    'nvim-lualine/lualine.nvim',              -- status line
    { 'akinsho/bufferline.nvim',              -- buffer line
      tag = 'v2.*' },
    { 'kyazdani42/nvim-tree.lua',             -- file tree
      requires = { 'kyazdani42/nvim-web-devicons', }, }
  }

  -- Git
  use 'lewis6991/gitsigns.nvim'
  use 'tpope/vim-fugitive'

  -- Autocompletion stuff
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lua'
  -- use 'saadparwaiz1/cmp_luasnip'
  -- use 'L3MON4D3/LuaSnip'
  -- use 'rafamadriz/friendly-snippets'

  -- LSP stuff
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  -- use { "glepnir/lspsaga.nvim", branch = "main", }

  -- Sintax highlighting
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'romgrk/nvim-treesitter-context'

  -- Octave (treesitter don support matlab-like languages apparently)
  use 'jvirtanen/vim-octave'
  use 'tpope/vim-endwise' -- useful for other languages too (i guess...)

  -- Markdown, latex, etc.
  use { 'iamcco/markdown-preview.nvim', run = 'cd app && npm install', setup = function() vim.g.mkdp_filetypes = { 'markdown' } end, ft = { 'markdown' }, }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzy-native.nvim'} -- sorts the findings
      -- also install 'github.com/BurntSushi/ripgrep' to use live_grep function
    }
  }

  -- Themes
  use 'navarasu/onedark.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end}

