return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- stylua: ignore
  keys = {
    { "<leader>xx", function() require("trouble").toggle() end, desc = "Toggle trouble window" },
    { "<leader>xd", function() require("trouble").toggle("document_diagnostics") end, desc = "Toggle trouble window" },
    { "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end, desc = "Toggle trouble window" },
  },
  opts = {
    height = 15,
  },
  config = function(_, opts)
    require("trouble").setup(opts)
  end,
}
