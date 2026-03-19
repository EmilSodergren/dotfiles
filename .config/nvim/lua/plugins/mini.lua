vim.pack.add({
  { src = 'https://github.com/nvim-mini/mini.ai', version = 'main' },
  { src = 'https://github.com/nvim-mini/mini.comment', version = 'main' },
  { src = 'https://github.com/nvim-mini/mini.cursorword', version = 'main' },
  { src = 'https://github.com/nvim-mini/mini.tabline', version = 'main' },
  { src = 'https://github.com/nvim-mini/mini.icons', version = 'main' },
  { src = 'https://github.com/nvim-mini/mini.statusline', version = 'main' },
})

require('mini.ai').setup()
require('mini.comment').setup()
require('mini.cursorword').setup()
require('mini.tabline').setup()
require('mini.icons').setup()
require('mini.statusline').setup()
