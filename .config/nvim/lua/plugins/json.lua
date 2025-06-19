return {
  {
    "elzr/vim-json",
    ft = "json"
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        jsonls = {
          cmd = {
            os.getenv("HOME")
            .. "/.local/node_modules/vscode-langservers-extracted/bin/vscode-json-language-server",
            "--stdio",
          },
        },
      },
    },
  },
}
