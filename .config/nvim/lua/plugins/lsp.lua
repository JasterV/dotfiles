return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        elixirls = {},
        rust_analyzer = {},
        gopls = {},
        bashls = {},
        denols = {
          root_dir = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc"),
        },
        tsserver = {
          root_dir = require("lspconfig.util").root_pattern("package.json"),
          single_file_support = false,
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "simrat39/rust-tools.nvim",
    },
    opts = {
      servers = {
        rust_analyzer = {},
      },
      setup = {
        rust_analyzer = function(_, opts)
          require("rust-tools").setup({ server = opts })
          return true
        end,
      },
    },
  },
}
