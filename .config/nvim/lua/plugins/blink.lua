return {
  "saghen/blink.cmp",
  lazy = false,
  opts = {
    keymap = {
      ["<C-u>"] = { "select_prev", "fallback" },
      ["<C-d>"] = { "select_next", "fallback" },
      ["<C-space>"] = { "show" },
    },
  },
}
