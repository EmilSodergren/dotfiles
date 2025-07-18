local map = vim.keymap.set

map("i", "jk", "<esc>", { noremap = true })
map("n", "<leader>q", "<cmd>bp<bar>bd #<cr>", { noremap = true })

vim.keymap.set("n", "n", "nzzzv", { noremap = true })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true })

vim.keymap.set("n", "J", "mzJ`z", { noremap = true })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { noremap = true })
vim.keymap.set("n", "<leader>Y", '"+Y', { noremap = true })

vim.keymap.set("n", "Q", "@q")
vim.keymap.set({ "n", "v" }, "q:", "<nop>", { remap = true })

vim.keymap.set("n", "<down>", "3jzz", { noremap = true })
vim.keymap.set("n", "<up>", "3kzz", { noremap = true })
vim.keymap.set("n", "<s-h>", "<cmd>bp<cr>", { noremap = true })
vim.keymap.set("n", "<s-l>", "<cmd>bn<cr>", { noremap = true })

vim.keymap.set("n", "<c-g>", "1<c-g>", { noremap = true })

vim.keymap.set("n", "<leader>rr", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { noremap = true })

vim.keymap.set("n", "<c-w><bar>", "<c-w>v", { noremap = true })
vim.keymap.set("n", "<c-w>-", "<c-w>s", { noremap = true })


vim.keymap.set({ "n", "o" }, "<c-d>", "<c-d>M", { noremap = true })
vim.keymap.set({ "n", "o" }, "<c-u>", "<c-u>M", { noremap = true })
-- Use C-u/d to go up/down the popup menu of COQ
-- This works since we set the setting keymap.recommended = false
vim.keymap.set({ "i", "c" }, "<c-d>", function()
  return vim.fn.pumvisible() == 1 and "<c-n>"
end, { noremap = true, expr = true })
vim.keymap.set({ "i", "c" }, "<c-u>", function()
  return vim.fn.pumvisible() == 1 and "<c-p>"
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

-- LOCAL is set to be opened to the left and
-- REMOTE to the right.
vim.keymap.set("n", "dgh", "<cmd>diffget LOCAL<cr> ]c", { noremap = true })
vim.keymap.set("n", "dgl", "<cmd>diffget REMOTE<cr> ]c", { noremap = true })

vim.keymap.set({ "n", "v" }, "<space>", "za", { noremap = true })
