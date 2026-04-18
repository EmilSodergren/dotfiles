vim.pack.add({
  { src = "https://github.com/folke/tokyonight.nvim", version = "main" },
})

require("tokyonight").setup({
  style = "night",
  transparent = false,
  styles = {
    functions = {}
  },
  on_colors = function(colors)
    colors.yellow = "#ffff8f"
  end,

  on_highlights = function(hl, c)
    hl.String = { fg = c.yellow, }
    hl.MiniCursorword = { bg = "none", bold = true, }
    hl.MiniCursorwordCurrent = { bg = "none", bold = false, }
    hl.MiniTablineCurrent = { bg = "none", bold = true, }
    hl.MiniTrailspace = { bg = "#5f0000", }

    hl.DapBreakpoint = { link = "@variable" }
    hl.DapStoppedLine = { fg = c.green, }

    hl.DiffAdd = { bg = "none", fg = "#55EE33" }
    hl.GitSignsAdd = { link = "DiffAdd" }
    hl.NeogitChangeAdded = { link = "DiffAdd" }
    hl.NeogitDiffAdd = { link = "DiffAdd" }
    hl.NeogitDiffAddHighlight = { link = "NeogitDiffAdd" }
    hl.diffNewFile = { link = "DiffAdd" }
    hl.diffAdded = { link = "DiffAdd" }

    hl.DiffChange = { bg = "none", fg = "#EEC933" }
    hl.GitSignsChange = { link = "DiffChange" }
    hl.NeogitChangeUpdated = { link = "DiffChange" }

    hl.DiffDelete = { bg = "none", fg = "#EE3333" }
    hl.GitSignsDelete = { link = "DiffDelete" }
    hl.NeogitChangeDeleted = { link = "DiffDelete" }
    hl.NeogitDiffDelete = { link = "DiffDelete" }
    hl.NeogitDiffDeleteHighlight = { link = "DiffDelete" }
    hl.diffRemoved = { link = "DiffDelete" }
    hl.diffOldFile = { link = "DiffDelete" }
  end,
})

vim.cmd("colorscheme tokyonight")
