vim.pack.add({
  { src = "https://github.com/simeji/winresizer", version = "master" },
})

vim.keymap.set("n", "<C-a>", "<cmd>WinResizerStartResize<cr>",
  { noremap = true, silent = true, desc = "Resize current window" })
