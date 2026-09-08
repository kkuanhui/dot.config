return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        color_overrides = {
          all = {
            base = "#000000",
          },
        },
        integrations = {
          neotree = true, -- 讓 Neo-tree 自動套用與主視窗一致的背景色
        },
        custom_highlights = function(colors)
          return {
            NeoTreeNormal = { bg = colors.base },
            NeoTreeNormalNC = { bg = colors.base },
            LineNr = { fg = "#737373" },
            Comment = { fg = "#adadad" },
          }
        end,
      })
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  {
    "yorickpeterse/nvim-window",
    keys = {
      {
        "<leader>ww",
        "<cmd>lua require('nvim-window').pick()<cr>",
        desc = "nvim-window: Jump to window",
      },
    },
    config = true,
  },
  {
    "alexghergh/nvim-tmux-navigation",
    config = function()
      require("nvim-tmux-navigation").setup({
        disable_when_zoomed = true, -- defaults to false
        keybindings = {
          left = "<C-h>",
          down = "<C-j>",
          up = "<C-k>",
          right = "<C-l>",
          -- last_active = "<C-\\>",
          -- next = "<C-Space>",
        },
      })
    end,
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      vim.opt.termguicolors = true
      require("bufferline").setup({})
    end,
  },
}
