-- For all syntax highlighting needs, just pulling out of core to make finding easier.

return {
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
      matchup = {
        enable = true,
        enable_quotes = true,
      },
      incremental_selection = { enable = true },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["ak"] = { query = "@block.outer", desc = "around block" },
            ["ik"] = { query = "@block.inner", desc = "inside block" },
            ["ac"] = { query = "@class.outer", desc = "around class" },
            ["ic"] = { query = "@class.inner", desc = "inside class" },
            ["a?"] = { query = "@conditional.outer", desc = "around conditional" },
            ["i?"] = { query = "@conditional.inner", desc = "inside conditional" },
            ["af"] = { query = "@function.outer", desc = "around function " },
            ["if"] = { query = "@function.inner", desc = "inside function " },
            ["al"] = { query = "@loop.outer", desc = "around loop" },
            ["il"] = { query = "@loop.inner", desc = "inside loop" },
            ["aa"] = { query = "@parameter.outer", desc = "around argument" },
            ["ia"] = { query = "@parameter.inner", desc = "inside argument" },
          },
        },
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
        "tmux",
        "zig",
      },
    },
  },
  {
    "luckasRanarison/tree-sitter-hyprlang",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
}
