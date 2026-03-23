vim.pack.add({
  { src = 'https://github.com/neovim/nvim-lspconfig', version = 'master' },
})

vim.lsp.config('pylsp', {
  cmd = {
    os.getenv("HOME") .. "/.local/bin/pylsp",
  },
  settings = {
    pylsp = {
      plugins = {
        autopep8 = { enabled = false },
        flake8 = { enabled = false },
        pydocstyle = { enabled = false },
        pycodestyle = { enabled = false },
        pylint = { enabled = true },
        yapf = { enabled = false },
        pylsp_mypy = { enabled = true },
      },
    },
  },
})

vim.lsp.config('ruff', {
  cmd = {
    os.getenv("HOME") .. "/.local/bin/ruff", "server",
  },
  init_options = {
    settings = {
      organizeImports = true,
      showSyntasErrors = true,
      format = {
        preview = true,
      },
    },
  },
})

vim.lsp.enable('pylsp')
vim.lsp.enable('ruff')
