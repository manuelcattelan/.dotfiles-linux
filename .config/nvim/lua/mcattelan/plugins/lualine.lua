return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    options = {
      globalstatus = true,
      section_separators = { left = "", right = "" },
      component_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        { "branch", icon = "" },
        {
          "diff",
          symbols = {
            added = " ",
            modified = " ",
            removed = " ",
          },
        },
      },
      lualine_c = { "%=", { "filetype", icon_only = true }, { "filename", path = 4 } },
      lualine_x = {},
      lualine_y = {
        {
          "diagnostics",
          symbolts = {
            error = " ",
            warn = " ",
            info = " ",
            hint = " ",
          },
        },
      },
      lualine_z = { "location" },
    },
  },
}
