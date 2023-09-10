-- RUST TOOLS
require("rust-tools").setup({})

-- COMMENT
require("Comment").setup(
{
  toggler = { line = "gc" },
  mappings = { basic = true,
               extra = false,
               extended = false}
})

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

-- GIT GUTTER
vim.o.updatetime = 100

-- COQ
vim.g.coq_settings = {
  auto_start = 'shut-up',
  keymap = {
    recommended = false,
    jump_to_mark = "<c-l>",
    manual_complete = "<c-x><c-o>"
  },
  clients = {
    lsp = {
      enabled = true,
    }
  }
}

local coq = require("coq")
-- Go NVIM
require('go').setup(coq.lsp_ensure_capabilities({
  goimport = 'goimports',
  lsp_gofumpt = true,
}))

-- Highlighted yank
vim.g.highlightedyank_highlight_duration = 2000

-- LEAP
require('leap').add_default_mappings()
require('leap').opts.safe_labels = {}

-- MAGIT
vim.g.magit_auto_close = 1
vim.g.magit_scrolloff = 0

-- MARKDOWN
vim.g.vim_markdown_folding_disabled = 1
vim.g.tex_conceal = ""
vim.g.vim_markdown_math = 1
vim.g.vim_markdown_json_frontmatter = 1
vim.g.mkdp_browser = "brave-browser"
vim.g.mkdp_auto_close = 0

-- WIN RESIZE
vim.g.winresizer_start_key = "<c-a>"
-- vim.keymap.set("n", "<c-w>z", function () vim.cmd[[<Plug>(zoom-toggle)]] end, { remap })
vim.cmd[[nmap <c-w>z <Plug>(zoom-toggle)]]

-- RUST VIM
vim.g.rustfmt_autosave = 0

-- NEOSNIPPET
vim.keymap.set("i", "<c-k>", function() vim.cmd[[<Plug>(neosnippet_expand_or_jump)]] end)

-- UNDOTREE
vim.g.undotree_ShortIndicators = 1
vim.g.undotree_DiffpanelHeight = 16
vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_SplitWidth = 35

-- NVIM LSP
local lspconfig = require("lspconfig")
local home = os.getenv("HOME")
lspconfig.bashls.setup(coq.lsp_ensure_capabilities({
  cmd = { home.."/.local/node_modules/bash-language-server/out/cli.js", "start" }
}))
lspconfig.ccls.setup(coq.lsp_ensure_capabilities({}))
lspconfig.dockerls.setup(coq.lsp_ensure_capabilities({
  cmd = { home.."/.local/node_modules/dockerfile-language-server-nodejs/bin/docker-langserver", "--stdio" }
}))
lspconfig.gopls.setup(coq.lsp_ensure_capabilities({}))
lspconfig.jsonls.setup(coq.lsp_ensure_capabilities({
  cmd = { home.."/.local/node_modules/vscode-langservers-extracted/bin/vscode-json-language-server", "--stdio" }
}))
lspconfig.pylsp.setup(coq.lsp_ensure_capabilities({
  settings = {
    pylsp = {
      plugins = {
        autopep8 = { enabled = false },
        flake8 = { enabled = false },
        pydocstyle = { enabled = false },
        pylint = { enabled = false },
        yapf = { enabled = true }
      }
    }
  }
}))
lspconfig.yamlls.setup(coq.lsp_ensure_capabilities({
  cmd = { home.."/.local/node_modules/yaml-language-server/bin/yaml-language-server", "--stdio" },
  settings = {
    yaml = {
      format = {
        enable = true,
        singleQuote = true,
      },
      validate = true,
      hover = true,
      editor = {
        tabSize = 4,
        formatOnType = true,
      },
      completion = true,
      schemas = {
        kubernetes = "/*.yaml",
        ["/home/mre/Downloads/github-workflow.json"] = "mean_bean_ci.yml",
      },
    }
  }
}))

