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
                pylint = { enabled = true },
                yapf = { enabled = true },
              },
            },
          },
        },
        pyright = {
          mason = false,
          autostart = false,
        },
        ruff = {
          mason = false,
          autostart = false,
        },
        ruff_lsp = {
          mason = false,
          autostart = false,
        }
      },
    },
  },
}
