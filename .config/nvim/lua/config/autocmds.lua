-- Autocommands
local group = vim.api.nvim_create_augroup
local aucmd = vim.api.nvim_create_autocmd

local general = group("GeneralAutocmds", { clear = true })

-- Highlight on yank
aucmd("TextYankPost", {
  group = general,
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 150 })
  end,
})

-- Resize splits when the window is resized
aucmd("VimResized", {
  group = general,
  command = "wincmd =",
})

-- Open help in vertical split
aucmd("FileType", {
  group = general,
  pattern = "help",
  command = "wincmd L",
})
