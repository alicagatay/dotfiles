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

  -- GitHub Copilot inline suggestions
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      -- Don't use <Tab> for Copilot so it doesn't conflict with nvim-cmp
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true

      -- Accept Copilot suggestion with <C-l> in insert mode
      vim.keymap.set("i", "<C-l>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        silent = true,
        desc = "Accept Copilot suggestion",
      })

      -- Example: enable Copilot for all filetypes (customize if you like)
      -- vim.g.copilot_filetypes = { ["*"] = true }
    end,
  },

  -- GitHub Copilot Chat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    cmd = {
      "CopilotChat",
      "CopilotChatOpen",
      "CopilotChatToggle",
      "CopilotChatExplain",
      "CopilotChatReview",
      "CopilotChatFix",
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    -- On macOS/Linux this builds optional tiktoken support (safe to skip if it fails)
    build = "make tiktoken",
    opts = {
      model = "gpt-4.1",         -- AI model to use
      temperature = 0.1,          -- Lower = focused, higher = creative
      window = {
        layout = "vertical",    -- 'vertical', 'horizontal', 'float'
        width = 0.3,             -- 50% of screen width
      },
      auto_insert_mode = true,   -- Enter insert mode when opening
    },
    keys = {
      {
        "<leader>cc",
        "<cmd>CopilotChatToggle<CR>",
        mode = { "n", "v" },
        desc = "CopilotChat - Toggle chat",
      },
      {
        "<leader>ce",
        "<cmd>CopilotChatExplain<CR>",
        mode = { "n", "v" },
        desc = "CopilotChat - Explain selection",
      },
      {
        "<leader>cr",
        "<cmd>CopilotChatReview<CR>",
        mode = { "n", "v" },
        desc = "CopilotChat - Review selection",
      },
    },
  },

  -- Dooing: minimalist todo manager (local fork)
  {
    "atiladefreitas/dooing",
    -- Load from local fork instead of cloning into Lazy's directory
    dir = "/Users/alicagatay/Documents/Dev/Projects/dooing",
    event = "VeryLazy",
    config = function()
      require("dooing").setup({
        -- using defaults; customize here if you like
        keymaps = {
          sync_export_on = "<leader>ts",
          sync_export_off = "<leader>tS",
        },
      })
    end,
  },
}
