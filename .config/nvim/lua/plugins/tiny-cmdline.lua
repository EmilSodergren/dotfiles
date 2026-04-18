vim.pack.add({
  { src = "https://github.com/rachartier/tiny-cmdline.nvim", version = "main" },
})

require("tiny-cmdline").setup({
  position = {
    x = "30%",
    y = "80%"
  },
  native_types = {},
  on_reposition = require("tiny-cmdline").adapters.blink,
})
