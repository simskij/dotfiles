---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  commit = "cfc6f2c117aaaa82f19bcce44deec2c194d900ab", -- v0.9.3, for nvim 0.9.2+
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "markdown",
      -- add more arguments for adding more treesitter parsers
    },
    auto_install = true,
  },
}
