vim.pack.add({
  -- { src = "https://github.com/rust-lang/rust.vim",  version = "master", },
  { src = "https://github.com/mrcjkb/rustaceanvim", version = vim.version.range("^8"), },
})

-- require("rust.vim").setup({})
-- require("rustaceanvim").setup({})
---@type rustaceanvim.Opts
vim.g.rustaceanvim = {
  server = {
    default_settings = {
      ['rust-analyzer'] = {
        inlayHints = {
          parameterHints = { enable = true, missingArguments = { enable = true } },
          typeHints = { enable = false, hideInferredTypes = true },
          renderColons = true,
        }
      }
    }
  }
}
