return {
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    config = function()
      -- jdtls is typically started per-project via an ftplugin/java.lua file.
      -- This plugin gives you the tooling; you can add a project-specific launcher later.
    end,
  },
}
