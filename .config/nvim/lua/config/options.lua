vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- vim.g.bash_ctrl_j = "off"
vim.g.python_host_prog = "/usr/bin/python2"
vim.g.python3_host_prog = "/usr/bin/python3"
vim.g.python3_host_skip_check = 1
vim.g.netrw_dirhistmax = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.o.timeoutlen = 600
vim.o.ttimeoutlen = 0

vim.o.list = false
vim.o.autoindent = true
vim.o.backspace = "indent"
vim.o.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
vim.o.cmdheight = 2
vim.o.cursorline = false
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
vim.o.showcmd = true
vim.o.signcolumn = "yes"
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.updatetime = 50
vim.o.textwidth = 0
vim.o.termguicolors = true

-- -- Use 2 space indent by default
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.softtabstop = 2

require("vim._core.ui2").enable({
  enable = true,
  msg = {
    targets = {
      [""] = "msg",
      empty = "cmd",
      bufwrite = "msg",
      confirm = "cmd",
      emsg = "pager",
      echo = "msg",
      echomsg = "msg",
      echoerr = "pager",
      completion = "cmd",
      list_cmd = "pager",
      lua_error = "pager",
      lua_print = "msg",
      progress = "pager",
      rpc_error = "pager",
      quickfix = "msg",
      search_cmd = "cmd",
      search_count = "cmd",
      shell_cmd = "pager",
      shell_err = "pager",
      shell_out = "pager",
      shell_ret = "msg",
      undo = "msg",
      verbose = "pager",
      wildlist = "cmd",
      wmsg = "msg",
      typed_cmd = "cmd",
    },
    cmd = {
      height = 0.5,
    },
    dialog = {
      height = 0.5,
    },
    msg = {
      height = 0.3,
      timeout = 5000,
    },
    pager = {
      height = 0.5,
    },
  },
})
