vim.pack.add({
  { src = 'https://github.com/alexghergh/nvim-tmux-navigation', version = 'main' },
})

require("nvim-tmux-navigation").setup({
  disable_when_zoomed = true,
  keybindings = {
    left = "<M-h>",
    down = "<M-j>",
    up = "<M-k>",
    right = "<M-l>",
  },
})
