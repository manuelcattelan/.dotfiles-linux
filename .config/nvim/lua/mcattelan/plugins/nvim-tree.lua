return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    {
      "<leader>tt",
      "<cmd>NvimTreeToggle<CR>",
      desc = "Toggle file explorer",
    },
    {
      "<leader>tf",
      "<cmd>NvimTreeFindFile<CR>",
      desc = "Toggle file explorer and focus current file",
    },
  },
  opts = {
    sort = {
      sorter = "case_sensitive",
    },
    view = {
      width = "25%",
    },
  },
  config = function(_, opts)
    require("nvim-tree").setup(opts)
  end,
}
