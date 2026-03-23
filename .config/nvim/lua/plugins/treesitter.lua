     local parsers = {
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
       "tsx",
       "typescript",
       "vim",
       "vimdoc",
       "xml",
       "yaml",
     }
vim.api.nvim_create_autocmd("PackChanged", { callback = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind
   if name == "nvim-treesitter" and kind == "install" then
     if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
     require("nvim-treesitter").install(parsers):wait(60000)
   end
   if name == "nvim-treesitter" and kind == "update" then
     if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
     vim.cmd("TSUpdate")
  end
end })

vim.pack.add({ 
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})


