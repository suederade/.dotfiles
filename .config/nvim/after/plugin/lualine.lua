-- Set lualine as statusline
-- See `:help lualine.txt`

vim.cmd(':set noshowmode')

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'gruvbox-material',
        component_separators = '|',
        section_separators = { left = '', right = ''},
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {
            {
                'filename',
                file_status = true,
                newfile_status = false,
                path = 1
            }
        },
        lualine_x = {},
        lualine_y = {"os.date('%I:%m %p')"},
        lualine_z = {'fileformat', 'filetype',},
    },
    winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    },
    inactive_winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    }
}

