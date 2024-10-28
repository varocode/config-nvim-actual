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
			{
				"3rd/image.nvim",
				config = function()
					require("image").setup({
						render = {
							min_padding = 5,
							show_label = true,
							use_dither = true,
							foreground_color = true,
							background_color = true,
							max_width = 80,
							max_height = 40,
						},
						events = {
							update_on_nvim_resize = true,
						},
						backend = "kitty",
						integrations = { "neo-tree" },
						kitty_method = "normal",
					})
				end,
			},
			{
				"mrbjarksen/neo-tree-diagnostics.nvim",
				requires = "nvim-neo-tree/neo-tree.nvim",
				module = "neo-tree.sources.diagnostics",
			},
		},
		config = function()
			vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
			vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
			vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
			vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

			require("neo-tree").setup({
				sources = {
					"filesystem",
					"buffers",
					"git_status",
					"document_symbols",
					"diagnostics",
				},
				source_selector = {
					winbar = true,
					content_layout = "center",
					sources = {
						{ source = "filesystem", display_name = "File" },
						{ source = "buffers", display_name = "Buff" },
						{ source = "git_status", display_name = "Git" },
						{ source = "document_symbols", display_name = "Symb" },
						{ source = "diagnostics", display_name = "Diag" },
					},
					tabs_layout = "equal",
				},
				filesystem = {
					filtered_items = {
						visible = false,
						hide_dotfiles = true,
						hide_gitignored = true,
						hide_hidden = true,
						always_show = { ".env", ".gitignore" },
						never_show = { ".DS_Store", "thumbs.db" },
						never_show_by_pattern = { "*.lock", "node_modules" },
					},
					follow_current_file = { enabled = true, leave_dirs_open = false },
					hijack_netrw_behavior = "open_default",
					bind_to_cwd = true,
					cwd_target = {
						sidebar = "tab",
						current = "window",
					},
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
				document_symbols = {
					follow_cursor = true,
					auto_preview = true,
					window = {
						position = "left",
						width = 40,
						mappings = {
							["."] = "toggle_node",
						},
					},
					kinds = {
						Class = { icon = "󰌗", hl = "Include" },
						Function = { icon = "󰊕", hl = "Function" },
						Variable = { icon = "󰀫", hl = "Constant" },
						Field = { icon = "󰈾", hl = "Identifier" },
						Enum = { icon = "󰕘", hl = "Type" },
						Interface = { icon = "󰜰", hl = "Type" },
						Module = { icon = "󰏔", hl = "Include" },
						Constant = { icon = "󰐀", hl = "Constant" },
					},
				},
				diagnostics = {
					auto_preview = {
						enabled = false,
						preview_config = {},
						event = "neo_tree_buffer_enter",
					},
					bind_to_cwd = true,
					diag_sort_function = "severity",
					follow_current_file = {
						enabled = true,
						always_focus_file = false,
						expand_followed = true,
						leave_dirs_open = false,
						leave_files_open = false,
					},
					group_dirs_and_files = true,
					group_empty_dirs = true,
					show_unloaded = true,
					refresh = {
						delay = 100,
						event = "vim_diagnostic_changed",
						max_items = 10000,
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
						["[g"] = "prev_git_modified",
						["]g"] = "next_git_modified",
					},
				},
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
				event_handlers = {
					{
						event = "file_opened",
						handler = function(file_path)
							require("neo-tree").close_all()
						end,
					},
					{
						event = "neo_tree_window_after_open",
						handler = function(args)
							print("Neo-tree window opened!")
						end,
					},
				},
			})

			-- Mapeos para abrir y cerrar diagnósticos en Neo-tree
			vim.api.nvim_set_keymap(
				"n",
				"<S-T>",
				":Neotree diagnostics reveal bottom<CR>",
				{ noremap = true, silent = true }
			)

			vim.api.nvim_set_keymap(
				"n",
				"<S-O>",
				":Neotree close<CR>:Neotree reveal left<CR>",
				{ noremap = true, silent = true }
			)
		end,
	},
}
