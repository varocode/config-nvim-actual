return {
	"github/copilot.vim",
	config = function()
		vim.g.copilot_no_tab_map = true
		vim.g.copilot_enabled = true
		vim.g.copilot_icon = "" -- Puedes cambiar este icono por el que prefieras
		vim.api.nvim_set_keymap("i", "<C-Tab>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
	end,
}
