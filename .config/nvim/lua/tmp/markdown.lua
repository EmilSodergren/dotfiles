return {
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && ./install.sh",
    ft = "markdown",
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ft = "markdown",

    opts = {},
  },
}
