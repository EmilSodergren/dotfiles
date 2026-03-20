vim.pack.add({ 
  { src = 'https://github.com/neovim/nvim-lspconfig', version = 'master' },
})

vim.lsp.enable('bashls')

vim.lsp.config('bashls', {
  cmd = {
    os.getenv("HOME") .. "/.local/node_modules/bash-language-server/out/cli.js",
    "start",
  },
})
