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

-- " Disable ctrl + Left/Right which deletes stuff
-- nnoremap <esc>[1;5D <nop>
-- nnoremap <esc>[1;5C <nop>
-- inoremap <esc>[1;5D <nop>
-- inoremap <esc>[1;5C <nop>
-- nnoremap <lt> <nop>
-- nnoremap > <nop>
-- nnoremap <c-r> <c-r>

-- nnoremap <silent> <F2> <cmd>lua vim.lsp.buf.rename()<CR>
-- nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
-- nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
-- nnoremap <silent> <leader>r <cmd>lua vim.lsp.buf.references()<CR>
-- nnoremap <silent> <leader>f <cmd>lua vim.lsp.buf.formatting()<CR>
-- nnoremap <silent> <leader>n <cmd>lua vim.lsp.buf.code_action()<CR>
-- nnoremap <silent> <leader>e <cmd>lua vim.lsp.buf.signature_help()<CR>

-- " Clean up whitespaces at end of lines
-- nnoremap <silent> <leader>ws :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

-- " Delete current selection to the black hole registry before pasting,
-- " keeping the currently pasted text instead of overwriting it.
-- vnoremap p "_dP

-- " key-mappings for comment line in normal mode tpope/vim-commentary
-- noremap  <silent> gc :Commentary<cr>

-- " save file with sudo permissions
-- cmap w!! w !sudo tee > /dev/null %

-- nnoremap dgh :diffget //2 <CR> ]c
-- nnoremap dgl :diffget //3 <CR> ]c

-- nmap ysss <Plug>Yssurround <s>I* <esc>f*xx

-- nnoremap <leader>u :UndotreeToggle<CR>
