return {
  {
    "ray-x/go.nvim",
    ft = { "go", "gomod" },
    opts = {},
    build = ":lua require('go.install').update_all_sync()"
  },
  {
    "ray-x/guihua.lua",
    ft = "go",
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          cmd = { os.getenv("HOME") .. "/go/bin/gopls" },
          settings = {
            gopls = {
              hints = {
                assignVariableTypes = false,
                compositeLiteralFields = false,
                compositeLiteralTypes = false,
                constantValues = false,
                functionTypeParameters = false,
                parameterNames = false,
                rangeVariableTypes = false,
              },
            },
          },
        },
        golangci_lint_ls = {
          cmd = { os.getenv("HOME") .. "/go/bin/golangci-lint-langserver" },
          root_dir = function(bufnr, ondir)
            local fname = vim.api.nvim_buf_get_name(bufnr)
            ondir(require("lspconfig.util").root_pattern("go.mod", "go.work", ".git")(fname))
          end,
          init_options = {
            command = { "golangci-lint", "run", "--output.json.path=stdout", "--show-stats=false" },
          },
        },
      },
    },
  },
}
