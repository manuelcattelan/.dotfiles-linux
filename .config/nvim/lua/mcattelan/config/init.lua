local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("mcattelan.config.keymaps")
require("lazy").setup("mcattelan.plugins", {
  install = {
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { "tokyonight" },
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = false,
  },
})
require("mcattelan.config.autocmds")
require("mcattelan.config.options")
