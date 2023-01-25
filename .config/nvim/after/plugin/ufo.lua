vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

local function peekOrHover()
    local winid = require('ufo').peekFoldedLinesUnderCursor()
    if winid then
        local bufnr = vim.api.nvim_win_get_buf(winid)
        local keys = {'a', 'i', 'o', 'A', 'I', 'O', 'gd', 'gr'}
        for _, k in ipairs(keys) do
            -- Add a prefix key to fire `trace` action,
            -- if Neovim is 0.8.0 before, remap yourself
            vim.keymap.set('n', k, '<CR>' .. k, {noremap = false, buffer = bufnr})
        end
    else
        -- nvimlsp
        vim.lsp.buf.hover()
    end
end

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
vim.keymap.set('n', 'zk', peekOrHover)

-- Option 2: nvim lsp as LSP client
-- Tell the server the capability of foldingRange,
-- Neovim hasn't added foldingRange to default capabilities, users must add it manually
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.foldingRange = {
--     dynamicRegistration = false,
--     lineFoldingOnly = true
-- }
-- local language_servers = require("lspconfig").util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
-- for _, ls in ipairs(language_servers) do
--     require('lspconfig')[ls].setup({
--         capabilities = capabilities
--         -- you can add other fields for setting up lsp server in this table
--     })
-- end
-- require('ufo').setup()
--

local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = ('  %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, {chunkText, hlGroup})
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, {suffix, 'MoreMsg'})
    return newVirtText
end

local function customizeFoldText()
    -- global handler
    require('ufo').setup({
        fold_virt_text_handler = handler
    })
end

local function customizeBufFoldText()
    -- buffer scope handler
    -- will override global handler if it is existed
    local bufnr = vim.api.nvim_get_current_buf()
    require('ufo').setFoldVirtTextHandler(bufnr, handler)
end

-- lsp->treesitter->indent
local function selectProviderWithChainByDefault()
    local ftMap = {
        vim = 'indent',
        python = {'indent'},
        git = ''
    }

    ---@param bufnr number
    ---@return Promise
    local function customizeSelector(bufnr)
        local function handleFallbackException(err, providerName)
            if type(err) == 'string' and err:match('UfoFallbackException') then
                return require('ufo').getFolds(bufnr, providerName)
            else
                return require('promise').reject(err)
            end
        end

        return require('ufo').getFolds(bufnr, 'lsp'):catch(function(err)
            return handleFallbackException(err, 'treesitter')
        end):catch(function(err)
            return handleFallbackException(err, 'indent')
        end)
    end

    require('ufo').setup({
        provider_selector = function(bufnr, filetype, buftype)
            return ftMap[filetype] or customizeSelector
        end
    })
end

customizeFoldText()
customizeBufFoldText()
selectProviderWithChainByDefault()

-- Option 3: treesitter as a main provider instead
-- Only depend on `nvim-treesitter/queries/filetype/folds.scm`,
-- performance and stability are better than `foldmethod=nvim_treesitter#foldexpr()`
require('ufo').setup({
    --provider_selector = function(bufnr, filetype, buftype)
    --provider_selector = function()
    --    return {'treesitter', 'indent'}
    --end,
    --fold_virt_text_handler = handler
})
--
