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

-- require("lazy").setup(plugins, opts)
require("lazy").setup("plugins")
require("vim-options")
