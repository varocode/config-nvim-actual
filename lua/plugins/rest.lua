-- lua/plugins/rest.lua
return {
	"rest-nvim/rest.nvim",
	ft = { "http" }, -- Solo cargar en archivos `.http`
	config = function()
		require("config-plugin.rest") -- Carga la configuración desde config-plugin/rest.lua
	end,
}
