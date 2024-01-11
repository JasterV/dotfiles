return {
  -- tools
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "codelldb",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "elixir-ls",
        "eslint-lsp",
        "json-lsp",
        "markdownlint",
        "prettier",
        "rust-analyzer",
        "shfmt",
        "shellcheck",
        -- TOML toolkit
        "taplo",
        "typescript-language-server",
        "astro-language-server",
        "yaml-language-server",
        "lua-language-server",
        "stylua",
        "luacheck",
      })
    end,
  },
}
