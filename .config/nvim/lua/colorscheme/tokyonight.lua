vim.pack.add({
  { src = "https://github.com/folke/tokyonight.nvim", version = "main" },
})

require("tokyonight").setup({
  -- use the night style
  style = "night",
  transparent = false,
  -- disable italic for functions
  styles = {
    functions = {}
  },
  -- Change the "hint" color to the "orange" color, and make the "error" color bright red
  on_colors = function(colors)
    colors.yellow = "#ffff8f"
    -- colors.hint = colors.orange
    -- colors.error = "#ff0000"
  end,

  on_highlights = function(hl, c)
    hl.String = { fg = c.yellow, }
    hl.MiniCursorword = { bg = none, bold = true, }
    hl.MiniCursorwordCurrent = { bg = none, bold = false, }
    hl.MiniTablineCurrent = { bg = none, bold = true, }
  end,
})

vim.cmd("colorscheme tokyonight")
