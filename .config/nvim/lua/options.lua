vim.g.bash_ctrl_j = "off"
vim.g.python_host_prog = "/usr/bin/python2"
vim.g.python3_host_prog = "/usr/bin/python3"
vim.g.python3_host_skip_check = 1
vim.g.netrw_dirhistmax = 0

vim.o.autoindent = true
vim.o.backspace = "indent"
vim.o.clipboard = "unnamedplus"
vim.o.cmdheight = 2
vim.opt.completeopt:append { "menuone", "noinsert", "noselect" }
vim.opt.completeopt:remove { "preview" }
vim.o.conceallevel = 2
vim.o.encoding = "utf-8"
vim.o.expandtab = true
vim.o.fileencoding = "utf-8"
vim.o.fileencodings = "utf-8"
vim.o.fileformat = "unix"
vim.opt.formatoptions:remove { "t" }
vim.o.hidden = true
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.inccommand = "split"
vim.o.incsearch = true
vim.o.laststatus = 2
vim.opt.mouse = {}
vim.opt.undodir = os.getenv("HOME") .. "/.nvim_undo"
vim.opt.undofile = true
vim.o.ruler = false
vim.o.swapfile = false
vim.o.wrap = false
vim.o.number = true
vim.o.scrolloff = 10
vim.o.shiftwidth = 4
vim.o.showcmd = true
vim.o.signcolumn = "yes"
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.softtabstop = 4
vim.o.tabstop = 4
vim.o.updatetime = 50
vim.o.textwidth = 0
