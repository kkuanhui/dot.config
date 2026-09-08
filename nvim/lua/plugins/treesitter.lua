return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" }, -- 延遲載入以加快開檔速度
  dependencies = {
    "windwp/nvim-ts-autotag", -- 自動關閉/同步修改 HTML & JSX 標籤
  }, config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "javascript",
        "typescript",
        "tsx",
        "python",
        "c",
        "cpp",
        "css",
        "markdown",
        "markdown_inline",
        "json",
        "html",
      },
      sync_install = false,
      auto_install = true, -- 當開啟新語言檔案時，自動背景下載 parser
      indent = { enable = true },
      autotag = { enable = true }, -- 啟用自動標籤功能
      highlight = {
        enable = true,
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
    })
  end,
}
