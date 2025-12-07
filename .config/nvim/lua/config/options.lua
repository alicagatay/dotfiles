-- General Neovim options
local o = vim.opt

-- UI
o.number = true
o.relativenumber = true
o.cursorline = true
o.termguicolors = true
o.signcolumn = "yes"
o.wrap = false

-- Tabs & indentation
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.smartindent = true

-- Search
o.ignorecase = true
o.smartcase = true

-- Performance
o.updatetime = 250
o.timeoutlen = 300

-- Splits
o.splitright = true
o.splitbelow = true

-- Clipboard
o.clipboard = "unnamedplus"

-- Misc
o.scrolloff = 4
