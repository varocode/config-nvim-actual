-- ~/.config/nvim/lua/custom_scripts/project_selector.lua

-- ~/.config/nvim/lua/custom_scripts/project_selector.lua

local telescope = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.config").values.generic_sorter
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local function project_selector()
	local name = vim.fn.input("Nombre del proyecto: ")
	if name == "" then
		print("Creación de proyecto cancelada.")
		return
	end

	-- Define las opciones de proyecto y módulos correspondientes
	local project_types = {
		{ name = "Fullstack (React + Node.js)", module = "custom_scripts.fullstack_project" },
		{ name = "HTML, CSS y JavaScript", module = "custom_scripts.html_css_js_project" },
		{ name = "PHP", module = "custom_scripts.php_project" },
		{ name = "Python", module = "custom_scripts.python_project" },
		{ name = "React con Tailwind", module = "custom_scripts.react_tailwind_project" },
	}

	-- Crear lista de opciones para mostrar en Telescope
	local options = {}
	for _, proj in ipairs(project_types) do
		table.insert(options, proj.name)
	end

	-- Configurar la ventana de Telescope
	telescope
		.new({}, {
			prompt_title = "Selecciona el tipo de proyecto",
			finder = finders.new_table({
				results = options,
			}),
			sorter = sorters(),
			attach_mappings = function(prompt_bufnr, map)
				-- Mapear <CR> para seleccionar el proyecto
				actions.select_default:replace(function()
					local selection = action_state.get_selected_entry()
					actions.close(prompt_bufnr)

					-- Buscar el módulo y ejecutar la creación
					for _, proj in ipairs(project_types) do
						if proj.name == selection[1] then
							local project_module = require(proj.module)
							project_module.create(name)
							print("Proyecto '" .. name .. "' creado con la plantilla " .. proj.name)
							return
						end
					end
				end)
				return true
			end,
		})
		:find()
end

return {
	project_selector = project_selector,
}
