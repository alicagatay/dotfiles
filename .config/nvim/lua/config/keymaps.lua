-- Keymaps
local map = vim.keymap.set

-- Set leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better defaults
map("n", "<leader>w", ":w<CR>", { desc = "Save" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit" })
map("n", "<leader>Q", ":qa!<CR>", { desc = "Quit all" })

-- Tabs & splits
map("n", "<leader>tn", ":tabnew<CR>", { desc = "New tab" })
map("n", "<leader>sv", ":vsplit<CR>", { desc = "Vertical split" })
map("n", "<leader>sh", ":split<CR>", { desc = "Horizontal split" })

-- Terminal
map("n", "<leader>nt", ":split | terminal<CR>", { desc = "Open terminal split" })

-- Clear search
map("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear search highlight" })

-- File explorer (nvim-tree)
map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

-- Telescope
map("n", "<leader>ff", function()
  require("telescope.builtin").find_files()
end, { desc = "Find files" })

map("n", "<leader>fg", function()
  require("telescope.builtin").live_grep()
end, { desc = "Live grep" })

map("n", "<leader>fb", function()
  require("telescope.builtin").buffers()
end, { desc = "Buffers" })

map("n", "<leader>fh", function()
  require("telescope.builtin").help_tags()
end, { desc = "Help tags" })

map("n", "<leader>/", function()
  require("telescope.builtin").current_buffer_fuzzy_find()
end, { desc = "Search in current buffer" })

-- Diagnostics
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "<leader>dl", ":Trouble diagnostics toggle<CR>", { desc = "Diagnostics list" })

-- LSP-related (buffer-local ones will be set in LSP on_attach; these are fallbacks)
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "References" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })

-- Format (uses Conform with LSP fallback)
map("n", "<leader>f", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer" })

-- Git signs (populated when plugin loads)
map("n", "]h", function()
  local ok, gs = pcall(require, "gitsigns")
  if ok then gs.next_hunk() end
end, { desc = "Next hunk" })

map("n", "[h", function()
  local ok, gs = pcall(require, "gitsigns")
  if ok then gs.prev_hunk() end
end, { desc = "Prev hunk" })

-- Git (vim-fugitive)
map("n", "<leader>gs", ":Git<CR>", { desc = "Git status (Fugitive)" })
map("n", "<leader>gp", ":Git push<CR>", { desc = "Git push" })
map("n", "<leader>gP", ":Git pull<CR>", { desc = "Git pull" })
map("n", "<leader>ga", ":Git add %<CR>", { desc = "Git add current file" })
map("n", "<leader>gA", ":Git add .<CR>", { desc = "Git add all" })
map("n", "<leader>gc", ":Git commit -m \"\"<Left><Left>", { desc = "Git commit -m" })
map("n", "<leader>gC", ":Git commit<CR>", { desc = "Git commit" })
map("n", "<leader>gb", ":Git blame<CR>", { desc = "Git blame" })
map("n", "<leader>gd", ":Gdiffsplit<CR>", { desc = "Git diff (split)" })
map("n", "<leader>gl", ":Gclog<CR>", { desc = "Git file log" })
map("n", "<leader>gw", ":Gwrite<CR>", { desc = "Git write (stage file)" })
map("n", "<leader>gr", ":Gread<CR>", { desc = "Git read (revert file)" })
