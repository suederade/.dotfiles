local cmp = require('cmp')
local luasnip = require('luasnip')
--local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = cmp.mapping.preset.insert({
  --['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  --['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
  ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
  },
  ['<C-p>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
          cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
      else
          fallback()
      end
  end, { 'i', 's' }),
  ['<C-n>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
          cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
      else
          fallback()
      end
  end, { 'i', 's' }),
})

cmp_mappings['<S-Tab>'] = nil

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end
cmp_mappings["<Tab>"] = vim.schedule_wrap(function(fallback)
  if cmp.visible() and has_words_before() then
    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
  else
    fallback()
  end
end)

cmp.setup({
    -- snippet = {
    --     expand = function(args)
    --         require('luasnip').lsp_expand(args.body)
    --     end,
    -- },
    mapping = cmp_mappings,
    sources = {
        -- Copilot Source
        { name = "copilot", group_index = 2 },
        -- Other Sources
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
    },
    sorting = {
        priority_weight = 2,
        comparators = {
            require("copilot_cmp.comparators").prioritize,

            -- Below is the default comparitor list and order for nvim-cmp
            cmp.config.compare.offset,
            -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
    -- formatting = {
    --     format = function(entry, vim_item)
    --         vim_item.kind = lsp.protocol.CompletionItemKind[vim_item.kind]
    --         return vim_item
    --     end,
    -- },
})
