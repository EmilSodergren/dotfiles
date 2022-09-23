vim.api.nvim_create_augroup("numbertoggle", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter","FocusGained", "InsertLeave","WinEnter" },
{
  group = "numbertoggle",
  callback = function()
    if vim.o.number == true and vim.api.nvim_get_mode()["mode"] ~= "i" then
        vim.o.relativenumber = true
    end
  end
})
vim.api.nvim_create_autocmd({ "BufLeave","FocusLost", "InsertEnter","WinLeave" },
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
  pattern = { "yaml", "sh", "lua" },
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
    vim.keymap.set("n", "<leader>b", "<cmd>GoBuild<cr>", { noremap })
    vim.keymap.set("n", "<leader>i", "<cmd>GoInstall<cr>", { noremap })
    vim.keymap.set("n", "<leader>t", "<cmd>GoTest<cr>", { noremap })
    vim.keymap.set("n", "<leader>c", "<cmd>GoCallers<cr>", { noremap })
  end
})
vim.api.nvim_create_augroup("rust_commands", { clear = true })
vim.api.nvim_create_autocmd("FileType",
{
  group = "rust_commands",
  pattern = { "rust" },
  callback = function()
    vim.keymap.set("n", "<leader>b", "<cmd>Cbuild<cr><bar><s-g>", { noremap })
    vim.keymap.set("n", "<leader>i", "<cmd>Cinstall<cr>", { noremap })
    vim.keymap.set("n", "<leader>t", "<cmd>Ctest -- --nocapture<cr><bar><s-g>", { noremap })
    vim.keymap.set("n", "<leader>bt", "<cmd>! RUST_BACKTRACE=1 cargo test <cr>,<bar><s-g>", { noremap })
  end
})
vim.api.nvim_create_augroup("python_commands", { clear = true })
vim.api.nvim_create_autocmd("FileType",
{
  group = "python_commands",
  pattern = { "python" },
  callback = function()
    vim.keymap.set("n", "<leader>b", "<cmduCbuild<cr><bar><s-g>", { noremap })
    vim.keymap.set("n", "<leader>i", "<cmd>Cinstall<cr>", { noremap })
    vim.keymap.set("n", "<leader>t", "<cmd>Ctest -- --nocapture<cr><bar><s-g>", { noremap })
    vim.keymap.set("n", "<leader>bt", "<cmd>! RUST_BACKTRACE=1 cargo test <cr>,<bar><s-g>", { noremap })
  end
})
--" Json file settings {{{
--augroup FT_python
--    au!
--    autocmd FileType json setlocal equalprg=python3\ -m\ json.tool
--augroup END
--"" }}}
