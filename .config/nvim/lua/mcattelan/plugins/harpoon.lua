return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = function()
    local harpoon = require("harpoon")
    -- stylua: ignore
    return {
      { "<leader>H", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Toggle harpoon menu with harpoon list" },
      { "<leader>ha", function() harpoon:list():append() end, desc = "Append file to harpoon list" },
      { "<leader>h1", function() harpoon:list():select(1) end, desc = "Open first buffer in harpoon list" },
      { "<leader>h2", function() harpoon:list():select(2) end, desc = "Open second buffer in harpoon list" },
      { "<leader>h3", function() harpoon:list():select(3) end, desc = "Open third buffer in harpoon list" },
      { "<leader>h4", function() harpoon:list():select(4) end, desc = "Open fourth buffer in harpoon list" },
      { "<C-p>", function() harpoon:list():prev() end, desc = "Toggle previous buffer in harpoon list" },
      { "<C-n>", function() harpoon:list():next() end, desc = "Toggle next buffer in harpoon list" },
    }
  end,
  config = function()
    require("harpoon").setup()
  end,
}
