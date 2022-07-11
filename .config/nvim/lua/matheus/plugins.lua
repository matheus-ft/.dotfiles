-- ESSENTIAL: run `:PackerSync` everytime this file changes

-- Bootstrapping
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Plugins
return require('packer').startup{function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Useful things
  use {
    'windwp/nvim-autopairs',                -- completes the pair of surrounding chars
    config = function() require('nvim-autopairs').setup {} end
  }
  use 'tpope/vim-surround'                  -- to change surrounding characters easily
  use 'numToStr/Comment.nvim'               -- toggle comments easily
  use 'numToStr/FTerm.nvim'                 -- floating terminal
  use 'vim-airline/vim-airline'             -- status line
  use 'preservim/nerdtree'                  -- file tree
  use 'lukas-reineke/indent-blankline.nvim' -- indentation lines

  -- Git
  use 'lewis6991/gitsigns.nvim'
  use 'tpope/vim-fugitive'

  -- LSP and autocomplete stuff
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'

  -- Sintax highlighting
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'romgrk/nvim-treesitter-context'
  -- relaunch neovim and run `:TSInstall lua python julia`

  -- Octave (treesitter don support matlab-like languages apparently)
  use 'jvirtanen/vim-octave'
  use 'tpope/vim-endwise' -- useful for other languages too (i guess...)

  -- Lua
  use 'hrsh7th/cmp-nvim-lua'

  -- Markdown, latex, etc.
  use { 'iamcco/markdown-preview.nvim', run = 'cd app && npm install', setup = function() vim.g.mkdp_filetypes = { 'markdown' } end, ft = { 'markdown' }, }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'nvim-telescope/telescope-fzy-native.nvim' -- sorts the findings
  -- also install 'github.com/BurntSushi/ripgrep' to use live_grep func

  -- Themes
  use 'navarasu/onedark.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end}

