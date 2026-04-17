local treesitter_parsers = {
  "bash",
  "c",
  "comment",
  "csv",
  "diff",
  "dockerfile",
  "gitignore",
  "go",
  "gomod",
  "gosum",
  "gotmpl",
  "gowork",
  "html",
  "html_tags",
  "javascript",
  "jsdoc",
  "json",
  "lua",
  "luadoc",
  "luap",
  "make",
  "markdown",
  "markdown_inline",
  "printf",
  "python",
  "query",
  "regex",
  "rust",
  "sql",
  "tmux",
  "toml",
  "ecma",
  "tsv",
  "jsx",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "xml",
  "yaml",
}
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if (name == "nvim-treesitter") and kind == "install" then
      if not ev.data.active then
        vim.cmd.packadd("treesitter-parser-registry")
        vim.cmd.packadd("nvim-treesitter")
      end
      require("nvim-treesitter").install(treesitter_parsers):wait(180000)
    end
    if (name == "nvim-treesitter" or name == "treesitter-parser-registry") and kind == "update" then
      if not ev.data.active then
        vim.cmd.packadd("treesitter-parser-registry")
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.cmd("TSUpdate")
    end
  end
})

vim.pack.add({
  { src = "https://github.com/neovim-treesitter/treesitter-parser-registry", version = "main" },
  { src = "https://github.com/neovim-treesitter/nvim-treesitter",            version = "main" },
})

-- require("nvim-treesitter").setup({})

vim.api.nvim_create_autocmd("FileType",
  {
    group = vim.api.nvim_create_augroup("enable_treesitter", { clear = true }),
    pattern = treesitter_parsers,
    callback = function() vim.treesitter.start() end
  })
