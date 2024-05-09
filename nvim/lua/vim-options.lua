local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.find_files, {desc = "to find files"})
vim.keymap.set('n', '<C-b>', builtin.buffers, {desc = "to find buffers"})
-- vim.keymap.set('n', '<C-t>', builtin.tabs, {desc = "to find tabs"})

local config = require("nvim-treesitter.configs")
config.setup({
		ensure_installed = {"lua", "javascript", "python", "c", "cpp", "css", "markdown", "json", "html"},
		highlight = { enable = true },
		indent = { enable = true },
})

-- load catppuccin
vim.cmd.colorscheme "catppuccin-mocha"

-- language
vim.cmd("lan mes ja_JP")

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
vim.keymap.set('n', '<leader>n', '<cmd>NERDTreeToggle<cr>', {desc = 'toggle neotree'})

-- buffers
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "[t", "<cmd>tabprevious<cr>", { desc = "Prev tab" })
vim.keymap.set("n", "]t", "<cmd>tabnext<cr>", { desc = "Next tab" })

-- windows manipulation
vim.keymap.set("n", "<leader>w|", "<C-W>s", { desc = "Split window below", remap = true })
vim.keymap.set("n", "<leader>w_", "<C-W>v", { desc = "Split window right", remap = true })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "˚", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "∆", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "˙", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "¬", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- show telescope tab
vim.keymap.set("n", "<c-t>", "<cmd>Telescope telescope-tabs list_tabs<cr>", {desc = "Show telescope tab"})

vim.api.nvim_set_keymap('n', '<leader>b', ":lua require('config/telescope').my_buffer()<cr>", {noremap = true})
vim.cmd("autocmd VimEnter * if &filetype !=# 'gitcommit' | NERDTree | wincmd l | endif")
