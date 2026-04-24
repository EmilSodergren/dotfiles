vim.pack.add({
  { src = "https://github.com/folke/flash.nvim", version = "main" },
})

require("fzf-lua").setup({
  fzf_bin = "~/.local/share/nvim/site/pack/core/opt/fzf/bin/fzf",
})

vim.keymap.set({ "n", "x", "o" }, "s", require("flash").jump, { noremap = true, desc = "Search with flash" })
