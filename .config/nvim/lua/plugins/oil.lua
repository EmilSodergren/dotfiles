vim.pack.add({
  { src = "https://github.com/stevearc/oil.nvim",    version = "master", name = "oil" },
  { src = "https://github.com/nvim-mini/mini.icons", version = "main" },
})

require("oil").setup({
  float = {
    padding = 3,
    max_width = 100,
    max_height = 50,
  },
})
vim.keymap.set("n", "-", ":Oil --float<CR>", { noremap = true, desc = "Open Oil file browser" })
