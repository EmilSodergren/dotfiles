local fzf = require('fzf-lua')

vim.keymap.set("n", "<leader>sf", function() return fzf.files() end, { noremap = true })
vim.keymap.set("n", "<leader>sh", function() return fzf.files({ prompt = "~/", cwd = "~/" }) end, { noremap = true })
vim.keymap.set("n", "<leader>sg", function() return fzf.git_files({ prompt = "GIT> " }) end, { noremap = true })
vim.keymap.set("n", "<leader>sr", function() return fzf.live_grep({ prompt = "rg> " }) end, { noremap = true })
vim.keymap.set("i", "<C-x><C-f>", function() return fzf.complete_path({ cmd = "rg --files --hidden -g '!.git/'" }) end,
  { silent = true, noremap = true })
vim.keymap.set("n", "<leader>ev", function() return fzf.files({ cwd = "~/.config/nvim/" }) end, { noremap = true })

vim.keymap.set("n", "<leader>q", "<cmd>bp<bar>bd #<cr>", { noremap = true })
vim.keymap.set("n", "<c-h>", "<c-w>h", { noremap = true })
vim.keymap.set("n", "<c-j>", "<c-w>j", { noremap = true })
vim.keymap.set("n", "<c-k>", "<c-w>k", { noremap = true })
vim.keymap.set("n", "<c-l>", "<c-w>l", { noremap = true })

vim.keymap.set("n", "n", "nzzzv", { noremap = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true })

vim.keymap.set("n", "j", "gj", { noremap = true })
vim.keymap.set("n", "k", "gk", { noremap = true })

vim.keymap.set("n", "J", "mzJ`z", { noremap = true })

vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y", { noremap = true })
vim.keymap.set("n", "<leader>Y", "\"+Y", { noremap = true })

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<down>", "3jzz", { noremap = true })
vim.keymap.set("n", "<up>", "3kzz", { noremap = true })
vim.keymap.set("n", "<s-h>", "<cmd>bp<cr>", { noremap = true })
vim.keymap.set("n", "<s-l>", "<cmd>bn<cr>", { noremap = true })

vim.keymap.set("n", "<c-g>", "1<c-g>", { noremap = true })

vim.keymap.set("n", "<leader>rr", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { noremap = true })

vim.keymap.set("n", "<c-w><bar>", "<c-w>v", { noremap = true })
vim.keymap.set("n", "<c-w>-", "<c-w>s", { noremap = true })

vim.keymap.set("i", "jk", "<esc>", { noremap = true })

-- Use C-u/d to go up/down the popup menu of COQ
-- This works since we set the setting keymap.recommended = false
vim.keymap.set({ "i", "c", "n", "o" }, "<c-d>", function()
  return vim.fn.pumvisible() == 1 and "<c-n>" or "<c-d>zz"
end, { noremap = true, expr = true })
vim.keymap.set({ "i", "c", "n", "o" }, "<c-u>", function()
  return vim.fn.pumvisible() == 1 and "<c-p>" or "<c-u>zz"
end, { noremap = true, expr = true })

-- Disable ctrl + Left/Right which deletes stuff

vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { noremap = true, silent = true })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>r", vim.lsp.buf.references, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>n", vim.lsp.buf.code_action, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>e", vim.lsp.buf.signature_help, { noremap = true, silent = true })

-- Clean up whitespaces at end of lines
vim.keymap.set("n", "<leader>ws", function()
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.cmd([[%s/\s\+$//e]])
  vim.api.nvim_set_hl(0, 'visual', {})
  vim.api.nvim_win_set_cursor(0, pos)
end, { noremap = true, silent = true })

-- Delete current selection to the black hole registry before pasting,
-- keeping the currently pasted text instead of overwriting it.
vim.keymap.set({ "v", "x" }, "p", '"_dP', { noremap = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true })

-- save file with sudo permissions
vim.keymap.set("c", "w!!", "w !sudo tee > /dev/null %")

vim.keymap.set("n", "dgh", "<cmd>diffget //2<cr> ]c", { noremap = true })
vim.keymap.set("n", "dgl", "<cmd>diffget //3<cr> ]c", { noremap = true })

vim.keymap.set("n", "ysss", "<Plug>Yssurround <s><cr>I* <esc>f*xx")

vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { noremap = true })

vim.keymap.set({ "n", "v" }, "<space>", "za", { noremap = true })
