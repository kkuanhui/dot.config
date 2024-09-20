-- learned from typecraft lsp series
-- https://github.com/cpow/neovim-for-newbs
return {

	{
		-- used to config lsp in nvim
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},

	{
		-- language server manage tool
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},

	{
		-- used to config ls in mason to do whatever we want
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
		config = function()
			local masonLC = require("mason-lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			masonLC.setup({
				ensure_installed = { "lua_ls", "ts_ls" },
			})
			masonLC.setup_handlers({
				-- loop through all installed language server then bind each into nvim by using "lspconfig"
				function(language_server_name)
					lspconfig[language_server_name].setup({
						capabilities = capabilities,
					})
				end,
			})
		end,
	},

	{
		-- wrap non-lsp commond lins tools, such as "eslint", to become generalized lsp
		"nvimtools/none-ls.nvim", -- null-ls seems deprecated. none-ls is an alternative
		lazy = false,
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua, -- formatter "stylua" is required. install using Mason
					require("none-ls.diagnostics.eslint"), -- imported from dependencies
					require("none-ls.formatting.eslint_d"), -- imported from dependencies
				},
			})
			vim.keymap.set("n", "=", ":lua vim.lsp.buf.format()<CR>", { noremap = true, silent = true })
		end,
		dependencies = {
			"nvimtools/none-ls-extras.nvim",
		},
	},
}
