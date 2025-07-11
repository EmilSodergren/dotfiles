return {
  { "rust-lang/rust.vim",       ft = "rust", },
  { "simrat39/rust-tools.nvim", ft = "rust", },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bacon_ls = { enabled = false },
        rust_analyzer = { enabled = true }
      }
    }
  }
}
