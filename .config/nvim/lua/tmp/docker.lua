return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        dockerls = {
          cmd = {
            os.getenv("HOME")
            .. "/.local/node_modules/dockerfile-language-server-nodejs/bin/docker-langserver",
            "--stdio",
          },
        },
      },
    },
  },
}
