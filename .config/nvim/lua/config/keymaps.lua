local map = vim.keymap.set

map("i", "jk", "<esc>", { noremap = true })
map("n", "<leader>q", "<cmd>bp<bar>bd #<cr>", { noremap = true })

map("n", "n", "nzzzv", { noremap = true })
map("n", "N", "Nzzzv", { noremap = true })

map("n", "J", "mzJ`z", { noremap = true })
map({ "n", "v" }, "<leader>y", '"+y', { noremap = true })
map("n", "<leader>Y", '"+Y', { noremap = true })

map("n", "Q", "@q")
map({ "n", "v" }, "q:", "<nop>", { remap = true })

map("n", "<down>", "3jzz", { noremap = true })
map("n", "<up>", "3kzz", { noremap = true })
map("n", "<s-h>", "<cmd>bp<cr>", { noremap = true })
map("n", "<s-l>", "<cmd>bn<cr>", { noremap = true })

map("n", "<c-g>", "1<c-g>", { noremap = true })

map("n", "<leader>rr", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { noremap = true })

map("n", "<c-w><bar>", "<c-w>v", { noremap = true })
map("n", "<c-w>-", "<c-w>s", { noremap = true })


map({ "n", "o" }, "<c-d>", "<c-d>M", { noremap = true })
map({ "n", "o" }, "<c-u>", "<c-u>M", { noremap = true })

map("n", "<F2>", vim.lsp.buf.rename, { noremap = true, silent = true })
map("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true })
map("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true })
map("n", "<leader>r", vim.lsp.buf.references, { noremap = true, silent = true })
map("n", "<leader>f", vim.lsp.buf.format, { noremap = true, silent = true })
map("n", "<leader>n", vim.lsp.buf.code_action, { noremap = true, silent = true })
map("n", "<leader>e", vim.lsp.buf.signature_help, { noremap = true, silent = true })

map("n", "<leader>u", require('undotree').toggle, { noremap = true, silent = true } )

-- Clean up whitespaces at end of lines
vim.keymap.set("n", "<leader>ws", function()
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.cmd([[%s/\s\+$//e]])
  vim.api.nvim_set_hl(0, "visual", {})
  vim.api.nvim_win_set_cursor(0, pos)
end, { noremap = true, silent = true })

-- Delete current selection to the black hole registry before pasting,
-- keeping the currently pasted text instead of overwriting it.
vim.keymap.set({ "v", "x" }, "p", '"_dP', { noremap = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true })

-- save file with sudo permissions
vim.keymap.set("c", "w!!", "w !sudo tee > /dev/null %")

vim.keymap.set({ "n", "v" }, "<space>", "za", { noremap = true })

vim.keymap.set("n", "<leader>sf", function() return require("fzf-lua").files() end,                                                    { noremap = true })
vim.keymap.set("n", "<leader>sh", function() return require("fzf-lua").files({ prompt = "~/", cwd = "~/" }) end,                       { noremap = true })
vim.keymap.set("n", "<leader>sg", function() return require("fzf-lua").git_files({ prompt = "GIT> " }) end,                            { noremap = true })
vim.keymap.set("n", "<leader>sr", function() return require("fzf-lua").live_grep({ prompt = "rg> " }) end,                             { noremap = true })
vim.keymap.set("i", "<C-x><C-f>", function() return require("fzf-lua").complete_path({ cmd = "rg --files --hidden -g '!.git/'" }) end, { silent = true, noremap = true })
vim.keymap.set("n", "<leader>ev", function() return require("fzf-lua").files({ cwd = "~/.config/nvim/" }) end,                         { noremap = true })  


      vim.keymap.set(  "n", "<leader>hs", require("gitsigns").stage_hunk, { noremap = true })
      vim.keymap.set(  "n", "<leader>hr", require("gitsigns").reset_hunk, { noremap = true })
     vim.keymap.set(  "v", 
        "<leader>hs",
        function()
          require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end,
        { noremap = true})
     vim.keymap.set(  "v", 
        "<leader>hr",
        function()
          require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end,
      { noremap = true })
      vim.keymap.set(  "n", "<leader>hS", require("gitsigns").stage_buffer, { noremap = true })
      vim.keymap.set(  "n", "<leader>hu", require("gitsigns").stage_hunk, { noremap = true })
     vim.keymap.set(  "n",  "<leader>hR", require("gitsigns").reset_buffer, { noremap = true })
     vim.keymap.set(  "n",  "<leader>hp", require("gitsigns").preview_hunk, { noremap = true })
    vim.keymap.set(  "n",   "<leader>hb", function()
        require("gitsigns").blame_line({ full = true })
      end, { noremap = true })
      vim.keymap.set(  "n", "<leader>tb", require("gitsigns").toggle_current_line_blame, { noremap = true })
      vim.keymap.set(  "n", "<leader>hd", require("gitsigns").diffthis, { noremap = true })
      vim.keymap.set(  "n", "<leader>hD", function()
        require("gitsigns").diffthis("~")
      end, { noremap = true })
      vim.keymap.set(  "n", "<leader>td", require("gitsigns").preview_hunk_inline, { noremap = true })
