vim.pack.add({
  { src = "https://github.com/mfussenegger/nvim-dap",        version = "master" },
  { src = "https://github.com/mfussenegger/nvim-dap-python", version = "master" },
  { src = "https://github.com/igorlfs/nvim-dap-view",        version = vim.version.range("^1") },
  { src = "https://github.com/leoluz/nvim-dap-go",           version = "main" },
})

require("dap-view").setup({
  virtual_text = { enabled = true }
})
require("dap-go").setup({})
require("dap-python").setup("python3")

-- Listeners to automatically show hide dap view
local dap = require("dap")
dap.listeners.before.attach.dapui_config = function() vim.cmd("DapViewOpen") end
dap.listeners.before.launch.dapui_config = function() vim.cmd("DapViewOpen") end
dap.listeners.before.event_terminated.dapui_config = function() vim.cmd("DapViewClose") end
dap.listeners.before.event_exited.dapui_config = function() vim.cmd("DapViewClose") end

dap.adapters.codelldb = {
  type = 'executable',
  command = 'codelldb',
  name = "codelldb",
}

dap.configurations.rust = {
  {
    name = "Debug Binary",
    type = "codelldb",
    request = "launch",
    program = function()
      -- Returns path to executable; often requires running cargo build first
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
  },
}

vim.fn.sign_define('DapBreakpoint', { text = 'B', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointCondition', { text = 'C', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
vim.fn.sign_define('DapLogPoint', { text = 'L', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '→', texthl = 'DapStoppedLine', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected', { text = 'R', texthl = 'DapBreakpoint', linehl = '', numhl = '' })

vim.keymap.set('n', '<F8>', function() require('dap').continue() end)
vim.keymap.set('n', '<F9>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_out() end)
vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<leader>lp',
  function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
-- vim.keymap.set('n', '<Leader>df', function()
--   local widgets = require('dap.ui.widgets')
--   widgets.centered_float(widgets.frames)
-- end)
-- vim.keymap.set('n', '<Leader>ds', function()
--   local widgets = require('dap.ui.widgets')
--   widgets.centered_float(widgets.scopes)
-- end)
