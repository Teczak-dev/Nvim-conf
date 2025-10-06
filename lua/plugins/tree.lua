return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup {}
		local api = require("nvim-tree.api")
		-- otwórz drzewo
		vim.keymap.set("n", "<leader>ot", api.tree.open, { desc = "NvimTree: Otwórz" })
		-- zamknij drzewo
		vim.keymap.set("n", "<leader>ct", api.tree.close, { desc = "NvimTree: Zamknij" })
	end,
}
