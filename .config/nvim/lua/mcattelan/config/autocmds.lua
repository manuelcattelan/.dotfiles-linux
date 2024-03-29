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

-- Smart way to close file explorer if it is the last open window
vim.api.nvim_create_autocmd("QuitPre", {
  group = create_augroup("file_explorer"),
  callback = function()
    local tree_windows = {}
    local floating_windows = {}
    local current_windows = vim.api.nvim_list_wins()
    for _, window in ipairs(current_windows) do
      local buffer_name = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(window))
      if buffer_name:match("NvimTree_") ~= nil then
        table.insert(tree_windows, window)
      end
      if vim.api.nvim_win_get_config(window).relative ~= "" then
        table.insert(floating_windows, window)
      end
    end
    if 1 == #current_windows - #floating_windows - #tree_windows then
      -- Should quit, so we close all invalid windows.
      for _, window in ipairs(tree_windows) do
        vim.api.nvim_win_close(window, true)
      end
    end
  end,
})
