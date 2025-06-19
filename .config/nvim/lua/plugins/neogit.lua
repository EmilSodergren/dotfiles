return {
  "NeogitOrg/neogit",
  lazy = false,
  opts = {
    mappings = { status = { ["<space>"] = "Toggle" } },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim"
  },
  keys = {
    { "<leader>m", function() require('neogit').open({ kind = "vsplit" }) end, },
  },
}
