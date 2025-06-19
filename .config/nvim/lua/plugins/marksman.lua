return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        marksman = {
          cmd = {
            os.getenv("HOME") .. "/.local/bin/marksman",
            "server",
          },
        },
      },
    },
  },
}
