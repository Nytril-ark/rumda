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
      ensure_installed = { "lua", "cpp", "c", "python", "markdown", "markdown_inline" },
      highlight = { enable = true },
    },
  },
  { import = "plugins" },
}, lazy_config)

-- Keymaps
vim.api.nvim_set_keymap('n', '<M-h>', ':vsplit | terminal<CR> | resize 50%<CR>', { noremap = true, silent = true })

-- Define the macro for the double loop
vim.cmd([[
    let @a = 'i  for (int i = 0; i < 10; i++) {for (int k = 0; k < 10; k++) {}}'
]])
vim.api.nvim_set_keymap('n', '<leader>l', '@a', { noremap = true, silent = true })
-- Markdown formatting keymaps (accessed via <Leader>w)
vim.keymap.set('v', '<Leader>wb', 'c**<C-r>"**<Esc>', { desc = 'Bold selection' })
vim.keymap.set('v', '<Leader>wi', 'c*<C-r>"*<Esc>', { desc = 'Italic selection' })
vim.keymap.set('v', '<Leader>wu', 'c_<C-r>"_<Esc>', { desc = 'Underline/emphasis selection' })
vim.keymap.set('v', '<Leader>wl', 'c[<C-r>"]()<Esc>i', { desc = 'Create link (add URL)' })
vim.keymap.set('v', '<Leader>ws', 'c~~<C-r>"~~<Esc>', { desc = 'Strikethrough' })

-- Text wrappers (accessed via <Leader>w)
vim.keymap.set('v', '<Leader>w[', 'c_[<C-r>"]_<Esc>', { desc = 'Wrap in _[text]_' })
vim.keymap.set('v', '<Leader>w(', 'c(<C-r>")<Esc>', { desc = 'Wrap in (text)' })
vim.keymap.set('v', '<Leader>w{', 'c{<C-r>"}<Esc>', { desc = 'Wrap in {text}' })
vim.keymap.set('v', '<Leader>w]', 'c[<C-r>"]<Esc>', { desc = 'Wrap in [text]' })
vim.keymap.set('v', '<Leader>w"', 'c"<C-r>""<Esc>', { desc = 'Wrap in "text"' })
vim.keymap.set('v', "<Leader>w'", "c'<C-r>\"'<Esc>", { desc = "Wrap in 'text'" })
vim.keymap.set('v', '<Leader>w<', 'c<<C-r>"><Esc>', { desc = 'Wrap in <text>' })
vim.keymap.set('v', '<Leader>w`', 'c`<C-r>"`<Esc>', { desc = 'Wrap in `text`' })

-- Code block
vim.keymap.set('n', '<Leader>wcb', 'i```<CR>```<Esc>O', { desc = 'Code block' })

-- Subscript and superscript 
vim.keymap.set('v', '<Leader>wS', 'c<sup><C-r>"</sup><Esc>', { desc = 'Superscript (wrap in <sup>)' })
vim.keymap.set('v', '<Leader>wd', 'c<sub><C-r>"</sub><Esc>', { desc = 'Subscript (wrap in <sub>)' })

-- Collapsible details block
vim.keymap.set('v', '<Leader>wD', 'c<details><CR><summary><C-r>"</summary><CR><CR></details><Esc>kk$a', { desc = 'Wrap in <details> (selection as summary)' })


-- error-only config so the lsp doesnt clutter the view
local error_only_config = {
  severity_sort = true,
  signs = {
    severity = { min = vim.diagnostic.severity.ERROR }
  },
  virtual_text = {
    severity = { min = vim.diagnostic.severity.ERROR }
  },
  float = {
    severity = { min = vim.diagnostic.severity.ERROR }
  },
  underline = {
    severity = { min = vim.diagnostic.severity.ERROR }
  },
}

-- Apply error-only config by default
vim.diagnostic.config(error_only_config)

-- Toggle diagnostics visibility (toggle lsp in normal mode through leader + t + d)
local diagnostics_visible = true
vim.keymap.set('n', '<Leader>td', function()
  diagnostics_visible = not diagnostics_visible
  
  if diagnostics_visible then
    -- Restore error-only config
    vim.diagnostic.config(error_only_config)
  else
    -- Hide all diagnostics
    vim.diagnostic.config({
      virtual_text = false,
      signs = false,
      underline = false,
    })
  end
  
  print('Diagnostics ' .. (diagnostics_visible and 'visible' or 'hidden'))
end, { desc = 'Toggle diagnostics visibility' })


vim.g.mkdp_browser = "firefox"


-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)
