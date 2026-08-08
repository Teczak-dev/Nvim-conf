-- lua/config/php.lua

-- PHP-specific autocommands and settings
local augroup = vim.api.nvim_create_augroup("PHP", { clear = true })

-- Better indentation for PHP
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = "php",
	callback = function()
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.expandtab = true
		vim.opt_local.autoindent = true
		vim.opt_local.smartindent = true
	end,
})

-- Blade template settings
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = "blade",
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.expandtab = true
		vim.opt_local.autoindent = true
		vim.opt_local.commentstring = "{{-- %s --}}"
	end,
})

-- Auto-detect Blade files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = augroup,
	pattern = "*.blade.php",
	callback = function()
		vim.bo.filetype = "blade"
	end,
})

-- Laravel-specific keybindings when in a Laravel project
vim.api.nvim_create_autocmd("BufEnter", {
	group = augroup,
	pattern = "*",
	callback = function()
		if vim.fn.findfile("artisan", ".;") ~= "" then
			-- Laravel project detected
			vim.keymap.set("n", "<leader>pa", ":!php artisan ", { desc = "Laravel: Run Artisan Command", buffer = true })
			vim.keymap.set("n", "<leader>pt", ":!php artisan test<CR>", { desc = "Laravel: Run Tests", buffer = true })
			vim.keymap.set("n", "<leader>pm", ":!php artisan migrate<CR>", { desc = "Laravel: Run Migrations", buffer = true })
		end
	end,
})