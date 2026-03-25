vim.pack.add({
  { src = "https://github.com/iamcco/markdown-preview.nvim",              version = "v0.0.10" },
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim", version = "main" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter",           version = "main" },
  { src = "https://github.com/nvim-mini/mini.icons",                      version = "main" },
  { src = "https://github.com/neovim/nvim-lspconfig",                     version = "master" },
})

require("render-markdown").setup({})

vim.lsp.config("marksman", {
  cmd = {
    os.getenv("HOME") .. "/.local/bin/marksman",
    "server",
  },

})
vim.lsp.enable("marksman")
