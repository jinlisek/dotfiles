local is_in_container = vim.env.container ~= nil or vim.env.REMOTE_CONTAINERS_IPC ~= nil

return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {},
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    cond = is_in_container,
    opts = {
      ensure_installed = {},
      automatic_installation = false,
    },
  },
}
