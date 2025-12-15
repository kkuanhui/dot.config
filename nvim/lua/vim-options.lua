vim.cmd("set encoding=utf-8")
vim.cmd("set fileencoding=utf-8")

local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = "to find files" })
vim.keymap.set('n', '<C-b>', builtin.buffers, { desc = "to find buffers" })
-- vim.keymap.set('n', '<C-t>', builtin.tabs, {desc = "to find tabs"})

local config = require("nvim-treesitter.configs")
config.setup({
  ensure_installed = { "lua", "javascript", "python", "c", "cpp", "css", "markdown", "json", "html" },
  indent = { enable = true },
  highlight = {
    enable = true,
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
  },
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
vim.cmd("set expandtab")
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
vim.keymap.set('n', '<leader>n', '<cmd>NERDTreeToggle<cr>', { desc = 'toggle neotree' })


-- buffers
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "[t", "<cmd>tabprevious<cr>", { desc = "Prev tab" })
vim.keymap.set("n", "]t", "<cmd>tabnext<cr>", { desc = "Next tab" })

-- windows manipulation
vim.keymap.set("n", "<leader>w|", "<C-W>s", { desc = "Split window below", remap = true })
vim.keymap.set("n", "<leader>w_", "<C-W>v", { desc = "Split window right", remap = true })

-- split window at the right side
vim.opt.splitright = true

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "˚", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "∆", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "˙", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "¬", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Do exact search and forward search using "?"
vim.keymap.set("n", "?", function()
  -- Prompt the user for a pattern to search
  local pattern = vim.fn.input("?")
  if pattern ~= "" then
    -- 1. Construct the whole-word search pattern: \<pattern\>
    local whole_word_pattern = "\\<" .. pattern .. "\\>"
    -- 2. Construct the search command
    local search_cmd = "/" .. whole_word_pattern
    -- 3. Use pcall to execute the command safely
    local status, err_msg = pcall(vim.cmd, search_cmd)
    -- 4. Check if the command failed (i.e., E486 Pattern not found)
    if not status then
      -- The error message often includes "Vim:E486", indicating the pattern wasn't found.
      -- Construct the custom message
      local display_msg = "Pattern not found: ".. pattern ..""
      -- Display the custom message using vim.notify() with the ERROR log level
      -- This makes the message red and transient without interrupting the user.
      vim.notify(display_msg, vim.log.levels.ERROR, { title = "Search" })
    end
  end
end, { noremap = true, desc = "Forward, custom-error whole-word search" })

-- Modify "*" search behavior
vim.keymap.set("x", "*", function()
  vim.cmd('normal! y')
  local text = vim.fn.getreg('"')
  text = vim.fn.escape(text, "/\\.*$^~[]")
  vim.fn.setreg('/', text)
  vim.opt.hlsearch = true
end)


-- show telescope tab
vim.keymap.set("n", "<c-t>", "<cmd>Telescope telescope-tabs list_tabs<cr>", { desc = "Show telescope tab" })

vim.api.nvim_set_keymap('n', '<leader>b', ":lua require('config/telescope').my_buffer()<cr>", { noremap = true })
vim.cmd("autocmd VimEnter * if &filetype !=# 'gitcommit' | NERDTree | wincmd l | endif")
