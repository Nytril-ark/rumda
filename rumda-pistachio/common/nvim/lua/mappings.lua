require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
--map({'n', 't'}, '<A-h>', function ()
  --require("nvchad.term").toggle { pos = "vs", size = 0.5 }
--end)
map({'n', 't'}, '<A-h>', function ()
  require("nvchad.term").toggle { pos = "sp", size = 0.3 }
end)
map({'n', 't'}, '<A-j>', function ()
  require("nvchad.term").toggle { pos = "sp", size = 0.5 }
end)
map({'n', 't'}, '<A-k>', function ()
  require("nvchad.term").toggle { pos = "sp", size = 0.7 }
end)
map({'n', 't'}, '<A-l>', function ()
  require("nvchad.term").toggle { pos = "sp", size = 0.95 }
end)


-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
