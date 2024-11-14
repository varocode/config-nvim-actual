return {
	-- messages, cmdline and the popupmenu
	{
		"folke/noice.nvim",
		opts = function(_, opts)
			table.insert(opts.routes, {
				filter = {
					event = "notify",
					find = "No information available",
				},
				opts = { skip = true },
			})
			local focused = true
			vim.api.nvim_create_autocmd("FocusGained", {
				callback = function()
					focused = true
				end,
			})
			vim.api.nvim_create_autocmd("FocusLost", {
				callback = function()
					focused = false
				end,
			})
			table.insert(opts.routes, 1, {
				filter = {
					cond = function()
						return not focused
					end,
				},
				view = "notify_send",
				opts = { stop = false },
			})

			opts.commands = {
				all = {
					-- options for the message history that you get with `:Noice`
					view = "split",
					opts = { enter = true, format = "details" },
					filter = {},
				},
			}

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function(event)
					vim.schedule(function()
						require("noice.text.markdown").keys(event.buf)
					end)
				end,
			})

			opts.presets.lsp_doc_border = true
		end,
	},

	{
		"rcarriga/nvim-notify",
		opts = {
			timeout = 5000,
		},
	},

	-- animations
	{
		"echasnovski/mini.animate",
		event = "VeryLazy",
		opts = function(_, opts)
			opts.scroll = {
				enable = false,
			}
		end,
	},

	-- buffer line
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
			{ "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
		},
		opts = {
			options = {
				mode = "tabs",
				-- separator_style = "slant",
				show_buffer_close_icons = false,
				show_close_icon = false,
			},
		},
	},

	-- filename
	{
		"b0o/incline.nvim",
		dependencies = { "craftzdog/solarized-osaka.nvim" },
		event = "BufReadPre",
		priority = 1200,
		config = function()
			local colors = require("solarized-osaka.colors").setup()
			require("incline").setup({
				highlight = {
					groups = {
						InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
						InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
					},
				},
				window = { margin = { vertical = 0, horizontal = 1 } },
				hide = {
					cursorline = true,
				},
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					if vim.bo[props.buf].modified then
						filename = "[+] " .. filename
					end

					local icon, color = require("nvim-web-devicons").get_icon_color(filename)
					return { { icon, guifg = color }, { " " }, { filename } }
				end,
			})
		end,
	},

	-- statusline
	{
		"nvim-lualine/lualine.nvim",
		opts = function(_, opts)
			local LazyVim = require("lazyvim.util")
			opts.sections.lualine_c[4] = {
				LazyVim.lualine.pretty_path({
					length = 0,
					relative = "cwd",
					modified_hl = "MatchParen",
					directory_hl = "",
					filename_hl = "Bold",
					modified_sign = "",
					readonly_icon = " 󰌾 ",
				}),
			}
		end,
	},

	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		opts = {
			plugins = {
				gitsigns = true,
				tmux = true,
				kitty = { enabled = false, font = "+2" },
				twilight = { enabled = true }, -- Enable twilight integration
			},
		},
		keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
	},

	-- {
	-- 	"nvimdev/dashboard-nvim",
	-- 	event = "VimEnter",
	-- 	opts = function(_, opts)
	-- 		local logo = [[
	--        ██╗   ██╗ █████╗ ██████╗  ██████╗        ██████╗ ██████╗ ██████╗ ███████╗
	--        ██║   ██║██╔══██╗██╔══██╗██╔═══██╗      ██╔════╝██╔═══██╗██╔══██╗██╔════╝
	--        ██║   ██║███████║██████╔╝██║   ██║█████╗██║     ██║   ██║██║  ██║█████╗
	--        ╚██╗ ██╔╝██╔══██║██╔══██╗██║   ██║╚════╝██║     ██║   ██║██║  ██║██╔══╝
	--         ╚████╔╝ ██║  ██║██║  ██║╚██████╔╝      ╚██████╗╚██████╔╝██████╔╝███████╗
	--          ╚═══╝  ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝        ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝
	--
	--        ,---,---,---,---,---,---,---,---,---,---,---,---,---,-------,
	--        | ~ | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 0 | [ | ] | <-    |
	--        |---'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-----|
	--        | ->| | " | , | . | P | Y | F | G | C | R | L | / | = |  \  |
	--        |-----',--',--',--',--',--',--',--',--',--',--',--',--'-----|
	--        | Caps | A | O | E | U | I | D | H | T | N | S | - |  Enter |
	--        |------'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'--------|
	--        |        | ; | Q | J | K | X | B | M | W | V | Z |          |
	--        |------,-',--'--,'---'---'---'---'---'---'-,-'---',--,------|
	--        | ctrl |  | alt |                          | alt  |  | ctrl |
	--        '------'  '-----'--------------------------'------'  '------'
	--      ]]
	--
	-- 		logo = string.rep("\n", 8) .. logo .. "\n\n"
	-- 		opts.config.header = vim.split(logo, "\n")
	-- 	end,
	-- },
	------------------------------------------------------------------------
	-- {
	-- 	"nvimdev/dashboard-nvim",
	-- 	event = "VimEnter",
	-- 	opts = function(_, opts)
	-- 		local logo = [[
	--        ██╗   ██╗ █████╗ ██████╗  ██████╗        ██████╗ ██████╗ ██████╗ ███████╗
	--        ██║   ██║██╔══██╗██╔══██╗██╔═══██╗      ██╔════╝██╔═══██╗██╔══██╗██╔════╝
	--        ██║   ██║███████║██████╔╝██║   ██║█████╗██║     ██║   ██║██║  ██║█████╗
	--        ╚██╗ ██╔╝██╔══██║██╔══██╗██║   ██║╚════╝██║     ██║   ██║██║  ██║██╔══╝
	--         ╚████╔╝ ██║  ██║██║  ██║╚██████╔╝      ╚██████╗╚██████╔╝██████╔╝███████╗
	--          ╚═══╝  ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝        ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝
	--
	--        ,---,---,---,---,---,---,---,---,---,---,---,---,---,-------,
	--        | ~ | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 0 | [ | ] | <-    |
	--        |---'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-----|
	--        | ->| | " | , | . | P | Y | F | G | C | R | L | / | = |  \  |
	--        |-----',--',--',--',--',--',--',--',--',--',--',--',--'-----|
	--        | Caps | A | O | E | U | I | D | H | T | N | S | - |  Enter |
	--        |------'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'-,-'--------|
	--        |        | ; | Q | J | K | X | B | M | W | V | Z |          |
	--        |------,-',--'--,'---'---'---'---'---'---'-,-'---',--,------|
	--        | ctrl |  | alt |                          | alt  |  | ctrl |
	--        '------'  '-----'--------------------------'------'  '------'
	--      ]]
	--
	-- 		logo = string.rep("\n", 8) .. logo .. "\n\n"
	-- 		opts.config.header = vim.split(logo, "\n")
	-- 	end,
	-- },

	{
		"nvimdev/dashboard-nvim",
		opts = {
			theme = "hyper",
			config = {
				-- Configuración del encabezado con ASCII art

				header = {
					"                                                                                 ",
					"        ██╗   ██╗ █████╗ ██████╗  ██████╗        ██████╗ ██████╗ ██████╗ ███████╗",
					"        ██║   ██║██╔══██╗██╔══██╗██╔═══██╗      ██╔════╝██╔═══██╗██╔══██╗██╔════╝",
					"        ██║   ██║███████║██████╔╝██║   ██║█████╗██║     ██║   ██║██║  ██║█████╗  ",
					"        ╚██╗ ██╔╝██╔══██║██╔══██╗██║   ██║╚════╝██║     ██║   ██║██║  ██║██╔══╝  ",
					"         ╚████╔╝ ██║  ██║██║  ██║╚██████╔╝      ╚██████╗╚██████╔╝██████╔╝███████╗",
					"          ╚═══╝  ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝        ╚═════╝ ╚═════╝ ╚══════╝ ╚══════╝",
					"",
					"「成長は毎日の小さな努力の積み重ねです」", -- Frase en japonés
					"El crecimiento es la acumulación de pequeños esfuerzos diarios",
					"                                                               ",
				},

				-- Configuración de los atajos de teclado (botones) en el centro
				shortcut = {
					{
						desc = "📂 Find File ",
						key = "f",
						icon = "",
						action = "Telescope find_files",
						group = "@markup.heading.1.markdown",
					},
					{
						desc = "Find Word ",
						key = "w",
						icon = " ",
						action = "Telescope live_grep",
						group = "@markup.heading.3.markdown",
					},
					{
						desc = "🛠 Update Plugins ",
						key = "u",
						icon = "",
						action = "Lazy update",
						group = "@markup.heading.2.markdown",
					},
					{
						desc = "Install Language ",
						key = "l",
						icon = " ",
						action = "Mason",
						group = "@markup.heading.2.markdown",
					},
					{
						desc = "Lazy Extras ",
						key = "L",
						icon = "🛠 ",
						action = "LazyExtras",
						group = "@markup.heading.2.markdown",
					},

					{
						desc = "🔧 Open Config Folder ",
						key = "c",
						icon = "",
						action = "Telescope find_files cwd=~/.config/nvim",
						group = "@markup.heading.2.markdown",
					},
					{
						desc = "Open Projects",
						key = "p",
						icon = " ",
						action = "NeovimProjectDiscover", -- Asegúrate de que este comando exista y funcione en el plugin neovim-project
						group = "@markup.heading.1.markdown",
					},
					{
						desc = "Exit ",
						key = "q",
						icon = " ",
						action = "exit",
						group = "@markup.heading.6.markdown",
					},
				},

				-- Agrega una sección para mostrar archivos recientes
				sections = {
					recent_projects = true,
					recent_files = true,
				},

				-- Configuración del pie de página
				footer = {
					"",
					"🌐  GitHub: https://github.com/varocode",
					"🔍  Version de Neovim: " .. vim.version().major .. "." .. vim.version().minor,
					"                  💖                    ",
					"━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
					"    Disfruta cada línea de código! ✨   ",
				},

				-- Opciones adicionales
				packages = { enable = true }, -- Mostrar el número de paquetes cargados
			},
		},
	},
}
