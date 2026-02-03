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
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          -- Use <leader>s* so none of these are prefixes of each other
          normal = "<leader>sa",        -- add surround around motion
          normal_cur = "<leader>sA",    -- add surround around current word
          normal_line = "<leader>sl",   -- add surround to whole line
          normal_cur_line = "<leader>sL", -- add surround to current line
          visual = "<leader>sa",        -- add surround in visual mode
          visual_line = "<leader>sl",   -- add surround for visual line
          delete = "<leader>sd",        -- delete surround
          change = "<leader>sr",        -- change surround
        },
      })
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
