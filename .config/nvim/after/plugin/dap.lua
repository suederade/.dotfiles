vim.keymap.set('n', '<F5>', ":lua require'dap'.continue()<CR>", { silent = true })
vim.keymap.set('n', '<F10>', ":lua require'dap'.step_over()<CR>", { silent = true })
vim.keymap.set('n', '<F11>', ":lua require'dap'.step_into()<CR>", { silent = true })
vim.keymap.set('n', '<F12>', ":lua require'dap'.step_out()<CR>", { silent = true })
vim.keymap.set('n', '<leader>b', ":lua require'dap'.toggle_breakpoint()<CR>", { silent = true })
vim.keymap.set('n', '<leader>B', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", { silent = true })
vim.keymap.set('n', '<leader>lp', ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", { silent = true })
vim.keymap.set('n', '<leader>dr', ":lua require'dap'.repl.open()<CR>", { silent = true })
vim.keymap.set('n', '<leader>dl', ":lua require'dap'.run_last()<CR>", { silent = true })
vim.keymap.set('n', '<leader>td', ":lua require('dap-go').debug_test()<CR>", { silent = true })

require("nvim-dap-virtual-text").setup()
require('dap-go').setup()
require("dapui").setup()

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
