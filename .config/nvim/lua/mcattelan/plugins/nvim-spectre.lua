return {
  "nvim-pack/nvim-spectre",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  -- stylua: ignore
  keys = {
    { "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', desc = "Toggle spectre menu" },
    { "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', desc = "Spectre current word", mode = "n" },
    { "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', desc = "Spectre current word", mode = "v" },
    { "<leader>sf", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', desc = "Spectre current word in file" },
  },
}
