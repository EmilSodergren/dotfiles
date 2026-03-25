vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = vim.version.range("*") },
})

require("nvim-treesitter.configs").setup({
  highlight = { enable = true },
})
