vim.pack.add({
        { src = 'https://github.com/L3MON4D3/LuaSnip',             version = vim.version.range("^2") },
        { src = 'https://github.com/rafamadriz/friendly-snippets', version = 'main' },
})

require('luasnip').setup({
        delete_check_events = "TextChanged",
})

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
