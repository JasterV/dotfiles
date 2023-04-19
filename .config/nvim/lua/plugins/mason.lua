return {
  {
    "williamboman/mason.nvim",
    opts = {
      -- add any tools you want to have installed below
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "elixir-ls",
        "rustfmt",
        "rust-analyzer",
        "gopls",
        "gofumpt",
        "bash-language-server",
      },
    },
  },
}
