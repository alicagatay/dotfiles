return {
  -- Lua utilities
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },

  -- Keybinding hints
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({})
      wk.add({
        { "<leader>f", group = "file/find" },
        { "<leader>d", group = "diagnostics" },
        { "<leader>g", group = "git" },
        { "<leader>c", group = "copilot" },
      })
    end,
  },

  -- Telescope core (UI details in editor.lua)
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
}
