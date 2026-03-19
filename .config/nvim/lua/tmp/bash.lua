return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {
          cmd = {
            os.getenv("HOME") .. "/.local/node_modules/bash-language-server/out/cli.js",
            "start",
          },
        },
      },
    },
  },
}
