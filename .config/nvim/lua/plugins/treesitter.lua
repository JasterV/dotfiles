return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "astro",
        "lua",
        "cmake",
        "cpp",
        "css",
        "gitignore",
        "go",
        "graphql",
        "http",
        "rust",
        "scss",
        "sql",
        "heex",
        "elixir",
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      -- MDX
      vim.filetype.add({
        extension = {
          mdx = "mdx",
        },
      })
      vim.treesitter.language.register("markdown", "mdx")
    end,
  },
}
