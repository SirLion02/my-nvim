-- auto install packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
  return
end

return packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  -- cmp plugins
  use 'hrsh7th/nvim-cmp' -- the completion plugins
  use 'hrsh7th/cmp-buffer' -- buffer completion
  use 'hrsh7th/cmp-path' -- path completion
  use 'hrsh7th/cmp-cmdline' -- command line completion
  use 'saadparwaiz1/cmp_luasnip' -- snippet completion
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'

  -- snippet
  use 'L3MON4D3/LuaSnip' -- snippet engine
  use 'rafamadriz/friendly-snippets' -- a bunch of snippets
  
  -- colorscheme
  use 'Mofiqul/dracula.nvim'

  -- status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- managing and installing LSP 
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'

  -- configuring LSP server
  use 'neovim/nvim-lspconfig'
  
  -- nvim tree
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    -- tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }
  if packer_bootstrap then
    require("packer").sync()
  end
end)
