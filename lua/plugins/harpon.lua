return {
	"ThePrimeagen/harpoon",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")
		local term = require("harpoon.term")

		-- Configuración general de harpoon
		require("harpoon").setup({
			global_settings = {
				save_on_toggle = true, -- Guarda automáticamente cuando abres/cierras el menú
				save_on_change = true, -- Guarda cuando cambias el archivo marcado
				enter_on_sendcmd = true, -- Cambia automáticamente al nuevo directorio del proyecto
				close_on_select = false, -- Mantiene el menú abierto al seleccionar un archivo
			},
			menu = {
				width = vim.api.nvim_win_get_width(0) - 4, -- Ancho del menú de harpoon
				height = 10, -- Alto del menú de harpoon
			},
		})

		-- Atajos para añadir y gestionar archivos con Harpoon
		vim.keymap.set("n", "<leader>hn", mark.add_file, { desc = "Añadir archivo a Harpoon" }) -- Añadir archivo
		vim.keymap.set("n", "<leader>ha", ui.toggle_quick_menu, { desc = "Abrir menú de Harpoon" }) -- Menú rápido de Harpoon

		-- Atajos para navegar entre archivos marcados
		vim.keymap.set("n", "<leader>1", function()
			ui.nav_file(1)
		end, { desc = "Abrir archivo 1 de Harpoon" })
		vim.keymap.set("n", "<leader>2", function()
			ui.nav_file(2)
		end, { desc = "Abrir archivo 2 de Harpoon" })
		vim.keymap.set("n", "<leader>3", function()
			ui.nav_file(3)
		end, { desc = "Abrir archivo 3 de Harpoon" })
		vim.keymap.set("n", "<leader>4", function()
			ui.nav_file(4)
		end, { desc = "Abrir archivo 4 de Harpoon" })

		-- Atajos para moverse al siguiente o anterior archivo en Harpoon
		vim.keymap.set("n", "<C-n>", ui.nav_next, { desc = "Siguiente archivo de Harpoon" })
		vim.keymap.set("n", "<C-p>", ui.nav_prev, { desc = "Archivo anterior de Harpoon" })

		-- Atajos para abrir terminales configuradas en Harpoon (opcional)
		vim.keymap.set("n", "<leader>t1", function()
			term.gotoTerminal(1)
		end, { desc = "Abrir terminal 1 de Harpoon" })
		vim.keymap.set("n", "<leader>t2", function()
			term.gotoTerminal(2)
		end, { desc = "Abrir terminal 2 de Harpoon" })
		vim.keymap.set("n", "<leader>t3", function()
			term.gotoTerminal(3)
		end, { desc = "Abrir terminal 3 de Harpoon" })
		vim.keymap.set("n", "<leader>t4", function()
			term.gotoTerminal(4)
		end, { desc = "Abrir terminal 4 de Harpoon" })
	end,
}
