if not pcall(require, "luasnip") then
  return
end

for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/swade/snips/ft/*.lua", true)) do
  loadfile(ft_path)()
end

vim.keymap.set("i", "<c-u>", require "luasnip.extras.select_choice")

-- shorcut to source my luasnips file again, which will reload my snippets
vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>")

