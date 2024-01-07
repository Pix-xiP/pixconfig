-- For all syntax highlighting needs, just pulling out of core to make finding easier.

return {
  -- HYPRLAND TREESITTER <3
  {
    "luckasRanarison/tree-sitter-hyprlang",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },

  -- Everything else
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = { enable = true },
      indent = {
        enable = true,
        disable = { "odin" },
      },

      ensure_installed = {
        "bash",
        "c",
        "c_sharp",
        "fish",
        "go",
        "lua",
        "markdown",
        "odin",
        "swift",
        "zig",
      },
    },
  },
}
