-- Configuración completa de lspsaga para Neovim con LazyVim
return {
	{
		"nvimdev/lspsaga.nvim",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		config = function()
			require("lspsaga").setup({
				-- Configuración de la interfaz
				ui = {
					border = "rounded", -- Bordes redondeados para las ventanas flotantes
					colors = { -- Colores personalizados
						normal_bg = "#1e1e2e", -- Fondo de las ventanas de lspsaga
					},
				},
				diagnostic = {
					on_insert = false, -- Mostrar diagnósticos solo fuera de modo de inserción
					show_code_action_icon = true, -- Mostrar icono en las acciones de código
					show_source = true, -- Mostrar la fuente del diagnóstico
				},
				code_action = {
					enable = true,
					sign = true,
					keymap = { -- Asignación de teclas para acciones de código
						show_action = "ga",
						execute_action = "<CR>",
					},
				},
				finder = {
					default = "def+ref", -- Combinación de definiciones y referencias
					max_height = 0.5, -- Altura máxima de la ventana del finder
				},
				outline = {
					win_position = "right", -- Posición de la vista de símbolos (Outline)
					win_width = 30,
					auto_preview = true,
				},
				lightbulb = {
					enable = true, -- Activa el ícono de bombilla para sugerencias
					sign = true,
					virtual_text = false,
				},
			})

			-- Asignaciones de teclas para las funciones de lspsaga
			local keymap = vim.keymap.set
			keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>", { silent = true })
			keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
			keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
			keymap("n", ";,", "<cmd>Lspsaga rename<CR>", { silent = true }) -- Renombrado
			keymap("n", ";l", "<cmd>Lspsaga finder<CR>", { silent = true })
			keymap("n", ";m", "<cmd>Lspsaga outline<CR>", { silent = true })
			keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
			keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
		end,
	},
}
