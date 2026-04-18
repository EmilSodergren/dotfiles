vim.pack.add({
  { src = "https://github.com/nvim-mini/mini.ai",         version = "stable" },
  { src = "https://github.com/nvim-mini/mini.comment",    version = "stable" },
  { src = "https://github.com/nvim-mini/mini.cursorword", version = "stable" },
  { src = "https://github.com/nvim-mini/mini.tabline",    version = "stable" },
  { src = "https://github.com/nvim-mini/mini.icons",      version = "stable" },
  { src = "https://github.com/nvim-mini/mini.statusline", version = "stable" },
  { src = "https://github.com/nvim-mini/mini.files",      version = "stable" },
  { src = "https://github.com/nvim-mini/mini.pairs",      version = "stable" },
  { src = "https://github.com/nvim-mini/mini.clue",       version = "stable" },
  { src = "https://github.com/nvim-mini/mini.trailspace", version = "stable" },
})

require("mini.ai").setup()
require("mini.comment").setup()
require("mini.cursorword").setup()
require("mini.tabline").setup()
require("mini.icons").setup()
require("mini.statusline").setup()
require("mini.files").setup()
require("mini.pairs").setup()
require("mini.trailspace").setup()
require("mini.clue").setup({
  triggers = {
    { mode = "n", keys = "<leader>" },
    { mode = "x", keys = "<leader>" },
    { mode = "n", keys = "[" },
    { mode = "n", keys = "]" },
    { mode = "n", keys = "g" },
    { mode = "x", keys = "g" },
  }
})
