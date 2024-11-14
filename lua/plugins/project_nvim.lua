return {
	"coffebar/neovim-project",
	opts = {
		projects = {
			"~/Projects/*",
		},
		picker = {
			type = "telescope",
		},
		last_session_on_startup = false,
		dashboard_mode = false,
	},
	init = function()
		vim.opt.sessionoptions:append("globals")
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"Shatur/neovim-session-manager",
	},
	lazy = false,
	priority = 100,
}
