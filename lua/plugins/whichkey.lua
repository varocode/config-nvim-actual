return {
	"folke/which-key.nvim",
	config = function()
		require("which-key").setup({
			preset = "modern",

			-- otras configuraciones personalizadas aquí
		})
	end,

	keys = {
		{
			-- Keybinding to show which-key popup
			"<leader>?",
			function()
				require("which-key").show({ global = false }) -- Show the which-key popup for local keybindings
			end,
		},
		{
			-- Define a group for Obsidian-related commands
			"<leader>o",
			group = "Obsidian",
		},
	},
}
