-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "rumda-light",
  theme_toggle = {"rumda-light", "rumda-light"},
	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

M.ui = {
  statusline = {
    theme = "default",
    separator_style = "arrow",
    order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor" },
    modules = {
      mode = function()
        local stl = require("nvchad.stl.utils")
        local m = vim.api.nvim_get_mode().mode
        local mode_data = stl.modes[m] or stl.modes["n"]
        local mode_hl = "%#St_" .. mode_data[2] .. "Mode#"
        -- Define different icons for each input mode here
        local mode_icons = {
          n = " 🙤  ",      -- Normal
          i = " 🙛  ",      -- Insert
          v = " 🙵  ",      -- Visual
          V = " ",      -- Visual Line
          [""] = " ☢  ", -- Visual Block (Ctrl-V)
          c = " 🙪  ",      -- Command
          R = " ♣  ",      -- Replace
          t = " ⨋ ",      -- Terminal
        }
        -- Get the icon for current mode, fallback to normal mode icon
        local icon = mode_icons[m] or mode_icons["n"]
        return mode_hl .. icon .. mode_data[1] .. " %#St_NormalMode#"
      end,
    }
  },
}


-- --for xfc 
-- M.ui = {
--   statusline = {
--     theme = 'minimal',
--     separator_style = 'block',
--     order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor" },
--   modules = {
--       mode = function()
--         local stl = require("nvchad.stl.utils")
--         local m = vim.api.nvim_get_mode().mode
--         local mode_data = stl.modes[m] or stl.modes["n"]
--         local mode_hl = "%#St_" .. mode_data[2] .. "Mode#"
--         -- Icons if you want them:
--         -- local mode_icons = {
--         --   n = " 🙤  ",      -- Normal
--         --   i = " 🙛  ",      -- Insert
--         --   v = " 🙵  ",      -- Visual
--         --   V = " ",      -- Visual Line
--         --   [""] = " ☢  ", -- Visual Block (Ctrl-V)
--         --   c = " 🙪  ",      -- Command
--         --   R = " ♣  ",      -- Replace
--         --   t = " ⨋ ",      -- Terminal
--         -- }
--         local mode_icons = {
--           n = " N ",      -- Normal
--           i = " I ",      -- Insert
--           v = " V ",      -- Visual
--           V = " v ",      -- Visual Line (what's visual line :deep_think:)
--           [""] = " ☢  ", -- Visual Block (Ctrl-V) (idk)
--           c = " C ",      -- Command
--           R = " R ",      -- Replace
--           t = " T ",      -- Terminal
--         }
--         local icon = mode_icons[m] or mode_icons["n"]
--         return mode_hl .. icon .. " %#St_NormalMode#"
--       end,
--     }
--   },
--
--   hl_override = {
--     Comment = { italic = true },
--     Keyword = { italic = true },
--     Statement = { italic = true },
--     Variable = { italic = true },
--     Type = { italic = true },
--     Include = { italic = true },
--     TSDefine = { italic = true },
--     TSKeyword = { italic = true },
--     TSMethod = { italic = true },
--     TSVariable = { italic = true },
--     SpecialComment = { italic = true },
--   },
-- }




-- ayu_dark, gatekeeper, jelly beans, yoru, rxyhn

return M
