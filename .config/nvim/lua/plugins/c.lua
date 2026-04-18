vim.pack.add({ 
  { src = "https://github.com/neovim/nvim-lspconfig", version = "master" },
})

vim.lsp.enable("ccls")

vim.lsp.config("ccls", {
          cmd = { os.getenv("HOME") .. "/.local/bin/ccls" },
})
