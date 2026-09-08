return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "folke/trouble.nvim", -- 確保 Trouble 被當作依賴項載入
  },
  opts = {
    trouble = true, -- 顯式開啟 Trouble 整合支援
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation (跳轉上/下一個修改區塊)
      map("n", "]c", function()
        if vim.wo.diff then return "]c" end
        vim.schedule(function() gs.next_hunk() end)
        return "<Ignore>"
      end, { expr = true, desc = "Next Git Hunk" })

      map("n", "[c", function()
        if vim.wo.diff then return "[c" end
        vim.schedule(function() gs.prev_hunk() end)
        return "<Ignore>"
      end, { expr = true, desc = "Prev Git Hunk" })

      -- Actions (單塊處理)
      map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage Hunk" })
      map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset Hunk" })
      map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Hunk" })
      map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, { desc = "Blame Line" })

      -- 🌟 Trouble 絕招整合 🌟
      -- 1. 把「全專案」所有檔案的 Git 變更列在 Trouble 面板
      map("n", "<leader>hQ", function() gs.setqflist("all") end, { desc = "Git Hunks in Trouble (Project)" })
      -- 2. 把「目前檔案」的 Git 變更列在 Trouble 面板
      map("n", "<leader>hq", gs.setqflist, { desc = "Git Hunks in Trouble (Current Buffer)" })
    end,
  },
}
