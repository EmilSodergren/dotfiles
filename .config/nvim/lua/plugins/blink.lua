return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "mgalliou/blink-cmp-tmux",
    },
    lazy = false,
    opts = {
      sources = {
        default = {
          "path",
          "snippets",
          "buffer",
          "tmux",
          "lazydev",
          "lsp",
        },
        providers = {
          tmux = {
            module = "blink-cmp-tmux",
            name = "tmux",
          },
        },
      },
      keymap = {
        ["<C-u>"] = { "select_prev", "fallback" },
        ["<C-d>"] = { "select_next", "fallback" },
        ["<C-space>"] = { "show" },
      },
    },
  },
}
