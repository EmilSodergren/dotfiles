vim.keymap.set("n", "<leader>p", "<cmd>FZF<cr>", { noremap })
vim.keymap.set("n", "<leader>sf", "<cmd>FZF<cr>", { noremap })
vim.keymap.set("n", "<leader>sh", "<cmd>FZF ~<cr>", { noremap })
vim.keymap.set("n", "<leader>sg", "<cmd>GFiles<cr>", { noremap })
vim.keymap.set("n", "<leader>sl", "<cmd>Lines<cr>", { noremap })

vim.g.bash_ctrl_j="off"
vim.g.python_host_prog="/usr/bin/python2"
vim.g.python3_host_prog="/usr/bin/python3"
vim.g.python3_host_skip_check = 1
vim.g.netrw_dirhistmax = 0

vim.keymap.set("n", "<leader>ev", "<cmd>e ~/.dotfiles/.config/nvim/init.lua<cr>", { noremap })
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

vim.keymap.set("n", "<down>", "3jzz", { noremap })
vim.keymap.set("n", "<up>", "3kzz", { noremap })
vim.keymap.set("n", "<s-h>", "<cmd>bp<cr>", { noremap })
vim.keymap.set("n", "<s-l>", "<cmd>bn<cr>", { noremap })

vim.keymap.set("n", "<c-g>", "1<c-g>", { noremap })

vim.keymap.set("n", "<c-w><bar>", "<c-w>v", { noremap })
vim.keymap.set("n", "<c-w>-", "<c-w>s", { noremap })

vim.keymap.set("i", "jk", "<esc>", { noremap })

-- " Use C-u/d to go up/down the popup menu of deoplete
vim.keymap.set({"i", "c"}, "<c-d>", function()
    return vim.fn.pumvisible() == 1 and "<c-n>" or "<c-d>"
end, { noremap, expr = true })
vim.keymap.set({"i", "c"}, "<c-u>", function()
    return vim.fn.pumvisible() == 1 and "<c-p>" or "<c-u>"
end, { noremap, expr = true })

-- " Disable ctrl + Left/Right which deletes stuff

vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { noremap, buffer = true, silent = true })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap, buffer = true, silent = true })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap, buffer = true, silent = true })
vim.keymap.set("n", "<leader>r", vim.lsp.buf.references, { noremap, buffer = true, silent = true })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.formatting , { noremap, buffer = true, silent = true })
vim.keymap.set("n", "<leader>n", vim.lsp.buf.code_action, { noremap, buffer = true, silent = true })
vim.keymap.set("n", "<leader>e", vim.lsp.buf.signature_help, { noremap, buffer = true, silent = true })

-- " Clean up whitespaces at end of lines
-- vim.keymap.set("n", "<leader>ws", "<cmd>let _s=@/ <Bar> %s/\\s\\+$//e <Bar> let @/=_s <Bar> nohl <Bar> unlet _s <cr>", { noremap, buffer = true, silent = true })
vim.keymap.set("n", "<leader>ws", function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd("%s/\\s\\+$//e")
    vim.api.nvim_set_hl(0, 'visual', {})
    vim.api.nvim_win_set_cursor(0, pos)
end, { noremap, buffer = true, silent = true })

-- " Delete current selection to the black hole registry before pasting,
-- " keeping the currently pasted text instead of overwriting it.
vim.keymap.set("v", "p", '"_dP', { noremap })

-- " save file with sudo permissions
vim.keymap.set("c", "w!!", "w !sudo tee > /dev/null %")

-- nnoremap dgh :diffget //2 <CR> ]c
vim.keymap.set("n", "dgh", "<cmd>diffget //2<cr> ]c", { noremap })
-- nnoremap dgl :diffget //3 <CR> ]c
vim.keymap.set("n", "dgl", "<cmd>diffget //3<cr> ]c", { noremap })

-- nmap ysss <Plug>Yssurround <s>I* <esc>f*xx
vim.keymap.set("n", "ysss", "<Plug>Yssurround <s><cr>I* <esc>f*xx")

-- nnoremap <leader>u :UndotreeToggle<CR>
vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<cr>", { noremap })