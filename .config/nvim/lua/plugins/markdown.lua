vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'markdown-preview.nvim' and kind ~= 'delete' then
      install_cmd = ev.data.path .. '/app/install.sh'
      os.execute(install_cmd)
    end
  end
})

vim.pack.add({
  { src = 'https://github.com/iamcco/markdown-preview.nvim',              version = 'master' },
  { src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim', version = 'main' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter',           version = 'main' },
  { src = 'https://github.com/nvim-mini/mini.icons',                      version = 'main' },
  { src = 'https://github.com/neovim/nvim-lspconfig',                     version = 'master' },
})

require('render-markdown').setup({})

vim.lsp.config('marksman', {
  cmd = {
    os.getenv("HOME") .. "/.local/bin/marksman",
    "server",
  },

})
vim.lsp.enable('marksman')
