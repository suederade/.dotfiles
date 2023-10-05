local todo = require('todo-comments')
vim.keymap.set('n', '<leader>td', ':TodoTelescope', { desc = '[T]o[D]o Telescope' })
vim.keymap.set('n', '<leader>tdn', todo.jump_next, { desc = '[T]o[D]o [N]ext' })
vim.keymap.set('n', '<leader>tdp', todo.jump_prev, { desc = '[T]o[D]o [P]revious' })
