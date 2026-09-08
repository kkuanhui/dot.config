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
          visible = true,
          hide_dotfiles = true,
          hide_gitignored = true,
        },
        window = {
          mappings = {
            -- 💥 攔截 "/" 鍵：切回主視窗後爆破開啟 Telescope find_files 💥
            ["/"] = function(state)
              local node = state.tree:get_node()
              local path = node.path
              if node.type ~= "directory" then
                path = vim.fs.dirname(path)
              end

              local neotree_win = vim.api.nvim_get_current_win()

              vim.schedule(function()
                local target_win = nil
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                  if win ~= neotree_win then
                    local buf = vim.api.nvim_win_get_buf(win)
                    if vim.bo[buf].filetype ~= "neo-tree" then
                      target_win = win
                      break
                    end
                  end
                end

                if target_win then
                  vim.api.nvim_set_current_win(target_win)
                else
                  vim.cmd("wincmd l")
                  if vim.api.nvim_get_current_win() == neotree_win then
                    vim.cmd("vsplit")
                  end
                end

                local opts = {
                  cwd = path,
                  prompt_title = "Find Files in: " .. vim.fs.basename(path),
                }
                _G.__telescope_last_opts = opts
                require("telescope.builtin").find_files(opts)
              end)
            end,
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

    -- 啟動 Neovim 時自動開啟 Neo-tree
    vim.api.nvim_create_autocmd("VimEnter", {
      command = "Neotree show",
    })
  end,
}
