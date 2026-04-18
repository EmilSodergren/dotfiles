vim.pack.add({
  { src = "https://github.com/mfussenegger/nvim-ansible", version = "main" },
  { src = "https://github.com/neovim/nvim-lspconfig",     version = "master" },
})

vim.lsp.config("ansiblels", {
  cmd = {
    os.getenv("HOME") .. "/.local/bin/ansible-language-server", "--stdio"
  },
})


vim.keymap.set("n", "<leader>ta", require("ansible").run,
  { noremap = true, desc = "Ansible Run Playbook/Role", silent = true, })

vim.lsp.enable("ansiblels")
