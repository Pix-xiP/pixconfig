-- For all syntax highlighting needs, just pulling out of core to make finding easier.

return {
  -- HYPRLAND TREESITTER <3
  {
    "luckasRanarison/tree-sitter-hyprlang",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },

  -- --
  -- {
  --   "apple/pkl-neovim",
  --   opts = {},
  -- },

  -- Everything else
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "apple/pkl-neovim",
    },
    opts = {
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
        disable = { "odin" },
      },
      ensure_installed = {
        "bash",
        "c",
        "fish",
        "go",
        "ini",
        "lua",
        "markdown",
        "nix",
        "odin",
        "pkl",
        "swift",
        "tmux",
        "zig",
      },
    },
  },
}
