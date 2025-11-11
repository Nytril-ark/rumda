local M = {}
M.base_30 = {
  white = "#45373C",
  darker_black = "#F2CDAC",
  black = "#F5DCC6", -- light bg
  black2 = "#F2CDAC",
  one_bg = "#F2CDAC",
  one_bg2 = "#f7d5b7",
  one_bg3 = "#e6c0a1",
  grey = "#DAC79B",
  grey_fg = "#C09B72",
  light_grey = "#C09B72",
  red = "#9e5044",
  baby_pink = "#a87358",
  pink = "#c47c4f",
  line = "#c9c0ae",
  green = "#4e2e1f",  -- Darker for insert mode
  vibrant_green = "#3e1e0f",
  blue = "#5a3a25",  -- Darker for normal mode (was #a1694d)
  yellow = "#9f7c55",  -- Darker for visual mode
  sun = "#c19b76",
  purple = "#8f5b3c",  -- Darker
  orange = "#986649",  -- Darker
  cyan = "#5a3a25",
  statusline_bg = "#e6c0a1",
  lightbg = "#f7d5b7",
  pmenu_bg = "#8f5b3c",  -- Darker
  folder_bg = "#5a3a25",  -- Darker
}
M.base_16 = {
  base00 = "#F5DCC6", -- bg
  base01 = "#F5DCC6", -- "normal mode" word
  base02 = "#e6c0a1",
  base03 = "#9e4234",
  base04 = "#a1694d",
  base05 = "#9A4235",
  base06 = "#45373C",
  base07 = "#45373C",
  base08 = "#ab4637", -- red (errors, variables)
  base09 = "#8f5b3c", -- orange (numbers)
  base0A = "#c4835a", -- yellow (classes)
  base0B = "#447028", -- green (strings)
  base0C = "#a1694d", -- cyan (support)
  base0D = "#426A79", -- blue (functions)
  base0E = "#a1694d", -- purple (keywords)
  base0F = "#45373C", -- error
}
M.type = "light"
M.polish_hl = {}


return M
