vim.pack.add({
  { src = "https://github.com/jiaoshijie/undotree", version = "main" },
})

require("undotree").setup({})

vim.keymap.set("n", "<leader>u", require("undotree").toggle, { noremap = true, silent = true, desc = "Open UndooTree" })
