return {
  "lewis6991/gitsigns.nvim",
  lazy = false,
  opts = {},
  keys = {
    { "<leader>hs", require("gitsigns").stage_hunk },
    { "<leader>hr", require("gitsigns").reset_hunk },
    {
      "<leader>hs",
      function()
        require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end,
      mode = "v"
    },
    {
      "<leader>hr",
      function()
        require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end,
      mode = "v"
    },
    { "<leader>hS", require("gitsigns").stage_buffer },
    { "<leader>hu", require("gitsigns").stage_hunk },
    { "<leader>hR", require("gitsigns").reset_buffer },
    { "<leader>hp", require("gitsigns").preview_hunk },
    { "<leader>hb", function()
      require("gitsigns").blame_line({ full = true })
    end },
    { "<leader>tb", require("gitsigns").toggle_current_line_blame },
    { "<leader>hd", require("gitsigns").diffthis },
    { "<leader>hD", function()
      require("gitsigns").diffthis("~")
    end },
    { "<leader>td", require("gitsigns").preview_hunk_inline },
  }
}
