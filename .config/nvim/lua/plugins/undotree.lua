vim.pack.add({
  { src = 'https://github.com/jiaoshijie/undotree', version = 'main' },
})

require('undotree').setup({
      parser = 'compact',
})

vim.keymap.set("n", "<leader>u", function require('undotree').toggle() end, { noremap = true } )
