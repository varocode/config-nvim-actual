-- ~/.config/nvim/lua/custom_scripts/react_tailwind_project.lua

local function create(name)
	local project_path = "~/Projects/" .. name

	-- Crear directorio del proyecto
	os.execute("mkdir -p " .. project_path)

	-- Inicializar npm en el proyecto
	os.execute("cd " .. project_path .. " && npm init -y")

	-- Instalar React y Tailwind CSS
	os.execute("cd " .. project_path .. " && npm install react react-dom")
	os.execute("cd " .. project_path .. " && npm install -D tailwindcss postcss autoprefixer && npx tailwindcss init")

	print("Proyecto React con Tailwind creado en " .. project_path)
end

return {
	create = create,
}
