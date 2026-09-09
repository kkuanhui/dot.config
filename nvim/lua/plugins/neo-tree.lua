return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  lazy = false,
  config = function()
    require("neo-tree").setup({
      popup_border_style = "NC",
      filesystem = {
        filtered_items = {
          visible = false,
          hide_dotfiles = true,
          hide_gitignored = true,
        },
        enable_git_status = true,
        enable_diagnostics = true,
        window = {
          mappings = {
            ["o"] = { "toggle_node", nowait = true },
            ["oc"] = "noop",
            ["od"] = "noop",
            ["og"] = "noop",
            ["om"] = "noop",
            ["on"] = "noop",
            ["os"] = "noop",
          },
        },
      },
    })

    -- 🔍 popup（help 視窗等）裡把 "/" 還原成 Vim 原生搜尋
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("NeoTreePopupSearch", { clear = true }),
      pattern = "neo-tree-popup",
      callback = function(args)
        vim.schedule(function()
          if not vim.api.nvim_buf_is_valid(args.buf) then
            return
          end
          pcall(vim.keymap.del, "n", "/", { buffer = args.buf })
        end)
      end,
    })

    -- 🔍 neo-tree 本體：刪掉 "/" 和排序前綴，"/" 交還給原生搜尋
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("NeoTreeUnmapSort", { clear = true }),
      pattern = "neo-tree",
      callback = function(args)
        vim.schedule(function()
          if not vim.api.nvim_buf_is_valid(args.buf) then
            return
          end
          for _, key in ipairs({ "/", "oc", "od", "og", "om", "on", "os" }) do
            pcall(vim.keymap.del, "n", key, { buffer = args.buf })
          end
        end)
      end,
    })

    -- 🚫 搜尋高亮不要外洩到其他 pane
    local hl_group = vim.api.nvim_create_augroup("NeoTreeSearchIsolate", { clear = true })
    local saved_hlsearch = nil

    vim.api.nvim_create_autocmd("BufEnter", {
      group = hl_group,
      callback = function()
        if vim.bo.filetype == "neo-tree" and saved_hlsearch == nil then
          saved_hlsearch = vim.o.hlsearch
          vim.o.hlsearch = false
        end
      end,
    })

    vim.api.nvim_create_autocmd("BufLeave", {
      group = hl_group,
      callback = function()
        if vim.bo.filetype == "neo-tree" and saved_hlsearch ~= nil then
          vim.o.hlsearch = saved_hlsearch
          saved_hlsearch = nil
          vim.cmd("nohlsearch")
        end
      end,
    })

    -- 啟動 Neovim 時自動開啟 Neo-tree
    vim.api.nvim_create_autocmd("VimEnter", {
      command = "Neotree show",
    })
  end,
}
