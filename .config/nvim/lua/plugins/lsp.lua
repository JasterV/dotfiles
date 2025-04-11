return {
  -- tools
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "codelldb",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "eslint-lsp",
        "json-lsp",
        "markdownlint",
        "prettier",
        "shfmt",
        "shellcheck",
        "taplo", -- TOML toolkit
        "typescript-language-server",
        "astro-language-server",
        "yaml-language-server",
        "lua-language-server",
        "stylua",
        "luacheck",
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          filetypes_include = { "heex", "elixir" },
        },
      },
    },
  },
  {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local elixir = require("elixir")

      elixir.setup({
        nextls = { enable = true },
        elixirls = { enable = false },
        projectionist = {
          enable = true,
        },
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "srghma/nvimmer-ps",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Add plenary.nvim as a dependency
      "nvim-telescope/telescope.nvim", -- Add telescope.nvim as a dependency
    },
    config = function()
      -- or require("nvimmer-ps").setup({ keymaps = { ... } })
      require("nvimmer-ps").setup()

      local nvim_lsp = require("lspconfig")
      nvim_lsp.purescriptls.setup({
        on_attach = function(client, bufnr)
          require("nvimmer-ps").setup_on_attach(client, bufnr)
        end,
        on_init = function(client)
          require("nvimmer-ps").setup_on_init(client)
        end,
        flags = {
          debounce_text_changes = 150,
        },
        settings = {
          purescript = {
            formatter = "purs-tidy",
            addSpagoSources = true,
          },
        },
      })
    end,
  },
}
