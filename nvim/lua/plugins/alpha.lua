return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.startify")
    dashboard.section.header.val = {
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                     ]],
      [[       ████ ██████           █████      ██                     ]],
      [[      ███████████             █████                             ]],
      [[      █████████ ███████████████████ ███   ███████████   ]],
      [[     █████████  ███    █████████████ █████ ██████████████   ]],
      [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
      [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
      [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
    }
    alpha.setup(dashboard.opts)


    -- 🚫 攔截 Alpha 畫面的 "q",不讓它直接離開 nvim
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "alpha",
      callback = function(args)
        vim.keymap.set("n", "q", function() end, { buffer = args.buf, silent = true, nowait = true })
      end
    })

    -- 🛡️ 防禦機制:確保永遠有一個非 neo-tree 的視窗存在
    vim.api.nvim_create_autocmd({ "BufEnter", "WinClosed" }, {
      group = vim.api.nvim_create_augroup("AlphaFallback", { clear = true }),
      nested = true,
      callback = function()
        -- 正在離開 nvim 時(:qa!、:qa、Alpha 裡選 quit 都算),不要插手
        if vim.v.exiting ~= vim.NIL then
          return
        end

        vim.schedule(function()
          local wins = vim.api.nvim_tabpage_list_wins(0)
          local neotree_win = nil
          local has_other_win = false

          for _, w in ipairs(wins) do
            if vim.api.nvim_win_is_valid(w)
                and vim.api.nvim_win_get_config(w).relative == "" then
              local buf = vim.api.nvim_win_get_buf(w)
              local ft = vim.bo[buf].filetype
              if ft == "neo-tree" then
                neotree_win = w
              else
                has_other_win = true
              end
            end
          end

          -- 除了 neo-tree(或什麼都沒有)以外,找不到任何其他視窗
          if not has_other_win then
            if neotree_win and vim.api.nvim_win_is_valid(neotree_win) then
              vim.api.nvim_set_current_win(neotree_win)
              vim.cmd("belowright vsplit")

              local ok, neotree_config = pcall(function()
                return require("neo-tree").config.filesystem.window.width
              end)
              vim.api.nvim_win_set_width(neotree_win, ok and neotree_config or 40)
            end
            vim.cmd("Alpha")
          end
        end)
      end,
    })
  end,
}
