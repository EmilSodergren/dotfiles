vim.pack.add({
  { src = "https://github.com/NeogitOrg/neogit",      version = "master" },
  { src = "https://github.com/nvim-lua/plenary.nvim", version = "master" },
})

require("neogit").setup({
  mappings = { status = { ["<space>"] = "Toggle" } },
})
