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
		priority = 1000,
		config = function()
			require("catppuccin").setup {
				color_overrides = {
					all = {
						base = "#000000",
					},
				},
				custom_highlights = function(colors)
					return {
						LineNr = { fg = '#737373' },
						Comment = {fg = '#adadad'}
					}
				end
			}
		end
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
		"preservim/nerdtree",
		-- loaded = true,
		-- keys = {{'n', '<leader>n'}},
		-- config = function() 
		-- 		vim.cmd('NERDTree') 
		-- end
	},
	-- {
	-- 		"nvim-neo-tree/neo-tree.nvim",
	-- 		branch = "v3.x",
	-- 		dependencies = {
	-- 				"nvim-lua/plenary.nvim",
	-- 				"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
	-- 				"MunifTanjim/nui.nvim",
	-- 				-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	-- 		},
	-- 		window = {
	-- 				position="left",
	-- 				width= 40,
	-- 		},
	-- 		config = function()
	-- 				require('neo-tree').setup({
	-- 						filesystem = {
	-- 								filtered_items = {
	--           hide_dotfiles = false,
	--           hide_gitignored = false,
	-- 								},
	-- 								never_show = { 
	-- 										-- remains hidden even if visible is toggled to true, this overrides always_show
	-- 										".DS_Store",
	-- 										"thumbs.db"
	-- 								},
	-- 						}
	-- 				})
	-- 		end
	-- },
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = true
	},
	{
		"yorickpeterse/nvim-window",
		keys = {
			{ 
				"<leader>ww", 
				"<cmd>lua require('nvim-window').pick()<cr>", 
				desc = "nvim-window: Jump to window" 
			},
		},
		config = true,
	},
	{ 'alexghergh/nvim-tmux-navigation', config = function()
		require'nvim-tmux-navigation'.setup {
			disable_when_zoomed = true, -- defaults to false
			keybindings = {
				left = "<C-h>",
				down = "<C-j>",
				up = "<C-k>",
				right = "<C-l>",
				-- last_active = "<C-\\>",
				-- next = "<C-Space>",
			}
		}
		end
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
	},
	{
		'akinsho/bufferline.nvim', 
		version = "*", 
		dependencies = 'nvim-tree/nvim-web-devicons',
		config = function()
			vim.opt.termguicolors = true
			require("bufferline").setup{}
		end
	},
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

-- use system clipboard
vim.cmd("set clipboard+=unnamedplus")

-- general seting
-- key map
-- vim.keymap.set('n', '<leader>n', '<cmd>Neotree toggle<cr>', {desc = 'toggle neotree'})
vim.keymap.set('n', '<leader>n', '<cmd>NERDTree<cr>', {desc = 'toggle neotree'})

-- buffers
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- windows manipulation
vim.keymap.set("n", "<leader>w|", "<C-W>s", { desc = "Split window below", remap = true })
vim.keymap.set("n", "<leader>w_", "<C-W>v", { desc = "Split window right", remap = true })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "˚", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "∆", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "˙", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "¬", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

vim.api.nvim_set_keymap('n', '<leader>b', ":lua require('config/telescope').my_buffer()<cr>", {noremap = true})

