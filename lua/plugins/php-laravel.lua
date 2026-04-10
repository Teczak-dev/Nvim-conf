return {
	{
		"adalessa/laravel.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-neotest/nvim-nio",
		},
		ft = { "php", "blade" },
		event = {
			"BufRead *.php",
			"BufRead *.blade.php",
			"BufEnter composer.json",
			"BufEnter artisan",
		},
		cmd = { "Laravel" },
		keys = {
			{ "<leader>ll", function() require("laravel").pickers.laravel() end, desc = "Laravel: Open Laravel Picker" },
			{ "<leader>la", function() require("laravel").pickers.artisan() end, desc = "Laravel: Open Artisan Picker" },
			{ "<leader>lr", function() require("laravel").pickers.routes() end, desc = "Laravel: Open Routes Picker" },
			{ "<leader>lm", function() require("laravel").pickers.make() end, desc = "Laravel: Open Make Picker" },
			{ "<leader>lc", function() require("laravel").pickers.commands() end, desc = "Laravel: Open Commands Picker" },
			{ "<leader>lo", function() require("laravel").pickers.resources() end, desc = "Laravel: Open Resources Picker" },
			{ "<leader>lv", function() require("laravel").commands.run("view:finder") end, desc = "Laravel: Open View Finder" },
			{ "<leader>lt", function() require("laravel").commands.run("actions") end, desc = "Laravel: Open Actions Picker" },
		},
		opts = {
			features = {
				null_ls = {
					enable = false,
				},
				route_info = {
					enable = true,
				},
			},
		},
	},
	{
		"jwalton512/vim-blade",
		ft = "blade",
	},
	{
		-- PHP syntax highlighting improvements
		"StanAngeloff/php.vim",
		ft = "php",
		config = function()
			-- Enable PHP syntax features
			vim.g.php_syntax_extensions_enabled = { "bcmath", "bz2", "core", "curl", "date", "dom", "ereg", "gd", "gettext", "hash", "iconv", "json", "libxml", "mbstring", "mcrypt", "mhash", "mysql", "mysqli", "openssl", "pcre", "pdo", "pgsql", "phar", "posix", "session", "simplexml", "soap", "sockets", "sqlite3", "standard", "tokenizer", "wddx", "xml", "xmlreader", "xmlwriter", "zip", "zlib" }
			vim.g.php_htmlInStrings = 1
			vim.g.php_parent_error_close = 1
			vim.g.php_parent_error_open = 1
		end,
	},
}