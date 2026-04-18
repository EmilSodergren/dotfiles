vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "LuaSnip" and kind ~= "delete" then
      local install_cmd = "make -C " .. ev.data.path .. " install_jsregexp"
      os.execute(install_cmd)
    end
  end
})

vim.pack.add({
  { src = "https://github.com/L3MON4D3/LuaSnip",             version = vim.version.range("^2") },
  { src = "https://github.com/rafamadriz/friendly-snippets", version = "main" },
})

require("luasnip").setup({
  delete_check_events = "TextChanged",
})

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
