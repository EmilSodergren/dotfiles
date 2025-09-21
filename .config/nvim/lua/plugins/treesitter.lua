return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall", "TSInstallSync" },
    opts_extend = {},
    opts = {
      -- This is handled in the setup.py
      ensure_installed = {},
    }
  },
}
