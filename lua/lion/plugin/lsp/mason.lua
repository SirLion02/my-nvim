require("mason").setup()

require("mason-lspconfig").setup({
  -- list of servers for mason to install
  ensure_installed = {
    "tsserver",
    "html",
    "cssls",
    "sqlls",
    "sumneko_lua",
    "emmet_ls",
    "pyright",
  },
  -- auto-install configured servers (with lspconfig)
  automatic_installation = true, -- not the same as ensure_installed
})
