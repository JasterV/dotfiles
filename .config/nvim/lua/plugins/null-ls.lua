return {
  -- Setup null-ls with `prettierd`
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources, {
        nls.builtins.formatting.shfmt.with({
          extra_args = { "-i", "2", "-ci" },
        }),
      })
    end,
  },
}
