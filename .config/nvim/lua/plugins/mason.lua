return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {},
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    cond = false,
    opts = {
      ensure_installed = {},
      automatic_installation = false,
    },
  },
}
