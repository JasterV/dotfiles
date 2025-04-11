return {
  -- Incremental rename
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = true,
  },
  {
    "michael-a-grammar/mona.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      {
        ";m",
        "<cmd>Telescope mona elixir_project_modules<cr>",
        desc = "Project Modules",
        mode = { "n", "x" },
        ft = "elixir",
      },
    },
  },
}
