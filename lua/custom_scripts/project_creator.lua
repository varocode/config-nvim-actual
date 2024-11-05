local function create_project(name, type)
	local project_path = vim.fn.expand("~/Projects/" .. name)
	vim.fn.mkdir(project_path, "p")

	local commands = {}

	if type == "react_tailwind" then
		-- Crear un proyecto de React con Tailwind
		table.insert(commands, "cd " .. project_path .. " && npx create-vite@latest client --template react")
		table.insert(
			commands,
			"cd "
				.. project_path
				.. "/client && npm install && npm install -D tailwindcss postcss autoprefixer && npx tailwindcss init -p"
		)

		-- Configuración base de Tailwind en el proyecto
		vim.fn.writefile({
			"@tailwind base;",
			"@tailwind components;",
			"@tailwind utilities;",
		}, project_path .. "/client/src/index.css")
	elseif type == "html_css_js" then
		-- Crear un proyecto básico de HTML, CSS y JavaScript
		vim.fn.mkdir(project_path .. "/src", "p")
		vim.fn.writefile({
			"<!DOCTYPE html>",
			"<html>",
			"<head>",
			"<title>" .. name .. "</title>",
			"</head>",
			"<body>",
			"</body>",
			"</html>",
		}, project_path .. "/src/index.html")
		vim.fn.writefile({ "body { font-family: Arial, sans-serif; }" }, project_path .. "/src/style.css")
		vim.fn.writefile({ "console.log('Hello, World!');" }, project_path .. "/src/app.js")
	elseif type == "php" then
		-- Crear un proyecto básico de PHP
		vim.fn.mkdir(project_path .. "/public", "p")
		vim.fn.writefile({ "<?php", "echo 'Hello, World!';", "?>" }, project_path .. "/public/index.php")
	elseif type == "python" then
		-- Crear un proyecto básico de Python
		vim.fn.writefile({ "# " .. name, "print('Hello, World!')" }, project_path .. "/main.py")
		vim.fn.mkdir(project_path .. "/scripts", "p")
	end

	-- Ejecutar comandos en la terminal
	for _, cmd in ipairs(commands) do
		vim.cmd("!" .. cmd)
	end

	print("Proyecto " .. name .. " de tipo " .. type .. " creado exitosamente en " .. project_path)
end

local function project_creator_dialog()
	local name = vim.fn.input("Nombre del proyecto: ")
	if name == "" then
		print("Creación de proyecto cancelada.")
		return
	end

	local type = vim.fn.inputlist({
		"Seleccione el tipo de proyecto:",
		"1. React con Tailwind",
		"2. HTML, CSS y JavaScript",
		"3. PHP",
		"4. Python",
	})

	local project_type_map = {
		[1] = "react_tailwind",
		[2] = "html_css_js",
		[3] = "php",
		[4] = "python",
	}

	create_project(name, project_type_map[type])
end

-- Crear el comando en Neovim para invocar el diálogo de creación de proyecto
vim.api.nvim_create_user_command("NewProject", project_creator_dialog, {})
