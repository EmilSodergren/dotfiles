vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "fzf" and kind ~= "delete" then
      local install_cmd = ev.data.path .. "/install --no-zsh --no-fish --key-bindings --completion --update-rc"
      os.execute(install_cmd)
    end
  end
})

vim.pack.add({
  { src = "https://github.com/ibhagwan/fzf-lua", version = "main" },
  { src = "https://github.com/junegunn/fzf",     version = "master" },
})

require("fzf-lua").setup({
  fzf_bin = "~/.local/share/nvim/site/pack/core/opt/fzf/bin/fzf",
})

vim.keymap.set("n", "<leader>sf", function() return require("fzf-lua").files() end,
  { noremap = true, desc = "Search current folder" })
vim.keymap.set("n", "<leader>sh", function() return require("fzf-lua").files({ prompt = "~/", cwd = "~/" }) end,
  { noremap = true, desc = "Search home folder" })
vim.keymap.set("n", "<leader>sg", function() return require("fzf-lua").git_files({ prompt = "GIT> " }) end,
  { noremap = true, desc = "Search in git repo" })
vim.keymap.set("n", "<leader>sr", function() return require("fzf-lua").live_grep({ prompt = "rg> " }) end,
  { noremap = true, desc = "Search with RG" })
vim.keymap.set("i", "<C-x><C-f>",
  function() return require("fzf-lua").complete_path({ cmd = "rg --files --hidden -g '!.git/'" }) end,
  { silent = true, noremap = true, desc = "Complete filepath" })
vim.keymap.set("n", "<leader>ev", function() return require("fzf-lua").files({ cwd = "~/.config/nvim/" }) end,
  { noremap = true, desc = "Edit Vim config" })
