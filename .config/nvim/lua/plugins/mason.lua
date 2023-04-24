return {
  {
    "williamboman/mason.nvim",
    opts = {
      -- add any tools you want to have installed below
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "bash-language-server",
        "flake8",
        "elixir-ls",
        "rustfmt",
        "rust-analyzer",
        "deno"
        -- "gopls",
        -- "gofumpt",
      },
    },
  },
}
