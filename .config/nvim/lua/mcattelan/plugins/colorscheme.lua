return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
    styles = {
      -- Style to be applied to different syntax groups
      -- Value is any valid attr-list value for `:help nvim_set_hl`
      comments = { italic = false },
      keywords = { italic = false },
      -- Background styles. Can be "dark", "transparent" or "normal"
      floats = "normal", -- style for floating windows
      sidebars = "normal", -- style for sidebars, see below
    },
    lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    ---@param highlights Highlights
    ---@param colors ColorScheme
    on_highlights = function(highlights, colors)
      highlights.FloatBorder = { fg = colors.fg_dark }
      highlights.LspInfoBorder = { fg = colors.fg_dark }
      highlights.TelescopeBorder = { fg = colors.fg_dark }

      highlights.CmpItemAbbr = { fg = colors.dark7, italic = true }
      highlights.CmpItemAbbrDeprecated = { fg = colors.dark5, italic = true, strikethrough = true }

      highlights.WinSeparator = { fg = colors.fg_dark }
      highlights.NvimTreeWinSeparator = { fg = colors.fg_dark }
    end,
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd([[colorscheme tokyonight]])
  end,
}
