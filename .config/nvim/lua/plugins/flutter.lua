return {
  {
    "akinsho/flutter-tools.nvim",
    ft = { "dart" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local function on_attach(client, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- Standard LSP mappings
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

        -- Flutter-specific commands (buffer-local to Dart buffers)
        map("n", "<leader>fr", "<cmd>FlutterRun<CR>", "Flutter run")
        map("n", "<leader>fd", "<cmd>FlutterDevices<CR>", "Flutter devices")
        map("n", "<leader>fe", "<cmd>FlutterEmulators<CR>", "Flutter emulators")
        map("n", "<leader>fL", "<cmd>FlutterReload<CR>", "Flutter reload")
        map("n", "<leader>fR", "<cmd>FlutterRestart<CR>", "Flutter restart")
        map("n", "<leader>fo", "<cmd>FlutterOutlineToggle<CR>", "Flutter outline")
        map("n", "<leader>fq", "<cmd>FlutterQuit<CR>", "Flutter quit")
        map("n", "<leader>fT", "<cmd>FlutterDevTools<CR>", "Flutter DevTools")
        map("n", "<leader>fl", "<cmd>FlutterLogToggle<CR>", "Flutter logs")
      end

      require("flutter-tools").setup({
        lsp = {
          color = {
            enabled = true,
          },
          on_attach = on_attach,
          capabilities = capabilities,
        },
      })
    end,
  },
}
