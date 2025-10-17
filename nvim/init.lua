vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },
	  {
    "IogaMaster/neocord",
    event = "VeryLazy",
    config = {
      main_image = "language",
      show_time = true,
      workspace_text = function()
        return "using NvChad"
      end,
    },
  },
    {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "lua", "cpp" },
      highlight = { enable = true },
    },
  },
  { import = "plugins" },
}, lazy_config)
vim.api.nvim_set_keymap('n', '<M-h>', ':vsplit | terminal<CR> | resize 50%<CR>', { noremap = true, silent = true })



require('lspconfig').pyright.setup{}

-- Define the macro for the double loop
vim.cmd([[
    let @a = 'i  for (int i = 0; i < 10; i++) {for (int k = 0; k < 10; k++) {}}'
]])

-- Bind the macro to a key combination (e.g., <leader>l)
vim.api.nvim_set_keymap('n', '<leader>l', '@a', { noremap = true, silent = true })



-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)
