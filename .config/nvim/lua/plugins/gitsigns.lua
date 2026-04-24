vim.pack.add({
  { src = "https://github.com/lewis6991/gitsigns.nvim", version = "main" },
})

vim.keymap.set("n", "<leader>hs", require("gitsigns").stage_hunk, { noremap = true, desc = "Stage hunk" })
vim.keymap.set("n", "<leader>hr", require("gitsigns").reset_hunk, { noremap = true, desc = "Reset hunk" })
vim.keymap.set("v",
  "<leader>hs",
  function()
    require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end,
  { noremap = true, desc = "Stage selected hunk" })
vim.keymap.set("v",
  "<leader>hr",
  function()
    require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
  end,
  { noremap = true, desc = "Reset selected hunk" })
vim.keymap.set("n", "<leader>hS", require("gitsigns").stage_buffer, { noremap = true, desc = "Stage whole buffer" })
vim.keymap.set("n", "<leader>hR", require("gitsigns").reset_buffer, { noremap = true, desc = "Reset whole buffer" })
vim.keymap.set("n", "<leader>hp", require("gitsigns").preview_hunk, { noremap = true, desc = "Preview hunk" })
vim.keymap.set("n", "<leader>hb", function()
  require("gitsigns").blame_line({ full = true })
end, { noremap = true, desc = "Blame on line" })
vim.keymap.set("n", "<leader>tb", require("gitsigns").toggle_current_line_blame,
  { noremap = true, desc = "Toggle blame line" })
vim.keymap.set("n", "<leader>hd", require("gitsigns").diffthis, { noremap = true, desc = "Diff hunk" })
vim.keymap.set("n", "<leader>hD", function()
  require("gitsigns").diffthis("~")
end, { noremap = true, desc = "Diff hunk with HEAD" })
vim.keymap.set("n", "<leader>td", require("gitsigns").preview_hunk_inline, { noremap = true, desc = "Diff hunk inline" })
