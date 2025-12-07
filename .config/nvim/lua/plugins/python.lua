return {
  -- Optional: virtualenv selector for Python projects
  {
    "linux-cultist/venv-selector.nvim",
    branch = "regexp",
    cmd = { "VenvSelect" },
    dependencies = { "nvim-telescope/telescope.nvim", "neovim/nvim-lspconfig" },
    opts = {},
  },
}
