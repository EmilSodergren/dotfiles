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
          "snippets",
          "buffer",
          "path",
          "tmux",
        },
        providers = {
          lsp = {
            score_offset = 10,
            name = "lsp",
          },
          snippets = {
            score_offset = 4,
            name = "snippets",
          },
          buffer = {
            score_offset = 2,
            name = "buffer",
          },
          path = {
            score_offset = -9,
            name = "path",
            min_keyword_length = 2
          },
          tmux = {
            module = "blink-cmp-tmux",
            score_offset = -10,
            name = "tmux",
            min_keyword_length = 2
          },
        },
      },
      completion = {
        menu = {
          max_height = 15,
          scrolloff = 2,
          scrollbar = false,
          auto_show_delay_ms = 20,
          draw = {
            columns = { { "kind_icon" }, { "label", gap = 1 } },
            components = {
              label = {
                text = function(ctx)
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require("colorful-menu").blink_components_highlight(ctx)
                end
              }
            }
          }
        }
      },
      keymap = {
        ["<C-u>"] = { "select_prev", "fallback" },
        ["<C-d>"] = { "select_next", "fallback" },
        ["<C-space>"] = { "show" },
        ["<CR>"] = { "select_and_accept", "fallback" },
      },
      cmdline = {
        enabled = true,
        keymap = {
          ["<C-u>"] = { "select_prev", "fallback" },
          ["<C-d>"] = { "select_next", "fallback" },
          ["<C-space>"] = { "show" },
          ["<CR>"] = { "select_and_accept", "fallback" },
        },
        completion = {
          menu = { auto_show = false },
          list = { selection = { preselect = true } },
        },
      },
    },
  },
}
