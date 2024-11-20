local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.background = "light";

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

require("lazy")
  .setup({
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'neovim/nvim-lspconfig' },
    { 'neovim/nvim-lsp' },
    { 'catppuccin/nvim', name = "catppuccin", priority = 1000 },
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope.nvim', tag = '0.1.5' },
    { 'nvim-tree/nvim-tree.lua' },
    { 'nvim-tree/nvim-web-devicons' },
    { 'hrsh7th/cmp-nvim-lua' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-cmdline' },
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-vsnip' },
    { 'hrsh7th/vim-vsnip' },
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

local cmp = require('cmp')

cmp.setup({
  snippet = {
      expand = function(args)
          vim.fn["vsnip#anonymous"](args.body)
      end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'buffer' },
    { name = 'path' },
    { name = "nvim_lua" },
  }),
  mapping = {
    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
    ['<Down>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
    ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),

    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-y>'] = cmp.mapping.confirm({select = true}),
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    ['<Tab>'] = cmp.mapping(function(fallback)
      local col = vim.fn.col('.') - 1

      if cmp.visible() then
        cmp.select_next_item(select_opts)
      elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        fallback()
      else
        cmp.complete()
      end
    end, {'i', 's'}),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(select_opts)
      else
        fallback()
      end
    end, {'i', 's'}),
  },

})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig')['pylsp'].setup{ capabilities = capabilities }
require('lspconfig')['vimls'].setup{ capabilities = capabilities }


vim.g.mapleader = ';'
vim.cmd.colorscheme "catppuccin-frappe"

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
  '<leader>ff', "<Cmd>lua require'telescope.builtin'.find_files{}<CR>",
  { silent = true }
)
vim.keymap.set(
  'n',
  '<leader>fg', "<Cmd>lua require'telescope.builtin'.live_grep{}<CR>",
  { silent = true }
)
vim.keymap.set(
  'n',
  '<leader>fc', "<Cmd>lua require'telescope.builtin'.git_commits{}<CR>",
  { silent = true }
)
