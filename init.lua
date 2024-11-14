if vim.loader then
	vim.loader.enable()
end

_G.dd = function(...)
	require("util.debug").dump(...)
end
vim.print = _G.dd

vim.opt.wrap = true -- Aquí activas el wrap

-- Configuración de opciones de sesión
vim.o.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,localoptions"

require("config.lazy")

-- Cargar la configuración de DAP
require("plugins.dap")
