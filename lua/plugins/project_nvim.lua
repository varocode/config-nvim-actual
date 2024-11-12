return {
	"coffebar/neovim-project",
	opts = {
		projects = { -- Define los directorios raíz de tus proyectos
			"~/Projects/*", -- Cambia esta ruta si tus proyectos están en otra carpeta
		},
		picker = {
			type = "telescope", -- Usa Telescope como el selector
		},
	},
	init = function()
		-- Habilitar la opción para guardar estados de plugins en la sesión
		vim.opt.sessionoptions:append("globals")
	end,
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope.nvim", tag = "0.1.4" },
		{ "Shatur/neovim-session-manager" },
	},
	lazy = false,
	priority = 100,
}
