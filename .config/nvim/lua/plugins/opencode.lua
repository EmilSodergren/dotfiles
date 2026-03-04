return {
  "nickjvandyke/opencode.nvim",
  version = "*",
  dependencies = {
    "MeanderingProgrammer/render-markdown.nvim",
  },
  lazy = false,
  enabled = vim.fn.executable("opencode") == 1,
  config = function()
    vim.o.autoread = true
    vim.keymap.set({ "n", "x" }, "<leader>op", function() require("opencode").ask("@this: ", { submit = true }) end,
      { desc = "Ask opencode…" })
    vim.keymap.set({ "n", "x" }, "<leader>os", function() require("opencode").select() end,
      { desc = "Execute opencode action…" })
    vim.keymap.set({ "n", "t" }, "<leader>oo", function() require("opencode").toggle() end, { desc = "Toggle opencode" })

    vim.keymap.set({ "n", "x" }, "go", function() return require("opencode").operator("@this ") end,
      { desc = "Add range to opencode", expr = true })
    vim.keymap.set("n", "goo", function() return require("opencode").operator("@this ") .. "_" end,
      { desc = "Add line to opencode", expr = true })

    vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,
      { desc = "Scroll opencode up" })
    vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end,
      { desc = "Scroll opencode down" })

    -- -- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above — otherwise consider `<leader>o…` (and remove terminal mode from the `toggle` keymap)
    -- vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
    -- vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
  end,
}
