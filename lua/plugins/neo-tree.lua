return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			{
				"s1n7ax/nvim-window-picker",
				version = "2.*",
				config = function()
					require("window-picker").setup({
						filter_rules = {
							include_current_win = false,
							autoselect_one = true,
							bo = {
								filetype = { "neo-tree", "neo-tree-popup", "notify" },
								buftype = { "terminal", "quickfix" },
							},
						},
					})
				end,
			},
		},
		config = function()
			-- Define los íconos para diagnósticos
			vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
			vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
			vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
			vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

			-- Configuración principal de Neo-tree
			require("neo-tree").setup({
				-- Activa la barra de pestañas en la parte superior
				sources = {
					"filesystem",
					"buffers",
					"git_status",
					"document_symbols", -- Opcional: Agrega "document_symbols" para símbolos
				},
				source_selector = {
					winbar = true, -- Habilita la barra de pestañas en la parte superior
					content_layout = "center", -- Centra las pestañas
					sources = { -- Define el orden de las pestañas aquí
						{ source = "filesystem", display_name = "File" },
						{ source = "buffers", display_name = "Buff" },
						{ source = "git_status", display_name = "Git" },
						{ source = "document_symbols", display_name = "Symb" },
					},
					tabs_layout = "equal", -- Distribuye el ancho de cada pestaña de manera igual
				},

				document_symbols = {
					follow_cursor = true, -- Sigue el cursor automáticamente
					auto_preview = true, -- Activa la vista previa automática
					window = {
						position = "left",
						width = 40,
						mappings = {
							["."] = "toggle_node", -- Alterna el nodo actual
						},
					},
				},
				close_if_last_window = false,
				popup_border_style = "rounded",
				enable_git_status = true,
				enable_diagnostics = true,
				open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
				default_component_configs = {
					indent = {
						indent_size = 2,
						with_markers = true,
						expander_collapsed = "",
						expander_expanded = "",
					},
					icon = {
						folder_closed = "",
						folder_open = "",
						folder_empty = "󰜌",
					},
					modified = {
						symbol = "[+]",
						highlight = "NeoTreeModified",
					},
					name = {
						use_git_status_colors = true,
					},
					git_status = {
						symbols = {
							added = "",
							modified = "",
							deleted = "✖",
							renamed = "󰁕",
							untracked = "",
							ignored = "",
							unstaged = "󰄱",
							staged = "",
							conflict = "",
						},
					},
				},
				window = {
					position = "left",
					width = 40,
					mappings = {
						["<space>"] = "",
						["<2-LeftMouse>"] = "open",
						["<cr>"] = "open",
						["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
						["S"] = "open_split",
						["s"] = "open_vsplit",
						["t"] = "open_tabnew",
						["C"] = "close_node",
						["z"] = "close_all_nodes",
						["a"] = { "add", config = { show_path = "none" } },
						["A"] = "add_directory",
						["d"] = "delete",
						["r"] = "rename",
						["y"] = "copy_to_clipboard",
						["x"] = "cut_to_clipboard",
						["p"] = "paste_from_clipboard",
						["c"] = "copy",
						["m"] = "move",
						["q"] = "close_window",
						["R"] = "refresh",
						["?"] = "show_help",
					},
				},
				filesystem = {
					filtered_items = {
						visible = false,
						hide_dotfiles = true,
						hide_gitignored = true,
						hide_hidden = true,
					},
					follow_current_file = { enabled = false, leave_dirs_open = false },
					group_empty_dirs = false,
					hijack_netrw_behavior = "open_default",
				},
				buffers = {
					follow_current_file = { enabled = true, leave_dirs_open = false },
					group_empty_dirs = true,
					show_unloaded = true,
				},
				git_status = {
					window = {
						position = "left",
						mappings = {
							["A"] = "git_add_all",
							["gu"] = "git_unstage_file",
							["ga"] = "git_add_file",
							["gr"] = "git_revert_file",
							["gc"] = "git_commit",
							["gp"] = "git_push",
							["gg"] = "git_commit_and_push",
						},
					},
				},
			})

			-- Mapea la tecla `\` para abrir Neo-tree
			vim.api.nvim_set_keymap("n", "\\", ":Neotree reveal<CR>", { noremap = true, silent = true })
		end,
	},
}
