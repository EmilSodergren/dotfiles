return {
  {
    "ibhagwan/fzf-lua",
    lazy = false,
    opts = {
      fzf_bin = '~/.local/share/nvim/lazy/fzf/bin/fzf',
    },
    keys = {
      { "<leader>sf", function() return require("fzf-lua").files() end,                                                    { mode = "n", noremap = true }, },
      { "<leader>sh", function() return require("fzf-lua").files({ prompt = "~/", cwd = "~/" }) end,                       { mode = "n", noremap = true }, },
      { "<leader>sg", function() return require("fzf-lua").git_files({ prompt = "GIT> " }) end,                            { mode = "n", noremap = true }, },
      { "<leader>sr", function() return require("fzf-lua").live_grep({ prompt = "rg> " }) end,                             { mode = "n", noremap = true }, },
      { "<C-x><C-f>", function() return require("fzf-lua").complete_path({ cmd = "rg --files --hidden -g '!.git/'" }) end, { mode = "i", silent = true, noremap = true }, },
      { "<leader>ev", function() return require("fzf-lua").files({ cwd = "~/.config/nvim/" }) end,                         { mode = "n", noremap = true }, },
    },
  },
  { "junegunn/fzf", build = "./install --no-zsh --no-fish --key-bindings --completion --update-rc" },
}
