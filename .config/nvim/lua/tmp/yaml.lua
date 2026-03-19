return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = {
          cmd = {
            os.getenv("HOME") .. "/.local/node_modules/yaml-language-server/bin/yaml-language-server",
            "--stdio",
          },
          filetypes = { 'yaml', 'yaml.ansible' },
          settings = {
            yaml = {
              format = {
                enable = true,
                singleQuote = true,
              },
              validate = true,
              hover = true,
              editor = {
                tabsize = 2,
                formatOnType = true,
              },
              completion = true,
            },
          },
        },
      },
    },
  },
}
