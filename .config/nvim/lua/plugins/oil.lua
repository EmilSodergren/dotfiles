return {
  {
    "stevearc/oil.nvim",
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
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    lazy = false,
  }
}
