return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ansiblels = {
          cmd = {
            os.getenv("HOME") .. "/.local/bin/ansible-language-server", "--stdio"
          },
        },
      },
    },
  },
}
