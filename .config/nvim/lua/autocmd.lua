vim.api.nvim_create_augroup("numbertoggle", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" },
  {
    group = "numbertoggle",
    callback = function()
      if vim.o.number == true and vim.api.nvim_get_mode()["mode"] ~= "i" then
        vim.o.relativenumber = true
      end
    end
  })
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" },
  {
    group = "numbertoggle",
    callback = function()
      if vim.o.number == true then
        vim.o.relativenumber = false
      end
    end
  })

vim.api.nvim_create_augroup("tab_overrides", { clear = true })
vim.api.nvim_create_autocmd("FileType",
  {
    group = "tab_overrides",
    pattern = { "sh", "lua" },
    callback = function()
      vim.opt_local.tabstop = 2
      vim.opt_local.softtabstop = 2
      vim.opt_local.shiftwidth = 2
    end
  })
vim.api.nvim_create_augroup("go_commands", { clear = true })
vim.api.nvim_create_autocmd("FileType",
  {
    group = "go_commands",
    pattern = { "go" },
    callback = function()
      vim.keymap.set("n", "<leader>b", "<cmd>GoBuild<cr>", { noremap = true })
      vim.keymap.set("n", "<leader>i", "<cmd>GoInstall<cr>", { noremap = true })
      vim.keymap.set("n", "<leader>t", "<cmd>GoTest<cr>", { noremap = true })
      vim.keymap.set("n", "<leader>c", "<cmd>GoCallers<cr>", { noremap = true })
    end
  })
vim.api.nvim_create_augroup("rust_commands", { clear = true })
vim.api.nvim_create_autocmd("FileType",
  {
    group = "rust_commands",
    pattern = { "rust" },
    callback = function()
      vim.keymap.set("n", "<leader>b", "<cmd>Cbuild<cr><bar><s-g>", { noremap = true })
      vim.keymap.set("n", "<leader>i", "<cmd>Cinstall<cr>", { noremap = true })
      vim.keymap.set("n", "<leader>t", "<cmd>Ctest -- --nocapture<cr><bar><s-g>", { noremap = true })
      vim.keymap.set("n", "<leader>bt", "<cmd>! RUST_BACKTRACE=1 cargo test <cr>,<bar><s-g>", { noremap = true })
    end
  })
vim.api.nvim_create_augroup("json_indent", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" },
  {
    group = "json_indent",
    pattern = "json",
    command = "setlocal shiftwidth=2 tabstop=2 softtabstop=2"
  })
vim.api.nvim_create_autocmd("TermOpen",
  {
    callback = function()
      vim.o.bufhidden = 'wipe'
    end
  })
vim.api.nvim_create_augroup("format_on_save", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre",
  {
    pattern = "*",
    group = 'format_on_save',
    callback = function()
      local filename = vim.api.nvim_buf_get_name(0):match("^.+/(.+)$")
      if vim.bo.filetype == "go" then
        require('go.format').goimport()
      elseif filename == "keymap.c" then
        if vim.fn.executable('go-qmk-keymap') ~= 1 then
          return
        end
        local buf = vim.api.nvim_get_current_buf()
        -- Write formatting to temp file
        local handle = io.popen("go-qmk-keymap > keymap.c.tmp", "w")
        local content = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
        handle:write(table.concat(content, "\n"))
        handle:close()
        -- Read back the formatted value to the buffer
        local handle = io.open("keymap.c.tmp", "r")
        local form_content = handle:read("*a")
        handle:close()
        local t = {}
        for line in string.gmatch(form_content, "(.-)%c") do
          table.insert(t, line)
        end
        vim.api.nvim_buf_set_text(buf, 0, 0, -1, -1, t)
        os.remove("keymap.c.tmp")
      else
        vim.lsp.buf.format({ async = false, timeout = 2000 })
      end
    end
  })
vim.api.nvim_create_augroup("XML_filetype", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" },
  {
    pattern = "*.xml",
    group = "XML_filetype",
    callback = function()
      vim.bo.equalprg = 'xmllint --format --recover - 2>/dev/null'
    end
  })
vim.api.nvim_create_autocmd("BufWritePre",
  {
    pattern = "*.xml",
    group = "XML_filetype",
    callback = function()
      vim.cmd(vim.api.nvim_replace_termcodes("normal gg=G", true, true, true))
    end
  })
vim.api.nvim_create_augroup("Jenkinsfile_filetype", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" },
  {
    group = "Jenkinsfile_filetype",
    callback = function()
      if vim.api.nvim_buf_get_name(0):match(".*/Jenkinsfile$") ~= nil then
        vim.bo.filetype = 'groovy'
      end
    end
  })
