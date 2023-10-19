vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

return {
	'nvim-neo-tree/neo-tree.nvim',
	version = '*',
	dependencies = {
		'nvim-lua/plenary.nvim',
		'nvim-tree/nvim-web-devicons',
		'MunifTanjim/nui.nvim',
	},
	config = function ()
		require('neo-tree').setup {
			filesystem = {
				event_handlers = {
				    {
						event = 'file_opened',
						handler = function ()
						    vim.cmd('Neotree close')
						end
				    },
				}
			}
		}
	end,
}
