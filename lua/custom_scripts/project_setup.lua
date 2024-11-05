-- ~/.config/nvim/lua/custom_scripts/project_setup.lua

local function create_fullstack_project(name)
	-- Definir la ruta base para el proyecto
	local project_path = vim.fn.expand("~/Projects/" .. name)
	vim.fn.mkdir(project_path, "p") -- Crear la carpeta base para el proyecto

	-- Cambiar el directorio de trabajo a la carpeta del proyecto en Neovim
	vim.cmd("lcd " .. project_path)

	-- Crear la estructura básica del proyecto y mover los archivos al lugar correcto
	local commands = {
		-- Crear proyecto Vite + React dentro de 'client' usando npx
		"cd "
			.. project_path
			.. " && npx create-vite@latest client --template react",

		-- Instalar dependencias de Vite en 'client'
		"cd "
			.. project_path
			.. "/client && npm install",

		-- Crear estructura para el servidor y configuraciones básicas
		"mkdir -p "
			.. project_path
			.. "/server/controllers "
			.. project_path
			.. "/server/routes "
			.. project_path
			.. "/server/models "
			.. project_path
			.. "/server/config",

		-- Instalar dependencias de Node.js en 'server'
		"npm install express mysql2 dotenv --prefix "
			.. project_path
			.. "/server",
	}

	-- Ejecutar los comandos de shell
	for _, cmd in ipairs(commands) do
		vim.cmd("!" .. cmd)
	end

	print("Proyecto " .. name .. " creado exitosamente en " .. project_path)
end

-- Comando de Neovim para iniciar la creación de un proyecto
vim.api.nvim_create_user_command("CreateProject", function(opts)
	create_fullstack_project(opts.args)
end, { nargs = 1 })
