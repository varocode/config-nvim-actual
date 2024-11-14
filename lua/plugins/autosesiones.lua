return {
	"rmagatti/auto-session",
	config = function()
		require("auto-session").setup({
			root_dir = vim.fn.stdpath("data") .. "/sessions/", -- Carpeta para sesiones
			auto_save = true, -- Guardar automáticamente
			auto_restore = false, -- Restaurar automáticamente al iniciar
			auto_create = true, -- Crear sesión si no existe
			auto_restore_last_session = false, -- Restaura última sesión guardada
			use_git_branch = true, -- Nombre de la rama git en la sesión
			lazy_support = true, -- Soporte para Lazy.nvim
			log_level = "info", -- Nivel de log
			bypass_save_filetypes = { "dashboard", "startify" },
			close_unsupported_windows = true,

			-- Comandos para Neo-tree
			pre_save_cmds = { "Neotree close" },
			post_restore_cmds = { "Neotree show" },
		})

		-- Mapas de teclas
		vim.api.nvim_set_keymap(
			"n",
			"<leader>js",
			":SessionSave<CR>",
			{ noremap = true, silent = true, desc = "Guardar Sesión" }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>jr",
			":SessionRestore<CR>",
			{ noremap = true, silent = true, desc = "Restaurar Sesión" }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>jd",
			":SessionDelete<CR>",
			{ noremap = true, silent = true, desc = "Borrar Sesión" }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>jf",
			":SessionSearch<CR>",
			{ noremap = true, silent = true, desc = "Buscar Sesión" }
		)
	end,
}
