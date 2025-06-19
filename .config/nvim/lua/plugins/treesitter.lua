return {
  "nvim-treesitter/nvim-treesitter",
  build = "",
  lazy = false,
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall", "TSInstallSync" },
  opts_extend = {},
  opts = {
    ensure_installed = {},
  }
}
