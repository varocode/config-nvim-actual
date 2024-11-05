local function create(name)
	local project_path = vim.fn.expand("~/Projects/" .. name)
	vim.fn.mkdir(project_path, "p")

	-- Crear la estructura básica del proyecto Python
	vim.fn.writefile({
		"# " .. name,
		"print('Hello, World!')",
	}, project_path .. "/main.py")
	vim.fn.mkdir(project_path .. "/scripts", "p")

	print("Proyecto Python '" .. name .. "' creado exitosamente en " .. project_path)
end

return { create = create }
