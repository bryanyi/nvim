local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  -- use "kyazdani42/nvim-web-devicons"
  use 'nvim-tree/nvim-web-devicons'
  -- use "kyazdani42/nvim-tree.lua"
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    -- tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }
  use "akinsho/bufferline.nvim"
  use "moll/vim-bbye"
  -- use "nvim-lualine/lualine.nvim"
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use "akinsho/toggleterm.nvim"
  use "ahmedkhalf/project.nvim"
  use "lewis6991/impatient.nvim"
  use "lukas-reineke/indent-blankline.nvim"
  use "goolord/alpha-nvim"
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  use "folke/which-key.nvim"
  use "terrortylor/nvim-comment"
  use 'rmagatti/goto-preview'

  -- HTML & CSS
  use 'alvan/vim-closetag'
  use { 'rrethy/vim-hexokinase', cmd = "make hexokinase" }
  use 'mattn/emmet-vim'
  use 'AndrewRadev/tagalong.vim'
  -- use 'kylechui/nvim-surround'

  -- color
  use "NvChad/nvim-colorizer.lua"
  use "nvim-colortils/colortils.nvim"

  -- Themes
  use 'EdenEast/nightfox.nvim'
  use 'mhartington/oceanic-next'
  use 'glepnir/oceanic-material'
  use "folke/tokyonight.nvim"
  use 'bluz71/vim-nightfly-guicolors'
  use 'navarasu/onedark.nvim'

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use
  use "saadparwaiz1/cmp_luasnip" -- snippet completions

  -- Managing & isntalling LSP servers
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"

  -- LSP configuration
  use "neovim/nvim-lspconfig" -- enable LSP
  use { "glepnir/lspsaga.nvim", branch = "main" }
  -- use "williamboman/nvim-lsp-installer" -- deprecated -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use 'jayp0521/mason-null-ls.nvim'
  use "jose-elias-alvarez/typescript.nvim" -- for formatters and linters
  use 'onsails/lspkind.nvim'
  -- use 'folke/lsp-colors.nvim'
  use 'ray-x/lsp_signature.nvim'
  use "SmiteshP/nvim-navic"
  -- use({
  --   "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  --   config = function()
  --     require("lsp_lines").setup()
  --   end,
  -- })

  -- Telescope
  use "nvim-telescope/telescope.nvim"

  -- Treesitter
  -- use {
  --   "nvim-treesitter/nvim-treesitter",
  --   cmd = ":TSUpdate",
  -- }
  use "nvim-treesitter/nvim-treesitter"
  use 'nvim-treesitter/playground'
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "p00f/nvim-ts-rainbow"

  -- Git
  use "lewis6991/gitsigns.nvim"

  -- Code Runner
  use "is0n/jaq-nvim"
  use {
    "0x100101/lab.nvim",
    run = "cd js && npm ci",
  }

  -- Editing Support
  use 'nacro90/numb.nvim'
  -- use 'karb94/neoscroll.nvim'

  -- Markdown
  -- use 'iamcco/markdown-preview.nvim'
  use {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
  }

  -- Java
  use "mfussenegger/nvim-jdtls"
  -- use 'mikelue/vim-maven-plugin'

  -- icons
  use "stevearc/dressing.nvim"
  use({
    "ziontee113/icon-picker.nvim",
    config = function()
      require("icon-picker").setup({
        disable_legacy_commands = true
      })
    end,
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
