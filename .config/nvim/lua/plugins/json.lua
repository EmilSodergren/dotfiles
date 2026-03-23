vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig", version = "master" },
})

vim.lsp.config("jsonls", {
  cmd = {
    os.getenv("HOME")
    .. "/.local/node_modules/vscode-langservers-extracted/bin/vscode-json-language-server",
    "--stdio",
  },
})

vim.lsp.enable("jsonls")
