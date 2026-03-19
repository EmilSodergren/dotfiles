return {
  {
    "jiaoshijie/undotree",
    config = true,
    lazy = false,
    opts = {
      parser = 'compact',
    },
    keys = { -- load the plugin only when using it's keybinding:
      { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
    },
  },
}
