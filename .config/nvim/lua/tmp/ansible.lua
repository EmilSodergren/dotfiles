return {
  {
    "mfussenegger/nvim-ansible",
    ft = "yaml",
    keys = {
      {
        "<leader>ta",
        function()
          require("ansible").run()
        end,
        ft = "yaml.ansible",
        desc = "Ansible Run Playbook/Role",
        silent = true,
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ansiblels = {
          cmd = {
            os.getenv("HOME") .. "/.local/bin/ansible-language-server", "--stdio"
          },
        },
      },
    },
  },
}
