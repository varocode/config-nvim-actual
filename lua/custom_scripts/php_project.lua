local function create(name)
	local project_path = vim.fn.expand("~/Projects/" .. name)
	vim.fn.mkdir(project_path, "p")

	-- Crear la estructura básica del proyecto PHP
	vim.fn.mkdir(project_path .. "/public", "p")
	vim.fn.writefile({
		"<?php",
		"echo 'Hello, World!';",
		"?>",
	}, project_path .. "/public/index.php")

	print("Proyecto PHP '" .. name .. "' creado exitosamente en " .. project_path)
end

return { create = create }
