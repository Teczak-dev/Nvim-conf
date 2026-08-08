return {
    "3rd/image.nvim",
    build = false,
    opts = {
        backend = "kitty", -- Ghostty używa protokołu Kitty Graphics
        processor = "magick_cli",
        integrations = {
            markdown = {
                enabled = true,
                clear_in_insert_mode = false,
                download_remote_images = true,
                only_render_image_at_cursor = false,
                filetypes = { "markdown", "vimwiki" },
            },
            neorg = {
                enabled = false,
            },
            html = {
                enabled = false,
            },
            css = {
                enabled = false,
            },
        },
        max_width = 80,
        max_height = 20,
        max_width_window_percentage = math.huge,
        max_height_window_percentage = math.huge,
        window_overlap_clear_enabled = true,
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        editor_only_render_when_focused = false,
        tmux_show_only_in_active_window = true,
        -- Reagujemy TYLKO na obrazy, całkowicie ignorujemy pliki PDF!
        hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" },
    },
}
