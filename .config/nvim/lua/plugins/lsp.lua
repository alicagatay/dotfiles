local M = {}

-- Shared LSP on_attach for keymaps
local function on_attach(client, bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  map("n", "gd", vim.lsp.buf.definition, "Go to definition")
  map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
  map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
  map("n", "gr", vim.lsp.buf.references, "References")
  map("n", "K", vim.lsp.buf.hover, "Hover")
  map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
  map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
  map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace folder")
  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "List workspace folders")
end

local function setup_lsp()
  -- Diagnostics config
  vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  })

  local mason_lspconfig = require("mason-lspconfig")
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  -- Base configs for each server, combined with shared on_attach/capabilities
  local servers = {
    -- Lua
    lua_ls = {
      settings = {
        Lua = {
          workspace = { checkThirdParty = false },
          diagnostics = { globals = { "vim" } },
        },
      },
    },
    -- Web
    ts_ls = {},
    html = {},
    cssls = {},
    jsonls = {},
    yamlls = {},
    tailwindcss = {},
    emmet_ls = {},
    -- Python
    pyright = {},
    ruff = {
      on_attach = function(client, bufnr)
        client.server_capabilities.hoverProvider = false -- use Pyright hover instead
        on_attach(client, bufnr)
      end,
      init_options = {
        settings = {
          -- Put Ruff-specific settings here if needed. By default, Ruff reads pyproject.toml / ruff.toml.
        },
      },
    },
  }

  for name, cfg in pairs(servers) do
    cfg.capabilities = vim.tbl_deep_extend("force", {}, capabilities, cfg.capabilities or {})
    cfg.on_attach = cfg.on_attach or on_attach
    vim.lsp.config(name, cfg)
  end

  mason_lspconfig.setup({
    ensure_installed = {
      -- Lua
      "lua_ls",
      -- Web
      "ts_ls",
      "html",
      "cssls",
      "jsonls",
      "yamlls",
      "tailwindcss",
      "emmet_ls",
      -- Python
      "pyright",
      "ruff",
      -- Java
      "jdtls",
      -- Dart LSP is handled entirely by flutter-tools / dart SDK, not mason-lspconfig
    },
    automatic_enable = {
      -- jdtls is managed by a dedicated plugin
      exclude = { "jdtls" },
    },
  })
end

M.spec = {
  -- Mason (LSP/dap/formatter installer)
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = function()
      require("mason").setup()
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
  },

  -- LSP config
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "folke/neodev.nvim",
    },
    config = function()
      require("neodev").setup({})
      setup_lsp()
    end,
  },

  -- LSP UI niceties
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    config = true,
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- Lua development (better completion for Neovim config)
  {
    "folke/neodev.nvim",
    ft = "lua",
  },

  -- Formatting (Conform)
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    config = function()
      local conform = require("conform")
      conform.setup({
        formatters_by_ft = {
          lua = { "stylua" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          json = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          python = { "black", "isort" },
          java = { "google-java-format" },
          dart = { "dart_format" },
        },
        format_on_save = function(bufnr)
          local disable_filetypes = { c = true, cpp = true }
          if disable_filetypes[vim.bo[bufnr].filetype] then
            return
          end
          return { timeout_ms = 3000, lsp_fallback = true }
        end,
      })

      vim.api.nvim_create_user_command("Format", function()
        conform.format({ async = true, lsp_fallback = true })
      end, {})
    end,
  },
}

return M.spec
