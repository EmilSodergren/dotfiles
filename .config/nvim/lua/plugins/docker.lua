vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig", version = "master" },
})

vim.lsp.enable("dockerls")

vim.lsp.config("dockerls", {
  cmd = {
    os.getenv("HOME")
    .. "/.local/node_modules/dockerfile-language-server-nodejs/bin/docker-langserver",
    "--stdio",
  },
  root_markers = { "Dockerfile", "Dockerfile.docker.txt" }
})
