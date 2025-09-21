return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "mgalliou/blink-cmp-tmux",
      "rafamadriz/friendly-snippets",
    },
    lazy = false,
    opts = {
      sources = {
        default = {
          "lsp",
          "path",
          "snippets",
          "buffer",
          "tmux",
        },
        providers = {
          lsp = {
            score_offset = 10,
          },
          snippets = {
            score_offset = 4,
          },
          path = {
            score_offset = 3,
          },
          buffer = {
            score_offset = 2,
          },
          tmux = {
            module = "blink-cmp-tmux",
            name = "tmux",
            score_offset = -10,
          },
        },
      },
      keymap = {
        ["<C-u>"] = { "select_prev", "fallback" },
        ["<C-d>"] = { "select_next", "fallback" },
        ["<C-space>"] = { "show" },
        ["<CR>"] = { "select_and_accept", "fallback" },
      },
    },
  },
}
