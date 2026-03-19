return {
  {
    "NeogitOrg/neogit",
    lazy = true,
    opts = {
      mappings = { status = { ["<space>"] = "Toggle" } },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>m", function() require('neogit').open({ kind = "vsplit" }) end, },
    },
  },
}
