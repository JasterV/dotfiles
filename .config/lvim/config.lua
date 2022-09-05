--[[
 GENERAL VIM CONFIG
--]]

vim.opt.termguicolors = true
vim.opt.relativenumber = true

--[[
 GENERAL LVIM CONFIG
--]]

lvim.use_icons = true
lvim.colorscheme = "tokyonight"
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.transparent_window = false
-- Disable virtual text
lvim.lsp.diagnostics.virtual_text = false

--[[
 KEYMAPS
--]]

lvim.leader                      = "space"
lvim.keys.normal_mode["<C-s>"]   = ":w<CR>"
lvim.keys.normal_mode["<C-q>"]   = ":q<CR>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )
lvim.keys.normal_mode["<C-t>"]   = false
lvim.keys.normal_mode["<Tab>"]   = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-Tab>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<C-n>"]   = ":NvimTreeToggle<CR>"

-- WhichKey Keymaps
lvim.builtin.which_key.mappings["c"]  = { ":let @/ = \"\"<CR>", "Clear search" }
lvim.builtin.which_key.mappings["d"]  = { ":bprevious<CR>:bdelete #<CR>", "Close bufferline tab" }
lvim.builtin.which_key.mappings["bc"] = { ":BufferKill<CR>", "Close buffer" }
lvim.builtin.which_key.mappings["lt"] = { "<cmd>lua require('lsp_lines').toggle()<cr>", "Toggle LSP lines" }
lvim.builtin.which_key.mappings["gP"] = { ":Git pull<CR>", "Git pull" }

--[[
 BUILTIN PLUGINS

 After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
--]]

-- Alpha
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"

-- Notify
lvim.builtin.notify.active = true

-- Terminal
lvim.builtin.terminal.active = false

-- Gitsigns
lvim.builtin.gitsigns.active = false

-- NvimTree
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true

-- Bufferline
lvim.builtin.bufferline.active = true
lvim.builtin.bufferline.options.always_show_bufferline = true
lvim.builtin.bufferline.options.mode = "buffers"

-- Treesitter
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "javascript",
  "json",
  "lua",
  "css",
  "rust",
  "yaml",
  "elm",
  "haskell"
}
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.treesitter.rainbow.extended_mode = true

-- Telescope
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

-- Lualine
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
  lualine_x = { components.diagnostics, components.lsp },
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

-- LSP
-- lvim.lsp.automatic_servers_installation = true

--[[
  ADDITIONAL PLUGINS
]]
local numb = {
  "nacro90/numb.nvim",
  config = function()
    require("numb").setup()
  end
}

local colorschemes = {
  tokyionight = { "folke/tokyonight.nvim" },
  horizon = { "lunarvim/horizon.nvim" }
}

local rust_tools = {
  "simrat39/rust-tools.nvim",
  config = function()
    require("rust-tools").setup {
      tools = {
        autoSetHints = true,
        runnables = {
          use_telescope = true,
        },
      },
      server = {
        on_init = require("lvim.lsp").common_on_init,
        on_attach = function(client, bufnr)
          require("lvim.lsp").common_on_attach(client, bufnr)
          local rt = require "rust-tools"
          -- Hover actions
          vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
          -- Code action groups
          vim.keymap.set("n", "<leader>lA", rt.code_action_group.code_action_group, { buffer = bufnr })
        end,
      },
    }
  end,
  ft = { "rust", "rs" },
}

local git_fugitive = {
  "tpope/vim-fugitive",
  cmd = {
    "G",
    "Git",
    "Gdiffsplit",
    "Gread",
    "Gwrite",
    "Ggrep",
    "GMove",
    "GDelete",
    "GBrowse",
    "GRemove",
    "GRename",
    "Glgrep",
    "Gedit"
  },
  ft = { "fugitive" }
}

local ts_rainbow = {
  "p00f/nvim-ts-rainbow",
}

lvim.plugins = {
  numb,
  colorschemes.tokyionight,
  rust_tools,
  git_fugitive,
  ts_rainbow
}

--[[
  AUTOCOMMANDS
]]

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
