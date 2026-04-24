vim.pack.add({
  { src = "https://github.com/NeogitOrg/neogit",      version = "master" },
  { src = "https://github.com/nvim-lua/plenary.nvim", version = "master" },
})

require("neogit").setup({
  mappings = { status = { ["<space>"] = "Toggle" } },
})

vim.keymap.set("n", "<leader>m", function() require("neogit").open({ kind = "vsplit" }) end, { noremap = true, desc = "Start Neogit" })
