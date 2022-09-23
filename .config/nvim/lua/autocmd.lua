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

vim.api.nvim_create_autocmd("FileType",
{ pattern="yaml",
  callback = function()
    vim.opt_local.indentkeys:remove {"<:>"}
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
  end
})
-- vim.cmd([[
--autocmd filetype yaml setlocal indentkeys-=<:> ts=2 sts=2 sw=2 expandtab
--]])
-- autocmd filetype sh,lua setlocal ts=2 sts=2 sw=2 expandtab
--" }}}
--" Vimscript file settings {{{
--augroup FT_vim
--    au!
--    autocmd filetype vim let b:mycomment = "\""
--    autocmd filetype vim setlocal foldmethod=marker
--augroup end
--augroup reload_vimrc
--    autocmd!
--    autocmd BufWritePost $HOME . '/.dotfiles/.vim/vimrc' source $MYVIMRC
--augroup END
--" }}}
--" Go file settings {{{
--augroup FT_go
--    au!
--    autocmd FileType go nnoremap <leader>b :GoBuild <cr>
--    autocmd FileType go nnoremap <leader>i :GoInstall <cr>
--    autocmd FileType go nnoremap <leader>t :GoTest <cr>
--    autocmd FileType go nnoremap <leader>c :GoCallers <cr>
--augroup END
--" }}}
--" Rust file settings {{{
--augroup FT_rust
--    au!
--    autocmd FileType rust nnoremap <leader>b :Cbuild <cr> <bar> <s-g>
--    autocmd FileType rust nnoremap <leader>i :Cinstall <cr>
--    autocmd FileType rust nnoremap <leader>t :Ctest -- --nocapture <cr> <bar> <s-g>
--    autocmd FileType rust nnoremap <leader>bt :! RUST_BACKTRACE=1 cargo test <cr> <bar> <s-g>
--augroup END
--" }}}
--" Json file settings {{{
--augroup FT_python
--    au!
--    autocmd FileType json setlocal equalprg=python3\ -m\ json.tool
--augroup END
--"" }}}
