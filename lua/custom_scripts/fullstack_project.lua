-- ~/.config/nvim/lua/custom_scripts/fullstack_project.lua

local function create(name)
	local project_path = vim.fn.expand("~/Projects/" .. name)
	vim.fn.mkdir(project_path, "p")

	-- Comandos de configuración inicial
	local commands = {
		"cd " .. project_path .. " && npx create-vite@latest client --template react",
		"cd " .. project_path .. "/client && npm install",
		"mkdir -p "
			.. project_path
			.. "/server/controllers "
			.. project_path
			.. "/server/routes "
			.. project_path
			.. "/server/models "
			.. project_path
			.. "/server/config",
		"npm install express mysql2 dotenv --prefix " .. project_path .. "/server",
	}

	-- Ejecutar cada comando de configuración en secuencia
	for _, cmd in ipairs(commands) do
		local result = vim.fn.system(cmd)
		if vim.v.shell_error ~= 0 then
			print("Error ejecutando: " .. cmd)
			print(result)
			return -- Abortamos si ocurre algún error
		end
	end

	-- Crear archivo básico para el servidor Node.js en `index.js`
	local server_code = [[
const express = require('express');
const app = express();
const PORT = 3001;

app.get('/', (req, res) => {
    res.send('Servidor de Node.js funcionando correctamente');
});

app.listen(PORT, () => {
    console.log(`Servidor de Node.js escuchando en http://localhost:${PORT}`);
});
]]

	-- Escribir `index.js` en la carpeta del servidor
	local index_path = project_path .. "/server/index.js"
	local file = io.open(index_path, "w")
	file:write(server_code)
	file:close()

	print("Proyecto " .. name .. " creado exitosamente en " .. project_path)

	-- Comandos para iniciar los servidores en ventanas de Kitty y abrir navegadores
	local start_commands = {
		{
			cmd = "kitty --hold --title 'React Server' bash -c 'cd " .. project_path .. "/client && npm run dev'",
			port = 5173,
		},
		{
			cmd = "kitty --hold --title 'Node.js Server' bash -c 'cd " .. project_path .. "/server && node index.js'",
			port = 3001,
		},
	}

	-- Función para verificar si el puerto está activo antes de abrir el navegador
	local function wait_for_port(port)
		local cmd = "lsof -i :" .. port
		local tries = 0
		while tries < 10 do
			local handle = io.popen(cmd)
			local result = handle:read("*a")
			handle:close()
			if result and result ~= "" then
				return true
			end
			tries = tries + 1
			vim.cmd("sleep 1000m") -- Espera 1 segundo antes de reintentar
		end
		return false
	end

	-- Ejecutar cada servidor y abrir el navegador después de confirmar que el servidor está activo
	for _, srv in ipairs(start_commands) do
		print("Iniciando servidor en: " .. srv.cmd)
		vim.fn.jobstart(srv.cmd, { detach = true })
		if wait_for_port(srv.port) then
			print("Servidor en puerto " .. srv.port .. " está activo.")
			local url = "http://localhost:" .. srv.port
			vim.fn.jobstart("firefox " .. url, { detach = true })
		else
			print("Error: El servidor en el puerto " .. srv.port .. " no pudo iniciar.")
		end
	end
end

return { create = create }
