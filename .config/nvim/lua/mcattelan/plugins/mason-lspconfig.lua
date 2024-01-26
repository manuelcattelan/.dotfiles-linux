return {
  "williamboman/mason-lspconfig.nvim",
  opts = {
    ensure_installed = {
      "lua_ls",
    },
  },
  config = function(_, opts)
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local mason_lspconfig_handlers = {
      -- The first entry (without a key) will be the default handler
      -- and will be called for each installed server that doesn't have
      -- a dedicated handler.
      function(server_name) -- default handler (optional)
        lspconfig[server_name].setup({})
      end,
      -- Next, you can provide a dedicated handler for specific servers.
      ["lua_ls"] = function()
        lspconfig["lua_ls"].setup({
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        })
      end,
    }
    mason_lspconfig.setup(opts)
    mason_lspconfig.setup_handlers(mason_lspconfig_handlers)
  end,
}
