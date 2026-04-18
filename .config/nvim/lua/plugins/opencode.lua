if vim.fn.executable("opencode") == 1 then
  vim.pack.add({
    { src = "https://github.com/sudo-tee/opencode.nvim", version = "main" },
  })

  require('opencode').setup({
    preferred_picker = 'fzf',
    preferred_completion = 'blink',
    default_mode = 'plan',
  })
end
