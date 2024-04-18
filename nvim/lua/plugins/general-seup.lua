return{
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
				dependencies = { "nvim-lua/plenary.nvim" },
				config = function()
						require("telescope").setup{
								defaults = {
										file_ignore_patterns = {
												"node_modules"
										},
										mappings = {
												n = {
														['<c-d>'] = require('telescope.actions').delete_buffer
												}, -- n
												i = {
														["<C-h>"] = "which_key",
														['<c-d>'] = require('telescope.actions').delete_buffer
												}
										}
								}
						}
				end
		},
		{
				'LukasPietzschmann/telescope-tabs',
				config = function()
						require('telescope').load_extension 'telescope-tabs'
						require('telescope-tabs').setup {
								close_tab_shortcut_i = '<C-d>', 
								close_tab_shortcut_n = 'D',    
								show_preview = true,
								entry_ordinal = function(tab_id, buffer_ids, file_names, file_paths, is_current)
										return table.concat(file_names, ' ')
								end,
								entry_formatter = function(tab_id, buffer_ids, file_names, file_paths, is_current)
										local entry_string = table.concat(file_names, ', ')
										return string.format('%d: %s%s', tab_id, entry_string, is_current and ' <' or '')
								end,
						}
				end,
				dependencies = { 'nvim-telescope/telescope.nvim' },
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
				config = function()
						require("nvim-surround").setup({
								-- Configuration here, or leave empty to use defaults
						})
				end
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
		{
				'mg979/vim-visual-multi', 
				branch = "master"
		},
		{
				'numToStr/Comment.nvim',
				opts = {},
				lazy = false,
				config = function()
						require('Comment').setup()
				end
		}
}
