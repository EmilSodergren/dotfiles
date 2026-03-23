vim.api.nvim_create_autocmd("FileType",
  {
    group = vim.api.nvim_create_augroup("go_commands", { clear = true }),
    pattern = "go",
    callback = function()
      vim.keymap.set("n", "<leader>b", "<cmd>GoBuild<cr>", { noremap = true })
      vim.keymap.set("n", "<leader>i", "<cmd>GoInstall<cr>", { noremap = true })
      vim.keymap.set("n", "<leader>t", "<cmd>GoTest<cr>", { noremap = true })
      vim.keymap.set("n", "<leader>c", "<cmd>GoCallers<cr>", { noremap = true })
    end
  })

vim.api.nvim_create_autocmd("FileType",
  {
    group = vim.api.nvim_create_augroup("rust_commands", { clear = true }),
    pattern = { "rust" },
    callback = function()
      vim.keymap.set("n", "<leader>b", "<cmd>Cbuild<cr><bar><s-g>", { noremap = true })
      vim.keymap.set("n", "<leader>i", "<cmd>Cinstall<cr>", { noremap = true })
      vim.keymap.set("n", "<leader>t", "<cmd>Ctest -- --nocapture<cr><bar><s-g>", { noremap = true })
      vim.keymap.set("n", "<leader>bt", "<cmd>! RUST_BACKTRACE=1 cargo test <cr>,<bar><s-g>",
        { noremap = true })
    end
  })

vim.api.nvim_create_autocmd("FileType",
  {
    group = vim.api.nvim_create_augroup("override_indent_4_spc", { clear = true }),
    pattern = { "python" },
    callback = function()
      vim.opt_local.tabstop = 4
      vim.opt_local.shiftwidth = 4
      vim.opt_local.softtabstop = 4
      vim.opt_local.expandtab = true
    end
  })

vim.api.nvim_create_autocmd("FileType",
  {
    group = vim.api.nvim_create_augroup("override_indent_force_tabs", { clear = true }),
    pattern = { "Makefile", "go" },
    callback = function()
      vim.opt_local.expandtab = false
      vim.opt_local.tabstop = 2
      vim.opt_local.shiftwidth = 2
      vim.opt_local.softtabstop = 0
    end
  })

-- This function uses the go-qmk-keymap formatter to format the current buffer
local function format_keymap_c()
  if vim.fn.executable('go-qmk-keymap') ~= 1 then
    return
  end
  local buf = vim.api.nvim_get_current_buf()
  local workdir = vim.api.nvim_buf_get_name(0):match("(.*[/\\])")
  -- Write formatting to temp file
  local handle = io.popen(string.format("go-qmk-keymap -workdir %s > keymap.c.tmp", workdir), "w")
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
end

vim.api.nvim_create_augroup("format_on_save", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre",
  {
    pattern = "*",
    group = 'format_on_save',
    callback = function()
      local filename = vim.api.nvim_buf_get_name(0):match("^.+/(.+)$")
      if filename == "keymap.c" then
        format_keymap_c()
        return
      else
        -- Python formatting does not oganize imports automatically
        if vim.bo.filetype == "python" then
          vim.lsp.buf.code_action({
            context = { only = { "source.organizeImports" } },
            apply = true,
          })
          vim.wait(200)
        end
        vim.lsp.buf.format({ async = false, timeout = 2000 })
      end
    end
  })
