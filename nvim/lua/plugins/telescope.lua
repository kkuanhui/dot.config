return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>p", "<cmd>Telescope find_files<cr>", desc = 'Find Files' },
      { "<leader>b", "<cmd>Telescope buffers<cr>",    desc = 'Find Buffers' },
      {
        "<leader>g",
        function()
          local opts = { cwd = vim.fn.expand("%:p:h") }
          _G.__telescope_last_opts = opts
          require("telescope.builtin").live_grep(opts)
        end,
        desc = "Live grep in current buffer's directory"
      },
      { "<leader>t", "<cmd>Telescope telescope-tabs list_tabs<cr>", desc = 'List Tabs' },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local builtin = require("telescope.builtin")

      local function switch_picker(kind)
        return function(prompt_bufnr)
          local opts = vim.tbl_extend("force", {}, _G.__telescope_last_opts or {})
          actions.close(prompt_bufnr)

          local base_dir = opts.cwd and vim.fs.basename(opts.cwd) or nil

          if kind == "find_files" then
            opts.prompt_title = base_dir and ("Find Files in: " .. base_dir) or "Find Files"
            builtin.find_files(opts)
          else
            opts.prompt_title = base_dir and ("Live Grep in: " .. base_dir) or "Live Grep"
            builtin.live_grep(opts)
          end
        end
      end

      telescope.setup({
        defaults = {
          file_ignore_patterns = {
            "node_modules",
          },
          mappings = {
            n = {
              ["<c-d>"] = actions.delete_buffer,
              ["<C-f>"] = switch_picker("find_files"),
              ["<C-g>"] = switch_picker("live_grep"),
            },
            i = {
              ["<C-h>"] = "which_key",
              ["<c-d>"] = actions.delete_buffer,
              ["<C-f>"] = switch_picker("find_files"),
              ["<C-g>"] = switch_picker("live_grep"),
            },
          },
        },
      })
    end,
  },
  {
    "LukasPietzschmann/telescope-tabs",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      local telescope = require("telescope")
      local telescope_tabs = require("telescope-tabs")

      telescope_tabs.setup({
        close_tab_shortcut_i = "<C-d>",
        close_tab_shortcut_n = "D",
        show_preview = true,
        entry_ordinal = function(tab_id, buffer_ids, file_names, file_paths, is_current)
          return table.concat(file_names, " ")
        end,
        entry_formatter = function(tab_id, buffer_ids, file_names, file_paths, is_current)
          local entry_string = table.concat(file_names, ", ")
          return string.format("%d: %s%s", tab_id, entry_string, is_current and " <" or "")
        end,
      })

      telescope.load_extension("telescope-tabs")
    end,
  },
}
