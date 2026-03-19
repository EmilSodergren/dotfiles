return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pylsp = {
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
        },
        ruff = {
          cmd = {
            os.getenv("HOME") .. "/.local/bin/ruff", "server",
          },
          settings = {
            organizeImports = true,
            showSyntasErrors = true,
            format = {
              preview = true,
            },
          },
        },
      },
    },
  },
}
