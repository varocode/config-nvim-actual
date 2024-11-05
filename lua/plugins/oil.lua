return {
	{
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup({
				-- Oil toma control de los buffers de directorio, permitiendo explorar archivos
				default_file_explorer = true,
				-- Columnas para mostrar información adicional
				columns = {
					"icon",
					"permissions",
					"size",
					"mtime",
				},
				-- Opciones específicas del buffer
				buf_options = {
					buflisted = false,
					bufhidden = "hide",
				},
				-- Opciones específicas de la ventana
				win_options = {
					wrap = false,
					signcolumn = "no",
					cursorcolumn = false,
					foldcolumn = "0",
					spell = false,
					list = false,
					conceallevel = 3,
					concealcursor = "nvic",
				},
				-- Configuración de la papelera, evita eliminar archivos permanentemente
				delete_to_trash = true,
				-- Opción para saltar confirmación en operaciones simples
				skip_confirm_for_simple_edits = true,
				-- Confirmación antes de guardar en nuevos archivos o carpetas seleccionadas
				prompt_save_on_select_new_entry = true,
				-- Limpieza automática de buffers ocultos después de este tiempo en ms
				cleanup_delay_ms = 2000,
				-- Configuración de métodos de archivos de LSP
				lsp_file_methods = {
					enabled = true,
					timeout_ms = 1000,
					autosave_changes = false,
				},
				-- Restringe el cursor a partes editables del buffer de Oil
				constrain_cursor = "editable",
				-- Configuración de visualización
				view_options = {
					show_hidden = false,
					is_hidden_file = function(name)
						return vim.startswith(name, ".")
					end,
					natural_order = true,
					case_insensitive = false,
					sort = {
						{ "type", "asc" },
						{ "name", "asc" },
					},
				},
				-- Configuración de previsualización
				preview = {
					max_width = 0.5,
					max_height = 0.7,
					border = "rounded",
					update_on_cursor_moved = true,
					filter = function(path)
						-- Ignora los archivos .iso en la previsualización
						return not path:match("%.iso$")
					end,
				},
				-- Integración de teclas de acceso directo (keymaps) con acciones personalizadas
				keymaps = {
					["<CR>"] = "actions.select", -- Seleccionar archivo
					["<C-s>"] = { "actions.select", opts = { vertical = true } },
					["<C-h>"] = { "actions.select", opts = { horizontal = true } },
					["<C-t>"] = { "actions.select", opts = { tab = true } },
					["<C-p>"] = "actions.preview", -- Activar previsualización
					["<C-c>"] = "actions.close", -- Cerrar Oil
					["<C-l>"] = "actions.refresh", -- Refrescar lista de archivos
					["gs"] = "actions.change_sort", -- Cambiar orden de archivos
					["gx"] = "actions.open_external", -- Abrir archivo en programa externo
					["g."] = "actions.toggle_hidden", -- Alternar archivos ocultos
				},
				-- Opciones de Git experimentales
				git = {
					add = function()
						return false
					end,
					mv = function()
						return false
					end,
					rm = function()
						return false
					end,
				},
			})

			-- Configuración del atajo de teclado para abrir Oil
			vim.api.nvim_set_keymap("n", "<leader>.", ":Oil<CR>", { noremap = true, silent = true })
		end,
	},
}
