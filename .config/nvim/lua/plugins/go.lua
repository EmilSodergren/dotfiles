vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig", version = "master" },
})

vim.lsp.enable("gopls")
vim.lsp.enable("golangci_lint_ls")

vim.lsp.config("gopls", {
  cmd = { os.getenv("HOME") .. "/go/bin/gopls" },
  settings = {
    gopls = {
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
})
vim.lsp.config("golangci_lint_ls", {
  cmd = { os.getenv("HOME") .. "/go/bin/golangci-lint-langserver" },
  root_dir = function(bufnr, ondir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    ondir(require("lspconfig.util").root_pattern("go.mod", "go.work", ".git")(fname))
  end,
  init_options = {
    command = { "golangci-lint", "run", "--output.json.path=stdout", "--show-stats=false" },
  },
  diagnostics = true,
})
