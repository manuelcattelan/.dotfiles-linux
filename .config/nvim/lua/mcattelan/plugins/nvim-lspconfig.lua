local border = "single"

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  opts = {
    diagnostics = {
      underline = true,
      severity_sort = true,
      update_in_insert = false,
      virtual_text = false,
      float = { border = border },
    },
  },
  config = function(_, opts)
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp_keymaps", {}),
      callback = function(args)
        local goto_diagnostic = function(next_diagnostic, diagnostic_severity)
          local go = next_diagnostic and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
          diagnostic_severity = diagnostic_severity and vim.diagnostic.severity[diagnostic_severity] or nil
          return function()
            go({ severity = diagnostic_severity })
          end
        end

        local options = {}
        local buffer = args.buf

        options.buffer = buffer

        options.desc = "Goto Definition"
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, options)
        options.desc = "Goto Refinition"
        vim.keymap.set("n", "gr", vim.lsp.buf.references, options)
        options.desc = "Hover"
        vim.keymap.set("n", "K", vim.lsp.buf.hover, options)
        options.desc = "Signature help"
        vim.keymap.set({ "i", "v" }, "<C-k>", vim.lsp.buf.signature_help, options)
        options.desc = "Rename word under cursor"
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, options)

        options.desc = "Show line diagnostics"
        vim.keymap.set("n", "<leader>do", vim.diagnostic.open_float, options)
        options.desc = "Next diagnostic"
        vim.keymap.set("n", "]d", goto_diagnostic(true), options)
        options.desc = "Previous diagnostic"
        vim.keymap.set("n", "[d", goto_diagnostic(false), options)
        options.desc = "Next warning"
        vim.keymap.set("n", "]w", goto_diagnostic(true, "WARN"), options)
        options.desc = "Previous warning"
        vim.keymap.set("n", "[w", goto_diagnostic(false, "WARN"), options)
        options.desc = "Next error"
        vim.keymap.set("n", "]e", goto_diagnostic(true, "ERROR"), options)
        options.desc = "Previous error"
        vim.keymap.set("n", "[e", goto_diagnostic(false, "ERROR"), options)
      end,
    })

    vim.diagnostic.config(opts.diagnostics)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = border,
    })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = border,
    })
    require("lspconfig.ui.windows").default_options = {
      border = border,
    }
  end,
}
