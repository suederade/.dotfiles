vim.cmd(":set laststatus=3")
vim.cmd("let g:airline#extensions#tabline#enabled = 1")
vim.g.airline_powerline_fonts = 1
vim.g.airline_left_sep = ''
vim.g.airline_left_alt_sep = ''
vim.g.airline_right_sep = ''
vim.g.airline_right_alt_sep = ''
vim.g.airline_exclude_preview = 1
vim.cmd("let g:airline#extensions#tabline#exclude_preview = 1")
vim.g.airline_theme = "powerlineish"
vim.cmd(":set noshowmode")

--vim.g.airline_section_b = '%-0.10{getcwd()}'
--vim.g.airline_section_c = '%t'

