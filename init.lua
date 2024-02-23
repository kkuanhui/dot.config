-- check if lazy was installed or download it.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if there is lazy module stored at lazypath. fs_stat(laztpath) would returns true.
-- if module lazy is not there. Clone it.
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
-- runtimepath prepend lazypath
vim.opt.rtp:prepend(lazypath)

-- load lazy
-- all plugin will be installed in {root}/.local/share/nvim/lazy/
local plugins = {
		{ 
				"catppuccin/nvim", 
				name = "catppuccin", 
				priority = 1000 
		},
		{ 
				"nvim-telescope/telescope.nvim", 
				tag = "0.1.5", 
				dependencies = { "nvim-lua/plenary.nvim" }
		},
		{
				"nvim-treesitter/nvim-treesitter", 
				build = ":TSUpdate"
		},
		{
				"nvim-neo-tree/neo-tree.nvim",
				branch = "v3.x",
				dependencies = {
						"nvim-lua/plenary.nvim",
						"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
						"MunifTanjim/nui.nvim",
						-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
				},
				window = {
						position="left",
						width= 20,
				}
		}
}

local opts = {}

require("lazy").setup(plugins, opts)

local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.find_files, {desc = "to find files"})
vim.keymap.set('n', '<C-b>', builtin.buffers, {desc = "to find buffers"})

local config = require("nvim-treesitter.configs")
config.setup({
		ensure_installed = {"lua", "javascript", "python", "c", "cpp", "css", "markdown", "json", "html"},
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

-- key map
vim.keymap.set('n', '<leader>n', '<cmd>Neotree toggle<cr>', {desc = 'toggle neotree'})


-- buffers
-- vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
-- vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
--vim.keymap.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
--vim.keymap.set("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- windows manipulation
vim.keymap.set("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
vim.keymap.set("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
vim.keymap.set("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })
vim.keymap.set("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
vim.keymap.set("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })

-- control action
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left  window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-8>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-2>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-4>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-6>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
