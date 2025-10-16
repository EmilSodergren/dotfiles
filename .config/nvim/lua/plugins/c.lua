return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ccls = {
          cmd = { os.getenv("HOME") .. "/.local/bin/ccls" },
        },
      },
    },
  },
}
