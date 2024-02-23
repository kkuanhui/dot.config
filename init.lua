-- check if lazy was installed or download it.
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

-- load lazy
-- all plugin will be installed in {root}/.local/share/nvim/lazy/
local plugins = {
		{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
		{ 
				"nvim-telescope/telescope.nvim", 
				tag = "0.1.5", 
				dependencies = { "nvim-lua/plenary.nvim" }
		},
		{
				"nvim-treesitter/nvim-treesitter", 
				build = ":TSUpdate"
		},
}

local opts = {}

require("lazy").setup(plugins, opts)

local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.find_files, {})

local config = require("nvim-treesitter.configs")
config.setup({
		ensure_installed = {"lua", "javascript", "python", "c", "cpp"},
		highlight = { enable = true },
		indent = { enable = true },
})

-- load catppuccin
vim.cmd.colorscheme "catppuccin-mocha"

-- with vim.cmd() I can use vim command in lua.

-- line number
vim.cmd("set number")
vim.cmd("set relativenumber")             

-- tab size
vim.cmd("set tabstop=1")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- don't backup
vim.cmd("set nobackup")
vim.cmd("set nowb")
vim.cmd("set noswapfile")
vim.cmd("set autoindent")

-- general seting
vim.g.mapleader = "`"
