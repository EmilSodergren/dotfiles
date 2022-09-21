-- AIRLINE {{{
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
-- }}}
-- DEOPLETE
vim.cmd[["airline#parts#define('colnr', {'raw': ' %{g:airline_symbols.colnr}:%v ','accent': 'bold'})"]]
vim.g["deoplete#enable_at_startup"] = 1
vim.g["echodoc#enable_at_startup"] = 1
vim.g["echodoc#type"] = "signature"
vim.cmd[["deoplete#custom#option({'auto_complete_delay': 200, 'smart_case': v:true, })"]]
vim.cmd[["deoplete#custom#source('_', 'max_abbr_width', 60)"]]
vim.cmd[["deoplete#custom#var('around', {'range_above': 30, 'range_below': 15, 'mark_above': '[↑]', 'mark_below': '[↓]', 'mark_changes': '[*]', })"]]

-- GIT GUTTER
vim.o.updatetime = 100

-- VIM-GO
vim.g.go_fmt_autosave = 0
vim.g.go_fmt_command = ""
vim.g.go_code_completion_enabled = 0
vim.g.go_mod_fmt_autosave = 0

-- Highlighted yank
vim.g.highlightedyank_highlight_duration = 2000

-- MAGIT
vim.g.magit_auto_close = 1
vim.g.magit_scrolloff = 0

-- MARKDOWN
vim.g.vim_markdown_folding_disabled = 1
vim.g.tex_conceal = ""
vim.g.vim_markdown_math = 1
vim.g.vim_markdown_json_frontmatter = 1
vim.g.mkdp_browser = 'brave-browser'
vim.g.mkdp_auto_close = 0

-- WIN RESIZE
vim.g.winresizer_start_key = '<c-a>'
vim.keymap.set('n', '<c-w>z', '<Plug>(zoom-toggle)', { remap })

-- RUST VIM
vim.g.rustfmt_autosave = 0

-- NEOSNIPPET

-- UNDOTREE
vim.g.undotree_ShortIndicators = 1
vim.g.undotree_DiffpanelHeight = 16
vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_SplitWidth = 35

-- NVIM LSP
require("rust-tools").setup({})
local lspconfig = require("lspconfig")
local home = os.getenv("HOME");
lspconfig.bashls.setup{
  cmd = { home.."/.local/node_modules/bash-language-server/bin/main.js", "start" }
}
lspconfig.ccls.setup{}
lspconfig.dockerls.setup{
  cmd = { home.."/.local/node_modules/dockerfile-language-server-nodejs/bin/docker-langserver", "--stdio" }
}
lspconfig.gopls.setup{}
lspconfig.pylsp.setup{}
lspconfig.yamlls.setup{
  cmd = { home.."/.local/node_modules/yaml-language-server/bin/yaml-language-server", "--stdio" },
  settings = {
    yaml = {
      completion = true,
      schemas = {
        kubernetes = "*.yaml",
        ["/home/mre/Downloads/github-workflow.json"] = "mean_bean_ci.yml"
      }
    }
  }
}

