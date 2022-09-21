vim.g.airline_theme = "dark"
vim.g["airline#extensions#tabline#enabled"] = 1
vim.g["airline#extensions#tabline#formatter"] = "unique_tail_improved"
vim.g["airline#extensions#tabline#fnamemod"] = ":p:."
vim.g["airline#extensions#tabline#buffers_label"] = ""
vim.g["airline#extensions#tabline#tab_min_count"] = 2
vim.g["airline_powerline_fonts"] = 1
vim.g["airline#extensions#tabline#left_sep"] = ""
vim.g["airline#extensions#tabline#left_alt_sep"] = ""
vim.g["airline#extensions#whitespace#enabled"] = 1
vim.g["airline#extensions#whitespace#mixed_indent_algo"] = 1

vim.g.airline_left_sep = ""
vim.g.airline_left_alt_sep = ""
vim.g.airline_right_sep = ""
vim.g.airline_right_alt_sep = ""
vim.g.airline_detect_modified = 1

vim.cmd[["airline#parts#define('colnr', {'raw': ' %{g:airline_symbols.colnr}:%v ','accent': 'bold'})"]]
