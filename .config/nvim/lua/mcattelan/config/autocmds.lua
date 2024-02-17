local function create_augroup(augroup_name)
  return vim.api.nvim_create_augroup(augroup_name, { clear = true })
end

local function create_namespace(namespace_name)
  return vim.api.nvim_create_namespace(namespace_name)
end

local highlight_search_namespace = create_namespace("highlight_search")

-- Enable/disable highlight search based on key pressed
local function manage_highlight_search(current_char)
  local current_key = vim.fn.keytrans(current_char)
  local enabler_keys = { "n", "N", "*", "#", "?", "/" }

  if vim.fn.mode() == "n" then
    if vim.tbl_contains(enabler_keys, current_key) then
      vim.cmd([[ :set hlsearch ]])
    else
      vim.cmd([[ :set nohlsearch ]])
    end
  end

  vim.on_key(function() end, highlight_search_namespace)
end

-- Highlight yanked text region
vim.api.nvim_create_autocmd("TextYankPost", {
  group = create_augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Manage highlight search when moving cursor
vim.api.nvim_create_autocmd("CursorMoved", {
  group = create_augroup("highlight_search"),
  callback = function()
    vim.on_key(manage_highlight_search, highlight_search_namespace)
  end,
})

-- Go to last cursor location when opening new buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = create_augroup("last_cursor_location"),
  callback = function(event)
    local excluded_buffers = { "gitcommit" }
    local buffer = event.buf

    if vim.tbl_contains(excluded_buffers, vim.bo[buffer].filetype) or vim.b[buffer].last_cursor_location then
      return
    end

    vim.b[buffer].last_cursor_location = true
    local mark = vim.api.nvim_buf_get_mark(buffer, '"')
    local line_count = vim.api.nvim_buf_line_count(buffer)

    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Better keymaps for Netrw
vim.api.nvim_create_autocmd("filetype", {
  pattern = "netrw",
  callback = function()
    local function try_window_jump(jump_direction, jump_count)
      local previous_window_number = vim.fn.winnr()
      vim.cmd(jump_count .. "wincmd " .. jump_direction)
      return vim.fn.winnr() ~= previous_window_number
    end

    local function try_window_jump_with_wrap(intended_jump_direction, opposite_direction)
      local jump_count = vim.v.count1
      return function()
        if not try_window_jump(intended_jump_direction, jump_count) then
          try_window_jump(opposite_direction, 999)
        end
      end
    end

    local function map(mode, key, command, options)
      options = options or {}

      options.silent = options.silent ~= false
      options.noremap = options.noremap ~= true
      options.remap = options.remap ~= true
      options.buffer = options.buffer ~= true

      vim.keymap.set(mode, key, command, options)
    end

    map("n", "<C-l>", try_window_jump_with_wrap("l", "h"), { desc = "Jump to window (right)" })
  end,
})
