return {
    'nvim-treesitter/nvim-treesitter',
    branch = "master",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            highlight = {
                enable = true,
            },
            indent = { enable = true },
            autotag = { enable = true },
            ensure_installed = {
                "lua",
                "tsx",
                "cpp",
                "python",
                "typescript",
                "javascript",
                "html",
                "css",
                "json",
                "php",
                "blade",
                "markdown",
                "markdown_inline",
            },
            auto_install = false,
        })
    end
}
