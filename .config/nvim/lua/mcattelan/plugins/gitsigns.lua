return {
  "lewis6991/gitsigns.nvim",
  opts = {
    on_attach = function(buffer)
      local gitsigns = package.loaded.gitsigns

      local function map(mode, key, command, description)
        vim.keymap.set(mode, key, command, { buffer = buffer, desc = description })
      end

      map("n", "]h", gitsigns.next_hunk, "Next Hunk")
      map("n", "[h", gitsigns.prev_hunk, "Previous Hunk")
      map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
      map("n", "<leader>hu", gitsigns.undo_stage_hunk, "Unstage Hunk")
      map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
      map("n", "<leader>hp", gitsigns.preview_hunk, "Preview Hunk")
      map("n", "<leader>hS", gitsigns.stage_buffer, "Stage Buffer")
      map("n", "<leader>hR", gitsigns.reset_buffer, "Reset Buffer")
      map("n", "<leader>bl", function()
        gitsigns.blame_line({ full = true })
      end, "Blame Line")
      map("n", "<leader>hd", gitsigns.diffthis, "Diff this")
      map("n", "<leader>hD", function()
        gitsigns.diffthis("~")
      end, "Diff this ~")
    end,
  },
}
