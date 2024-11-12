local discipline = require("craftzdog.discipline")

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

vim.api.nvim_set_keymap("n", "<leader>hs", ":enew<CR>", { noremap = true, silent = true })

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

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

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

-- Mapeo para abrir una terminal en el directorio del archivo actual
vim.api.nvim_set_keymap("n", "<leader>ot", ":vsplit | terminal<CR>:lcd %:p:h<CR>", { noremap = true, silent = true })

-- Búsqueda desde la raíz del sistema
vim.api.nvim_set_keymap(
	"n",
	"<Space>fs",
	":lua require('telescope.builtin').find_files({ prompt_title = '< Buscar desde Raíz del Sistema >', cwd = '/', hidden = true })<CR>",
	{ noremap = true, silent = true }
)

-- Búsqueda desde el directorio home
vim.api.nvim_set_keymap(
	"n",
	"<Space>fh",
	":lua require('telescope.builtin').find_files({ prompt_title = '< Buscar desde Home >', cwd = vim.fn.expand('~'), hidden = true })<CR>",
	{ noremap = true, silent = true }
)

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
keymap.set("n", "<C-j>", function()
	vim.diagnostic.goto_next()
end, opts)

keymap.set("n", "<leader>r", function()
	require("craftzdog.hsl").replaceHexWithHSL()
end)

keymap.set("n", "<leader>i", function()
	require("craftzdog.lsp").toggleInlayHints()
end)
