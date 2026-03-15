return {
  -- Comment toggling
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      -- Use Comment.nvim's keymaps but move the line toggler off `gcc`
      -- so it no longer overlaps with the `gc` operator.
      require("Comment").setup({
        toggler = {
          line = "gC", -- toggle current line comment
          block = "gB", -- toggle current block comment
        },
        opleader = {
          line = "gc", -- operator-pending (e.g. gcw, gcip)
          block = "gb", -- operator-pending block
        },
      })

      -- Optional extra mapping: leader-based toggle, no overlaps.
      local api = require("Comment.api")
      vim.keymap.set("n", "<leader>/", api.toggle.linewise.current, {
        desc = "Toggle comment line",
      })
      vim.keymap.set("v", "<leader>/", function()
        api.toggle.linewise(vim.fn.visualmode())
      end, {
        desc = "Toggle comment selection",
      })
    end,
  },

  -- Surround edit
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    init = function()
      vim.g.nvim_surround_no_mappings = true
    end,
    config = function()
      require("nvim-surround").setup({})

      -- Use <leader>s* so none of these are prefixes of each other
      -- v4: keymaps must be set manually via <Plug> mappings
      vim.keymap.set("n", "<leader>sa", "<Plug>(nvim-surround-normal)", { desc = "Add surround" })        -- add surround around motion
      vim.keymap.set("n", "<leader>sA", "<Plug>(nvim-surround-normal-cur)", { desc = "Add surround (current line)" }) -- add surround around current word
      vim.keymap.set("n", "<leader>sl", "<Plug>(nvim-surround-normal-line)", { desc = "Add surround (line)" })   -- add surround to whole line
      vim.keymap.set("n", "<leader>sL", "<Plug>(nvim-surround-normal-cur-line)", { desc = "Add surround (cur line)" }) -- add surround to current line
      vim.keymap.set("x", "<leader>sa", "<Plug>(nvim-surround-visual)", { desc = "Add surround (visual)" })      -- add surround in visual mode
      vim.keymap.set("x", "<leader>sl", "<Plug>(nvim-surround-visual-line)", { desc = "Add surround (visual line)" }) -- add surround for visual line
      vim.keymap.set("n", "<leader>sd", "<Plug>(nvim-surround-delete)", { desc = "Delete surround" })     -- delete surround
      vim.keymap.set("n", "<leader>sr", "<Plug>(nvim-surround-change)", { desc = "Change surround" })     -- change surround
    end,
  },

  -- Autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  -- Git integration
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    },
  },

  -- Git wrapper (vim-fugitive)
  {
    "tpope/vim-fugitive",
    cmd = {
      "Git",
      "G",
      "Gdiffsplit",
      "Gvdiffsplit",
      "Gstatus",
      "Gblame",
      "Glog",
      "Gclog",
    },
  },

  -- Telescope configuration
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    opts = {
      defaults = {
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
      },
      pickers = {
        find_files = { hidden = true },
      },
    },
  },


}
