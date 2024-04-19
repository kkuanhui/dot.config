return{
		'numToStr/Comment.nvim',
		opts = {},
		lazy = false,
		config = function()
				require('Comment').setup({
						toggler = {
								---Line-comment toggle keymap
								line = '',
								---Block-comment toggle keymap
								block = 'gbc',
						},
						opleader = {
								---Line-comment keymap
								line = '',
								---Block-comment keymap
								block = 'gb',
						},
				})
		end
}
