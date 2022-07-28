--[[
lvim is the global options object
]]

-- general
lvim.log.level = "warn"

lvim.format_on_save = true

lvim.colorscheme = "tokyonight"

vim.opt.relativenumber = true

lvim.use_icons = true

vim.diagnostic.config({
  virtual_text = false
})

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader                        = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"]     = ":w<cr>"
lvim.keys.normal_mode["<Leader>x"] = vim.diagnostic.open_float -- unmap a default keymapping
lvim.keys.normal_mode["<Leader>c"] = ":let @/ = \"\"<CR>"
lvim.keys.normal_mode["<Leader>k"] = ":bnext<CR>"
lvim.keys.normal_mode["<Leader>j"] = ":bprevious<CR>"
lvim.keys.normal_mode["<Leader>d"] = ":bprevious<CR>:bdelete #<CR>"
-- vim.keymap.del("n", "<C-Up>")

-- override a default keymapping
lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )
-- disable default mappings
lvim.keys.normal_mode["C-t"] = false

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")

lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = false
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.bufferline.active = true
lvim.builtin.bufferline.options = {
  always_show_bufferline = true,
  mode = "buffers"
}

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  -- "c",
  "javascript",
  "json",
  "lua",
  -- "python",
  -- "typescript",
  -- "tsx",
  "css",
  "rust",
  -- "java",
  "yaml",
  "elm"
}

lvim.builtin.treesitter.ignore_install = { "haskell" }

lvim.builtin.treesitter.highlight.enabled = true

-- lualine
local components = require("lvim.core.lualine.components")

lvim.builtin.lualine.options = {
  theme = 'auto',
  component_separators = "|",
  section_separators = { left = "", right = "" },
}
lvim.builtin.lualine.sections = {
  lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
  lualine_b = { "filename", "branch", { "diff", colored = false } },
  lualine_c = {},
  lualine_x = { components.lsp },
  lualine_y = { "filetype", "progress" },
  lualine_z = { { "location", separator = { right = "" }, left_padding = 2 } },
}
lvim.builtin.lualine.inactive_sections = {
  lualine_a = { "filename" },
  lualine_b = {},
  lualine_c = {},
  lualine_x = {},
  lualine_y = {},
  lualine_z = {},
}
-- generic LSP settings

-- ---@usage disable automatic installation of servers
lvim.lsp.automatic_servers_installation = true

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- Additional Plugins
lvim.plugins = {
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup {}
    end
  },
  {
    "nacro90/numb.nvim",
    config = function()
      require("numb").setup()
    end
  },
  { "folke/tokyonight.nvim" },
  {
    "simrat39/rust-tools.nvim",
    config = function()
      local lsp_installer_servers = require "nvim-lsp-installer.servers"
      local _, requested_server = lsp_installer_servers.get_server "rust_analyzer"
      require("rust-tools").setup({
        tools = {
          autoSetHints = true,
          hover_with_actions = true,
          runnables = {
            use_telescope = true,
          },
        },
        server = {
          cmd_env = requested_server._default_options.cmd_env,
          on_attach = require("lvim.lsp").common_on_attach,
          on_init = require("lvim.lsp").common_on_init,
        },
      })
    end,
    ft = { "rust", "rs" },
  },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.json", "*.jsonc" },
  -- enable wrap mode for json files only
  command = "setlocal wrap",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "zsh",
  callback = function()
    -- let treesitter use bash highlight for zsh files as well
    require("nvim-treesitter.highlight").attach(0, "bash")
  end,
})
