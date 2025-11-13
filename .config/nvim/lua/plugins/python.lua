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
                yapf = { enabled = true },
                pylsp_mypy = { enabled = true },
              },
            },
          },
        },
      },
    },
  },
}
