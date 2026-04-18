vim.pack.add({
  { src = "https://github.com/mrcjkb/rustaceanvim", version = vim.version.range("^9"), },
})

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
