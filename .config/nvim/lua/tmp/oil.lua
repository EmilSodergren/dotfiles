return {
  {
    "stevearc/oil.nvim",
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    opts = {
      float = {
        padding = 3,
        max_width = 100,
        max_height = 50,
      },
    },
    keys = {
      { "-", ":Oil --float<CR>", desc = "Open parent directory" },
    },
    lazy = false,
  }
}
