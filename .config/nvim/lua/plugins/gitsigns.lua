vim.pack.add({
  { src = "https://github.com/lewis6991/gitsigns.nvim", version = "main" },
})

vim.keymap.set("n", "<leader>hs", require("gitsigns").stage_hunk, { noremap = true })
vim.keymap.set("n", "<leader>hr", require("gitsigns").reset_hunk, { noremap = true })
vim.keymap.set("v",
  "<leader>hs",
  function()
    require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end,
  { noremap = true })
vim.keymap.set("v",
  "<leader>hr",
  function()
    require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end,
  { noremap = true })
vim.keymap.set("n", "<leader>hS", require("gitsigns").stage_buffer, { noremap = true })
vim.keymap.set("n", "<leader>hu", require("gitsigns").stage_hunk, { noremap = true })
vim.keymap.set("n", "<leader>hR", require("gitsigns").reset_buffer, { noremap = true })
vim.keymap.set("n", "<leader>hp", require("gitsigns").preview_hunk, { noremap = true })
vim.keymap.set("n", "<leader>hb", function()
  require("gitsigns").blame_line({ full = true })
end, { noremap = true })
vim.keymap.set("n", "<leader>tb", require("gitsigns").toggle_current_line_blame, { noremap = true })
vim.keymap.set("n", "<leader>hd", require("gitsigns").diffthis, { noremap = true })
vim.keymap.set("n", "<leader>hD", function()
  require("gitsigns").diffthis("~")
end, { noremap = true })
vim.keymap.set("n", "<leader>td", require("gitsigns").preview_hunk_inline, { noremap = true })
