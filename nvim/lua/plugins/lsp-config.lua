-- learned from typecraft lsp series
-- https://github.com/cpow/neovim-for-newbs
return {

  {
    -- used to config lsp in nvim
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      -- vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },

  {
    -- language server manage tool
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },

  {
    -- Wrap non-LSP CLI tools, such as "eslint", into LSP sources
    "nvimtools/none-ls.nvim", -- null-ls is deprecated; none-ls is the alternative
    lazy = false,
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,       -- Lua formatter
          require("none-ls.diagnostics.eslint_d"),  -- ESLint diagnostics
          require("none-ls.formatting.eslint_d"),   -- ESLint formatting
          require("none-ls.code_actions.eslint_d"), -- ESLint code actions
        },
      })

      -- Manual format keybindings
      local opts = { noremap = true, silent = true }

      -- Format entire buffer
      vim.keymap.set("n", "=", function()
        vim.lsp.buf.format({ async = false })
        print("Formatting file...")
      end, vim.tbl_extend("force", opts, { desc = "Format buffer" }))
    end,
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
  }
}
