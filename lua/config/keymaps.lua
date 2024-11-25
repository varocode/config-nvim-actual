local discipline = require("varocode.discipline")

discipline.cowboy()

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- -- Atajo de teclado que define la función directamente
-- vim.api.nvim_set_keymap(
-- 	"n",
-- 	"<leader>np",
-- 	[[:lua local project_name = vim.fn.input("Project Name: ") if project_name ~= "" then vim.cmd("CreateProject " .. project_name) print("Proyecto '" .. project_name .. "' creado exitosamente.") else print("Creación de proyecto cancelada.") end<CR>]],
-- 	{ noremap = true, silent = true, desc = "New Project Dialog" }
-- )
--
-- vim.api.nvim_set_keymap(
-- 	"n",
-- 	"<leader>na",
-- 	":NewProject<CR>",
-- 	{ noremap = true, silent = true, desc = "New Project Dialog" }
-- )
--
-- -- Atajo de teclado para el selector de proyectos
-- vim.api.nvim_set_keymap(
-- 	"n",
-- 	"<leader>nx",
-- 	":NewProject<CR>",
-- 	{ noremap = true, silent = true, desc = "Nuevo Proyecto" }
-- )

-- Atajo de teclado para iniciar el selector de proyectos
vim.api.nvim_set_keymap(
	"n",
	"<leader>np",
	":NewProject<CR>",
	{ noremap = true, silent = true, desc = "Crear un nuevo proyecto" }
)

vim.api.nvim_set_keymap("n", "<leader>dd", ":Dashboard<CR>", { noremap = true, silent = true })

-------------------------------------------------------------------------------
-- Mapea los atajos de teclado para cada función en modo normal con <leader>h
vim.api.nvim_set_keymap("n", "<leader>hp", ":Telescope neovim-project<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>hh", ":Telescope project<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>hf", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>hg", ":Telescope live_grep<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>hr", ":Telescope oldfiles<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>hd", ":NeovimProjectDiscover<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>hl", ":NeovimProjectLoadRecent<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>hh", ":NeovimProjectHistory<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>hs", ":NeovimProjectLoadHist<CR>", { noremap = true, silent = true })

-- Descripciones de los mapeos
-- <leader>hp - Abre el selector de proyectos con neovim-project
-- <leader>hh - Cambia entre proyectos configurados con project.nvim
-- <leader>hf - Abre la búsqueda de archivos en el proyecto actual
-- <leader>hg - Abre la búsqueda de texto dentro de archivos (live_grep)
-- <leader>hr - Abre archivos recientes
-- <leader>hd - Descubre proyectos automáticamente en carpetas configuradas
-- <leader>hl - Carga la última sesión de proyecto
-- <leader>hh - Muestra el historial de proyectos recientes
-- <leader>hs - Carga un proyecto del historial

-- Mapeos dentro de Telescope para eliminar proyectos
vim.api.nvim_set_keymap(
	"i",
	"<C-d>",
	"lua require('telescope').extensions['neovim-project'].delete_project()<CR>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>hd",
	"lua require('telescope').extensions['neovim-project'].delete_project()<CR>",
	{ noremap = true, silent = true }
)

-- vim.api.nvim_set_keymap("n", "<leader>hs", ":enew<CR>", { noremap = true, silent = true })

------------------------------------------------------------------------
-- lua/config/keymaps.lua
require("config-plugin.rest_keymaps") -- Carga los keymaps específicos de rest.nvim

-- Do things without affecting the registers
keymap.set("n", "x", '"_x')
keymap.set("n", "<Leader>p", '"0p')
keymap.set("n", "<Leader>P", '"0P')
keymap.set("v", "<Leader>p", '"0p')
keymap.set("n", "<Leader>c", '"_c')
keymap.set("n", "<Leader>C", '"_C')
keymap.set("v", "<Leader>c", '"_c')
keymap.set("v", "<Leader>C", '"_C')
keymap.set("n", "<Leader>d", '"_d')
keymap.set("n", "<Leader>D", '"_D')
keymap.set("v", "<Leader>d", '"_d')
keymap.set("v", "<Leader>D", '"_D')

-- Buscar caracteres en todo el buffer y resaltar coincidencias en tiempo real
keymap.set("n", "f", function()
	local char = ""
	vim.cmd("set hlsearch")
	while true do
		local new_char = vim.fn.getcharstr()
		if new_char == "\r" then
			break
		elseif new_char == "\b" then
			char = char:sub(1, -2)
		else
			char = char .. new_char
		end
		vim.cmd("let @/ = '" .. char .. "'")
		vim.cmd("redraw")
	end
	if vim.fn.search(char) == 0 then
		print("Pattern not found: " .. char)
	else
		vim.cmd("normal! n")
	end
end, { noremap = true, silent = true, desc = "Buscar caracteres en todo el buffer" })

-- abrir una terminal en la parte inferior
vim.api.nvim_set_keymap(
	"n",
	"<leader>rt",
	":split | terminal<CR>",
	{ noremap = true, silent = true, desc = "Abrir terminal en la parte inferior" }
)

------------------------------------------------------
-- Increment/decrement
-- keymap.set("n", "+", "<C-a>")
-- keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- Diagnostics
keymap.set("n", "<C-,>", function()
	vim.diagnostic.goto_next()
end, opts)

keymap.set("n", "<leader>r", function()
	require("varocode.hsl").replaceHexWithHSL()
end)

keymap.set("n", "<leader>i", function()
	require("varocode.lsp").toggleInlayHints()
end)

----- OBSIDIAN -----
vim.keymap.set(
	"n",
	"<leader>oc",
	"<cmd>lua require('obsidian').util.toggle_checkbox()<CR>",
	{ desc = "Obsidian Check Checkbox" }
)
vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianTemplate<CR>", { desc = "Insert Obsidian Template" })
vim.keymap.set("n", "<leader>oo", "<cmd>ObsidianOpen<CR>", { desc = "Open in Obsidian App" })
vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", { desc = "Show ObsidianBacklinks" })
vim.keymap.set("n", "<leader>ol", "<cmd>ObsidianLinks<CR>", { desc = "Show ObsidianLinks" })
vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "Create New Note" })
vim.keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<CR>", { desc = "Search Obsidian" })
vim.keymap.set("n", "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Quick Switch" })

-- Map Ctrl+b in insert mode to delete to the end of the word without leaving insert mode
vim.keymap.set("i", "<C-[>", "<C-o>de")

-- Map Ctrl+c to escape from other modes
vim.keymap.set({ "i", "n", "v" }, "<C-c>", [[<C-\><C-n>]])

----- Tmux Navigation ------
local nvim_tmux_nav = require("nvim-tmux-navigation")

vim.keymap.set("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft) -- Navigate to the left pane
vim.keymap.set("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown) -- Navigate to the bottom pane
vim.keymap.set("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp) -- Navigate to the top pane
vim.keymap.set("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight) -- Navigate to the right pane
vim.keymap.set("n", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive) -- Navigate to the last active pane
vim.keymap.set("n", "<C-;>", nvim_tmux_nav.NvimTmuxNavigateNext) -- Navigate to the next pane

-- Configuración del atajo de teclado para abrir Oil
vim.api.nvim_set_keymap("n", "-", ":Oil<CR>", { noremap = true, silent = true })
