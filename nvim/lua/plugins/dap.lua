return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",
  },
  keys = {
    -- 💥 專為 Mac 打造的人工力學按鍵映射 💥
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Debug: Start/Continue" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Debug: Step Into" },
    { "<leader>do", function() require("dap").step_over() end, desc = "Debug: Step Over" },
    { "<leader>dO", function() require("dap").step_out() end, desc = "Debug: Step Out" },
    { "<leader>dq", function() require("dap").terminate() end, desc = "Debug: Quit/Stop" },
    { "<leader>du", function() require("dapui").toggle() end, desc = "Debug: Toggle UI" },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- 1. Mason 自動管理 Adapter
    require("mason-nvim-dap").setup({
      automatic_installation = true,
      handlers = {},
      ensure_installed = { "js", "codelldb" },
    })

    -- 2. 基礎 Virtual Text
    require("nvim-dap-virtual-text").setup()

    -- 3. 預設 DAP UI 設定
    dapui.setup()

    -- 4. 斷點與停留點圖示
    vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = "👉", texthl = "", linehl = "", numhl = "" })

    -- 5. 啟動與結束自動開關 UI
    dap.listeners.before.attach.dapui_config = function() dapui.open() end
    dap.listeners.before.launch.dapui_config = function() dapui.open() end
    dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
    dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
  end,
}
