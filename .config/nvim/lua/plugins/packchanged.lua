------------------------------------------------
--- TREESITTER Install and update
------------------------------------------------
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
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "nvim-treesitter" and kind == "install" then
      if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
      require("nvim-treesitter").install(parsers):wait(60000)
    end
    if name == "nvim-treesitter" and kind == "update" then
      if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
      vim.cmd("TSUpdate")
    end
  end
})

------------------------------------------------
--- FZF binary download
------------------------------------------------
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "fzf" and kind ~= "delete" then
      local install_cmd = ev.data.path .. "/install --no-zsh --no-fish --key-bindings --completion --update-rc"
      os.execute(install_cmd)
    end
  end
})

------------------------------------------------
--- MARKDOWN PREVIEW install
------------------------------------------------
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "markdown-preview.nvim" and kind ~= "delete" then
      local install_cmd = ev.data.path .. "/app/install.sh"
      os.execute(install_cmd)
    end
  end
})
