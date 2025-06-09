-- RUST TOOLS
require("rust-tools").setup({})

-- COMMENT
require("Comment").setup(
  {
    toggler = { line = "gc" },
    mappings = {
      basic = true,
      extra = false,
      extended = false
    }
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

-- COQ
vim.g.coq_settings = {
  auto_start = 'shut-up',
  keymap = {
    recommended = false,
    jump_to_mark = "<leader>,",
    manual_complete = "<c-x><c-o>"
  },
  clients = {
    lsp = {
      enabled = true,
    }
  }
}

-- GITSIGNS
require("gitsigns").setup({
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    -- Actions
    map('n', '<leader>hs', gs.stage_hunk)
    map('n', '<leader>hr', gs.reset_hunk)
    map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
    map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line { full = true } end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)
  end
})

local coq = require("coq")
-- Go NVIM
require('go').setup()

-- Highlighted yank
vim.g.highlightedyank_highlight_duration = 2000

-- LEAP
require('leap').add_default_mappings()
require('leap').opts.safe_labels = {}

-- OIL
require("oil").setup({
  skip_confirm_for_simple_edits = true,
  float = {
    padding = 3,
    max_width = 100,
    max_height = 50,
  },
  columns = {
    "icon",
    "permissions"
  },
})

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
vim.cmd [[nmap <c-w>z <Plug>(zoom-toggle)]]

-- RUST VIM
vim.g.rustfmt_autosave = 0

-- NEOGIT
require("neogit").setup({
  mappings = {
    status = {
      ["<space>"] = "Toggle",
    }
  },
  commit_editor = { kind = "split" }
})

-- TREESITTER
require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  }
})

-- UNDOTREE
vim.g.undotree_ShortIndicators = 1
vim.g.undotree_DiffpanelHeight = 16
vim.g.undotree_SetFocusWhenToggle = 1
vim.g.undotree_SplitWidth = 35

-- NVIM LSP
local lspconfig = require("lspconfig")
local home = os.getenv("HOME")

vim.lsp.config("ansiblels", coq.lsp_ensure_capabilities({
  cmd = { home .. "/.local/node_modules/@ansible/ansible-language-server/bin/ansible-language-server", "--stdio" }
}))
vim.lsp.enable("ansiblels")

vim.lsp.config("bashls", coq.lsp_ensure_capabilities({
  cmd = { home .. "/.local/node_modules/bash-language-server/out/cli.js", "start" }
}))
vim.lsp.enable("bashls")

vim.lsp.config("ccls", coq.lsp_ensure_capabilities({}))
vim.lsp.enable("ccls")

vim.lsp.config("dockerls", coq.lsp_ensure_capabilities({
  cmd = { home .. "/.local/node_modules/dockerfile-language-server-nodejs/bin/docker-langserver", "--stdio" }
}))
vim.lsp.enable("dockerls")

vim.lsp.config("lua_ls", coq.lsp_ensure_capabilities({
  cmd = { home .. "/.local/bin/lua-language-server" },
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      }
    }
  }
}))
vim.lsp.enable("lua_ls")

vim.lsp.config("marksman", coq.lsp_ensure_capabilities({
  cmd = { home .. "/.local/bin/marksman", "server" }
}))
vim.lsp.enable("marksman")

vim.lsp.config("gopls", coq.lsp_ensure_capabilities({
  settings = {
    analyses = {
      unusedparams = true,
    },
    gopls = {
      staticcheck = true,
      gofumpt = true,
    }
  }
}))
vim.lsp.enable("gopls")

vim.lsp.config("golangci_lint_ls", coq.lsp_ensure_capabilities({
  cmd = { home .. "/go/bin/golangci-lint-langserver" },
  root_markers = { "go.mod", "go.work", ".git" },
  settings = {
    init_options = {
      command = { 'golangci-lint', 'run', '--fast-only', '--output.json.path=stdout', '--show-stats=false' },
    }
  }
}))
vim.lsp.enable("golangci_lint_ls")

vim.lsp.config("jsonls", coq.lsp_ensure_capabilities({
  cmd = { home .. "/.local/node_modules/vscode-langservers-extracted/bin/vscode-json-language-server", "--stdio" }
}))
vim.lsp.enable("jsonls")

vim.lsp.config("pylsp", coq.lsp_ensure_capabilities({
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
vim.lsp.enable("pylsp")

vim.lsp.config("yamlls", coq.lsp_ensure_capabilities({
  cmd = { home .. "/.local/node_modules/yaml-language-server/bin/yaml-language-server", "--stdio" },
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
vim.lsp.enable("yamlls")
