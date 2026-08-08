return {
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUpdate" },
		opts = {},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = "VeryLazy",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				"clangd",
				"intelephense",
				"prettierd",
				"prettier",
				"stylua",
				"clang-format",
				"php-cs-fixer",
			},
			auto_update = false,
			run_on_start = true,
			start_delay = 1500,
			debounce_hours = 12,
		},
	},
}
