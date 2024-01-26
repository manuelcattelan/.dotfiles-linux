return {
  "nvim-treesitter/nvim-treesitter",
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })()
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  opts = {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = false,
    -- List of parsers to ignore installing (or "all")
    ignore_install = {},

    highlight = {
      enable = true,
      -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
      -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
      -- the name of the parser)
      -- list of language that will be disabled
      disable = {},
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = { query = "@function.outer", desc = "Select outer part of a function definition region" },
          ["if"] = { query = "@function.inner", desc = "Select inner part of a function definition region" },

          ["am"] = { query = "@call.outer", desc = "Select outer part of a function call region" },
          ["im"] = { query = "@call.inner", desc = "Select inner part of a function call region" },

          ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop region" },
          ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop region" },

          ["ac"] = { query = "@conditional.outer", desc = "Select outer part of a conditional region" },
          ["ic"] = { query = "@conditional.inner", desc = "Select inner part of a conditional region" },

          ["ap"] = { query = "@parameter.outer", desc = "Select outer part of a parameter region" },
          ["ip"] = { query = "@parameter.inner", desc = "Select inner part of a parameter region" },

          ["aa"] = { query = "@assignment.outer", desc = "Select outer part of an assignment region" },
          ["ia"] = { query = "@assignment.inner", desc = "Select inner part of an assignment region" },
          ["la"] = { query = "@assignment.lhs", desc = "Select the left hand side of an assignment region" },
          ["ra"] = { query = "@assignment.rhs", desc = "Select the right hand side of an assignment region" },
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]f"] = { query = "@function.outer", desc = "Next function definition start" },
          ["]m"] = { query = "@call.outer", desc = "Next function call start" },
          ["]l"] = { query = "@loop.outer", desc = "Next loop start" },
          ["]c"] = { query = "@conditional.outer", desc = "Next conditional start" },
          ["]p"] = { query = "@parameter.outer", desc = "Next parameter start" },
          ["]a"] = { query = "@assignment.outer", desc = "Next assignment start" },
        },
        goto_next_end = {
          ["]F"] = { query = "@function.outer", desc = "Next function definition end" },
          ["]M"] = { query = "@call.outer", desc = "Next function call end" },
          ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
          ["]C"] = { query = "@conditional.outer", desc = "Next conditional end" },
          ["]P"] = { query = "@parameter.outer", desc = "Next parameter end" },
          ["]A"] = { query = "@assignment.outer", desc = "Next assignment end" },
        },
        goto_previous_start = {
          ["[f"] = { query = "@function.outer", desc = "Previous function definition start" },
          ["[m"] = { query = "@call.outer", desc = "Previous function call start" },
          ["[l"] = { query = "@loop.outer", desc = "Previous loop start" },
          ["[c"] = { query = "@conditional.outer", desc = "Previous conditional start" },
          ["[p"] = { query = "@parameter.outer", desc = "Previous parameter start" },
          ["[a"] = { query = "@assignment.outer", desc = "Previous assignment start" },
        },
        goto_previous_end = {
          ["[F"] = { query = "@function.outer", desc = "Previous function definition end" },
          ["[M"] = { query = "@call.outer", desc = "Previous function call end" },
          ["[L"] = { query = "@loop.outer", desc = "Previous loop end" },
          ["[C"] = { query = "@conditional.outer", desc = "Previous conditional end" },
          ["[P"] = { query = "@parameter.outer", desc = "Previous parameter end" },
          ["[A"] = { query = "@assignment.outer", desc = "Previous assignment end" },
        },
      },
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
  },
  config = function(_, opts)
    local treesitter_config = require("nvim-treesitter.configs")
    treesitter_config.setup(opts)
  end,
}
