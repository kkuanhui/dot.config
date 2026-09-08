return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "vim", "vimdoc", "javascript", "typescript", "tsx", "html" },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      opts = {
        -- 🌟 強制啟用同步重命名與自動關閉標籤
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
      },
      -- 確保包含 TSX 與 HTML
      per_filetype = {
        ["html"] = { enable_close = true },
        ["typescriptreact"] = { enable_close = true },
        ["javascriptreact"] = { enable_close = true },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true,
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true,           -- 自動跳到下一個匹配的物件
            keymaps = {
              ["af"] = "@function.outer", -- 選取「整個 Function」
              ["if"] = "@function.inner", -- 選取「Function 內部」
              ["ac"] = "@class.outer",  -- 選取「整個 Class」
              ["ic"] = "@class.inner",  -- 選取「Class 內部」
            },
          },
          move = {
            enable = true,
            set_jumps = true,           -- 將跳轉記錄寫入 jump list (可以使用 Ctrl+o 跳回)
            goto_next_start = {
              ["]m"] = "@function.outer", -- 跳到下一個 Function 開頭
              ["]]"] = "@class.outer",  -- 跳到下一個 Class 開頭
            },
            goto_previous_start = {
              ["[m"] = "@function.outer", -- 跳到上一個 Function 開頭
              ["[["] = "@class.outer",  -- 跳到上一個 Class 開頭
            },
          },
        },
      })
    end,
  },
}
