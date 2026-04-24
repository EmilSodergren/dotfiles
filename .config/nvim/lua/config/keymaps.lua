local map = vim.keymap.set

map("i", "jk", "<esc>", { noremap = true, desc = "Go back to normal mode" })
map("n", "<leader>q", "<cmd>bp<bar>bd #<cr>", { noremap = true, desc = "Close buffer" })

map("n", "n", "nzzzv", { noremap = true, desc = "Go to next and center" })
map("n", "N", "Nzzzv", { noremap = true, desc = "Go to previous and center" })

map("n", "J", "mzJ`z", { noremap = true, desc = "Merge line below with this" })
map({ "n", "v" }, "<leader>y", '"+y', { noremap = true })
map("n", "<leader>Y", '"+Y', { noremap = true, desc = "Copy to desktop copy/paste buffer" })

map("n", "Q", "@q", { desc = "Replay buffer q" })
map({ "n", "v" }, "q:", "<nop>", { remap = true, desc = "disable q: command" })

map("n", "<down>", "3jzz", { noremap = true, desc = "Arrow up jump tree lines back" })
map("n", "<up>", "3kzz", { noremap = true, desc = "Arrow down jump tree lines forward" })
map("n", "<s-h>", "<cmd>bp<cr>", { noremap = true, desc = "Go to previous buffer" })
map("n", "<s-l>", "<cmd>bn<cr>", { noremap = true, desc = "Go to next buffer" })

map("n", "<c-g>", "1<c-g>", { noremap = true, desc = "Show full filename" })

map("n", "<leader>rr", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
  { noremap = true, desc = "Search/replace without using LSP" })

map("n", "<c-w><bar>", "<c-w>v", { noremap = true, desc = "Split window vertically" })
map("n", "<c-w>-", "<c-w>s", { noremap = true, desc = "Split window horizontally" })


map({ "n", "o" }, "<c-d>", "<c-d>M", { noremap = true, desc = "Center view after jumping half page up" })
map({ "n", "o" }, "<c-u>", "<c-u>M", { noremap = true, desc = "Center view after jumping half page down" })

map("n", "<F2>", vim.lsp.buf.rename, { noremap = true, silent = true, desc = "Rename with LSP" })
map("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true, desc = "Hover with LSP" })
map("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true, desc = "Go to definition with LSP" })
map("n", "<leader>r", vim.lsp.buf.references, { noremap = true, silent = true, desc = "Get references in qflist" })
map("n", "<leader>f", vim.lsp.buf.format, { noremap = true, silent = true, desc = "Format with LSP" })
map({ "n", "i" }, "<leader>n", vim.lsp.buf.code_action, { noremap = true, silent = true, desc = "Code Action with LSP" })
map("n", "<leader>e", vim.lsp.buf.signature_help, { noremap = true, silent = true, desc = "Signature Help with LSP" })

-- Clean up whitespaces at end of lines
map("n", "<leader>ws", function()
  local pos = vim.api.nvim_win_get_cursor(0)
  vim.cmd([[%s/\s\+$//e]])
  vim.api.nvim_set_hl(0, "visual", {})
  vim.api.nvim_win_set_cursor(0, pos)
end, { noremap = true, silent = true, desc = "Clear all trailing whitespaces" })

-- Delete current selection to the black hole registry before pasting,
-- keeping the currently pasted text instead of overwriting it.
map({ "v", "x" }, "p", '"_dP', { noremap = true, desc = "Do not overwrite buffer when pasting in visual mode" })

map("v", "J", ':m ">+1<CR>gv=gv', { noremap = true, desc = "Move selected lines up" })
map("v", "K", ':m "<-2<CR>gv=gv', { noremap = true, desc = "Move selected lines down" })

-- save file with sudo permissions
map("c", "w!!", "w !sudo tee > /dev/null %", { desc = "Write file as sudo" })

map({ "n", "v" }, "<space>", "za", { noremap = true, desc = "Toggle fold" })
