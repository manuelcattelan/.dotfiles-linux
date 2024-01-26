return {
  "nvim-treesitter/nvim-treesitter-context",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  opts = {
    max_lines = 3,
  },
  -- stylua: ignore
  keys = {
    {
      "<leader>tc",
      function() require("treesitter-context").toggle() end,
      desc = "Toggle treesitter Context",
    },
  },
}
