-- lua/config-plugin/rest_keymaps.lua
local opts = { noremap = true, silent = true }

vim.api.nvim_create_autocmd("FileType", {
	pattern = "http",
	callback = function()
		local buff = tonumber(vim.fn.expand("<abuf>"), 10)
		opts.buffer = buff -- Hace los keymaps específicos del buffer

		-- Mapeos usando los comandos de usuario de `rest.nvim`
		vim.keymap.set("n", "<leader>rr", ":Rest run<CR>", opts)
		vim.keymap.set("n", "<leader>rl", ":Rest last<CR>", opts)
		vim.keymap.set("n", "<leader>rp", ":hor Rest run<CR>", opts) -- Previsualización
	end,
})
