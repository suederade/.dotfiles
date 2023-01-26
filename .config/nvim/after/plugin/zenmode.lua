require("zen-mode").setup {
    window = {
        backdrop = 0.95,
        width = .85,
        options = {
            number = true,
            relativenumber = true,
        }
    },
    plugins = {
        tmux = { enabled = false }
    }
}

vim.keymap.set("n", "<leader>zz", function()
    require("zen-mode").toggle()
    vim.wo.wrap = false
end)
