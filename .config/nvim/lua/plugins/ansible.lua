return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ansiblels = {
          cmd = {
            os.getenv("HOME") .. "/.local/node_modules/@ansible/ansible-language-server/bin/ansible-language-server",
            "--stdio"
          },
        },
      },
    },
  },
}
