vim.keymap.set("n", "<leader>p", "<cmd>FZF<cr>", { noremap })
vim.keymap.set("n", "<leader>sf", "<cmd>FZF<cr>", { noremap })
vim.keymap.set("n", "<leader>sh", "<cmd>FZF ~<cr>", { noremap })
vim.keymap.set("n", "<leader>sg", "<cmd>GFiles<cr>", { noremap })
vim.keymap.set("n", "<leader>sl", "<cmd>Lines<cr>", { noremap })

vim.keymap.set("n", "<leader>ev", "<cmd>FZF ~/.config/nvim/<cr>", { noremap })
vim.keymap.set("n", "<leader>sv", "<cmd>source ~/.dotfiles/.config/nvim/init.lua<cr>", { noremap })

vim.keymap.set("n", "<leader>q", "<cmd>bp<bar>bd #<cr>", { noremap })
vim.keymap.set("n", "<c-h>", "<c-w>h", { noremap })
vim.keymap.set("n", "<c-j>", "<c-w>j", { noremap })
vim.keymap.set("n", "<c-k>", "<c-w>k", { noremap })
vim.keymap.set("n", "<c-l>", "<c-w>l", { noremap })

vim.keymap.set("n", "n", "nzzzv", { noremap })
vim.keymap.set("n", "N", "Nzzzv", { noremap })

vim.keymap.set("n", "j", "gj", { noremap })
vim.keymap.set("n", "k", "gk", { noremap })

vim.keymap.set("n", "J", "mzJ`z", { noremap })

vim.keymap.set({"n", "v"}, "<leader>y", "\"+y", { noremap })
vim.keymap.set("n", "<leader>Y", "\"+Y", { noremap })

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<down>", "3jzz", { noremap })
vim.keymap.set("n", "<up>", "3kzz", { noremap })
vim.keymap.set("n", "<s-h>", "<cmd>bp<cr>", { noremap })
vim.keymap.set("n", "<s-l>", "<cmd>bn<cr>", { noremap })

vim.keymap.set("n", "<c-g>", "1<c-g>", { noremap })

vim.keymap.set("n", "<leader>sr", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { noremap })

vim.keymap.set("n", "<c-w><bar>", "<c-w>v", { noremap })
vim.keymap.set("n", "<c-w>-", "<c-w>s", { noremap })

vim.keymap.set("i", "jk", "<esc>", { noremap })

-- Use C-u/d to go up/down the popup menu of COQ
-- This works since we set the setting keymap.recommended = false
vim.keymap.set({"i", "c", "n", "o"}, "<c-d>", function()
  return vim.fn.pumvisible() == 1 and "<c-n>" or "<c-d>zz"
end, { noremap, expr = true })
vim.keymap.set({"i", "c", "n", "o"}, "<c-u>", function()
  return vim.fn.pumvisible() == 1 and "<c-p>" or "<c-u>zz"
end, { noremap, expr = true })

-- Disable ctrl + Left/Right which deletes stuff

vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { noremap, silent = true })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap, silent = true })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap, silent = true })
vim.keymap.set("n", "<leader>r", vim.lsp.buf.references, { noremap, silent = true })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { noremap, silent = true })
vim.keymap.set("n", "<leader>n", vim.lsp.buf.code_action, { noremap, silent = true })
vim.keymap.set("n", "<leader>e", vim.lsp.buf.signature_help, { noremap, silent = true })

-- Clean up whitespaces at end of lines
vim.keymap.set("n", "<leader>ws", function()
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.cmd([[%s/\s\+$//e]])
  vim.api.nvim_set_hl(0, 'visual', {})
  vim.api.nvim_win_set_cursor(0, pos)
end, { noremap, silent = true })

-- Delete current selection to the black hole registry before pasting,
-- keeping the currently pasted text instead of overwriting it.
vim.keymap.set({"v", "x"}, "p", '"_dP', { noremap })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap })

-- save file with sudo permissions
vim.keymap.set("c", "w!!", "w !sudo tee > /dev/null %")

vim.keymap.set("n", "dgh", "<cmd>diffget //2<cr> ]c", { noremap })
vim.keymap.set("n", "dgl", "<cmd>diffget //3<cr> ]c", { noremap })

vim.keymap.set("n", "ysss", "<Plug>Yssurround <s><cr>I* <esc>f*xx")

vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { noremap })

vim.keymap.set({"n", "v"}, "<space>", "za", { noremap })

