local function create(name)
	-- Usar os.getenv("HOME") en lugar de ~ para la ruta del directorio de inicio
	local base_path = os.getenv("HOME") .. "/Projects"
	local project_path = tostring(base_path .. "/" .. name) -- Convertir a string explícitamente

	-- Verificar si la carpeta base Projects existe, y crearla si no existe
	os.execute("[ -d " .. base_path .. " ] || mkdir -p " .. base_path)

	-- Crear directorio del proyecto
	os.execute("mkdir -p " .. project_path)

	-- Crear estructura de directorios y archivos para HTML, CSS y JS
	os.execute("mkdir -p " .. project_path .. "/css")
	os.execute("mkdir -p " .. project_path .. "/js")
	os.execute("touch " .. project_path .. "/index.html")
	os.execute("touch " .. project_path .. "/css/styles.css")
	os.execute("touch " .. project_path .. "/js/scripts.js")

	print("Proyecto HTML, CSS y JavaScript creado en " .. project_path)
end

return {
	create = create,
}
