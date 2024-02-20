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
vim.opt.background = "light";

require("lazy")
  .setup({
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'catppuccin/nvim', name = "catppuccin", priority = 1000 },
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope.nvim', tag = '0.1.5' },
    { 'nvim-tree/nvim-tree.lua' },
    { 'nvim-tree/nvim-web-devicons' },
  }, opts)

require('nvim-tree').setup()
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    "lua_ls",
	"pylsp",
	"vimls",
  }
})


vim.g.mapleader = ';'
vim.cmd.colorscheme "catppuccin-latte"

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4


vim.keymap.set(
  'i',
  '<leader><leader>', '<Esc>',
  { silent = true }
)

vim.keymap.set(
  'n',
  '<leader>pt', "<Cmd>NvimTreeToggle<CR>",
  { silent = true }
)
vim.keymap.set(
  'n',
  '<leader>pp', "<Cmd>lua require'telescope.builtin'.planets{}<CR>",
  { silent = true }
)
vim.keymap.set(
  'n',
  '<leader>pf', "<Cmd>lua require'telescope.builtin'.find_files{}<CR>",
  { silent = true }
)
vim.keymap.set(
  'n',
  '<leader>pg', "<Cmd>lua require'telescope.builtin'.live_grep{}<CR>",
  { silent = true }
)
vim.keymap.set(
  'n',
  '<leader>pc', "<Cmd>lua require'telescope.builtin'.git_commits{}<CR>",
  { silent = true }
)
