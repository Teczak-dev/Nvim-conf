vim.g.mapleader = " "
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)

-- Wciśnięcie <leader>pv otwiera natywny podgląd macOS dla pliku pod kursorem
vim.keymap.set("n", "<leader>pv", function()
    local file = vim.fn.expand("%:p")
    if file ~= "" then
        vim.fn.jobstart({ "qlmanage", "-p", file }, { detach = true })
    end
end, { desc = "QuickLook podgląd pliku" })

vim.keymap.set("n", "<leader>r", ":!./run.sh<CR>", { desc = "Build & Run" })
vim.keymap.set("n", "<leader>d", ":split | term ./run.sh debug<CR>", { desc = "Debug Game" })
