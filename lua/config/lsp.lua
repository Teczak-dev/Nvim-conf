vim.lsp.config('*', {
	root_markers = { '.git' },
})

vim.diagnostic.config({
	virtual_text  = true,
	severity_sort = true,
	float         = {
		style  = 'minimal',
		border = 'rounded',
		source = 'if_many',
		header = '',
		prefix = '',
	},
	signs         = {
		text = {
			[vim.diagnostic.severity.ERROR] = '✘',
			[vim.diagnostic.severity.WARN]  = '▲',
			[vim.diagnostic.severity.HINT]  = '⚑',
			[vim.diagnostic.severity.INFO]  = '»',
		},
	},
})

local orig = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts            = opts or {}
	opts.border     = opts.border or 'rounded'
	opts.max_width  = opts.max_width or 80
	opts.max_height = opts.max_height or 24
	opts.wrap       = opts.wrap ~= false
	return orig(contents, syntax, opts, ...)
end

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('my.lsp', { clear = true }),
	callback = function(args)
		local buf    = args.buf
		local map    = function(mode, lhs, rhs) vim.keymap.set(mode, lhs, rhs, { buffer = buf }) end

		map('n', 'K', vim.lsp.buf.hover)
		map('n', 'gd', vim.lsp.buf.definition)
		map('n', 'gD', vim.lsp.buf.declaration)
		map('n', 'gi', vim.lsp.buf.implementation)
		map('n', 'go', vim.lsp.buf.type_definition)
		map('n', 'gr', vim.lsp.buf.references)
		map('n', 'gs', vim.lsp.buf.signature_help)
		map('n', 'gl', vim.diagnostic.open_float)
		map('n', '<F2>', vim.lsp.buf.rename)
		map({ 'n', 'x' }, '<F3>', function()
			local ok, conform = pcall(require, "conform")
			if ok then
				conform.format({ async = true, lsp_format = "fallback" })
				return
			end
			vim.lsp.buf.format({ async = true })
		end)
		map('n', '<F4>', vim.lsp.buf.code_action)
	end,
})

local caps = vim.lsp.protocol.make_client_capabilities()
local ok_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if ok_cmp then
	caps = cmp_lsp.default_capabilities(caps)
end

vim.lsp.config['luals'] = {
	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
	root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
	capabilities = caps,
	settings = {
		Lua = {
			runtime = { version = 'LuaJIT' },
			diagnostics = { globals = { 'vim' } },
			workspace = {
				checkThirdParty = false,
				library = vim.api.nvim_get_runtime_file('', true),
			},
			telemetry = { enable = false },
		},
	},
}

vim.lsp.config['cssls'] = {
	cmd = { 'vscode-css-language-server', '--stdio' },
	filetypes = { 'css', 'scss', 'less' },
	root_markers = { 'package.json', '.git' },
	capabilities = caps,
	settings = {
		css  = { validate = true },
		scss = { validate = true },
		less = { validate = true },
	},
}

vim.lsp.config['phpls'] = {
	cmd = { 'intelephense', '--stdio' },
	filetypes = { 'php', 'blade' },
	root_markers = { 'composer.json', 'composer.lock', 'artisan', '.git' },
	capabilities = caps,
	settings = {
		intelephense = {
			files = {
				maxSize = 5000000,
				associations = { "*.php", "*.blade.php" },
				exclude = {
					"**/.git/**",
					"**/.DS_Store/**",
					"**/node_modules/**",
					"**/vendor/**/{Tests,tests}/**",
					"**/.history/**",
					"**/storage/**",
					"**/bootstrap/cache/**"
				},
			},
			environment = {
				includePaths = { "vendor/" },
			},
			stubs = {
				"apache", "bcmath", "bz2", "calendar", "com_dotnet", "Core",
				"ctype", "curl", "date", "dba", "dom", "enchant", "exif",
				"FFI", "fileinfo", "filter", "fpm", "ftp", "gd", "gettext",
				"gmp", "hash", "iconv", "imap", "intl", "json", "ldap",
				"libxml", "mbstring", "meta", "mysqli", "oci8", "odbc",
				"openssl", "pcntl", "pcre", "PDO", "pdo_ibm", "pdo_mysql",
				"pdo_pgsql", "pdo_sqlite", "pgsql", "Phar", "posix", "pspell",
				"readline", "Reflection", "session", "shmop", "SimpleXML",
				"snmp", "soap", "sockets", "sodium", "SPL", "sqlite3",
				"standard", "superglobals", "sysvmsg", "sysvsem", "sysvshm",
				"tidy", "tokenizer", "xml", "xmlreader", "xmlrpc", "xmlwriter",
				"xsl", "Zend OPcache", "zip", "zlib",
				"wordpress", "laravel"
			},
			completion = {
				fullyQualifyGlobalConstantsAndFunctions = false,
				insertUseDeclaration = true,
				triggerParameterHints = true,
			},
			format = {
				enable = true,
			},
		},
	},
}

vim.lsp.config['ts_ls'] = {
	cmd = { 'typescript-language-server', '--stdio' },
	filetypes = {
		'javascript', 'javascriptreact', 'javascript.jsx',
		'typescript', 'typescriptreact', 'typescript.tsx',
	},
	root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
	capabilities = caps,
	settings = {
		completions = { completeFunctionCalls = true },
	},
}

vim.lsp.config['clangd'] = {
	cmd = { 'clangd' },
	filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
	root_markers = { 'compile_commands.json', 'compile_flags.txt', 'CMakeLists.txt', 'Makefile', '.clangd', '.git' },
	capabilities = caps,
}

vim.lsp.config['pyright'] = {
	cmd = { 'pyright-langserver', '--stdio' },
	filetypes = { 'python' },
	root_markers = { 'pyproject.toml', 'requirements.txt', 'setup.py', 'setup.cfg', '.git' },
	capabilities = caps,
	settings = {
		python = {
			analysis = {
				typeCheckingMode = 'basic',
				autoImportCompletions = true,
			},
		},
	},
}
vim.lsp.config['rust_analyzer'] = {
	cmd = { 'rust-analyzer' },
	filetypes = { 'rust' },
	root_markers = { 'Cargo.toml', '.git' },
	capabilities = caps,
	settings = {
		['rust-analyzer'] = {
			cargo = {
				allFeatures = true,
			},
			check = {
				command = 'clippy',
			},
			completion = {
				addCallArgumentSnippets = true,
				addCallParenthesis = true,
			},
			diagnostics = {
				enable = true,
				experimental = { enable = true },
			},
			inlayHints = {
				enable = true,
				typeHints = true,
				parameterHints = true,
			},
		},
	},
}


for _, name in ipairs({ 'luals', 'cssls', 'ts_ls', 'phpls', 'clangd', 'pyright', 'rust_analyzer' }) do
	vim.lsp.enable(name)
end

vim.api.nvim_create_user_command('LspInfoCore', function()
	local bufnr   = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients({ buf = bufnr })
	if #clients == 0 then
		print('No LSP clients attached to this buffer')
		return
	end
	for _, c in ipairs(clients) do
		print(('%s (id=%d) root=%s'):format(c.name, c.id, c.root_dir or '?'))
	end
end, {})
