-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  {
    "github/copilot.vim",
    autoLoad = true,
  },
  {
    "nosduco/remote-sshfs.nvim",
    autoLoad = true,
    opts = {
      mounts = {
        base_dir = vim.fn.expand "$HOME" .. "/.sshfs",
        unmount_on_exit = true,
      },
    },
  },
}
