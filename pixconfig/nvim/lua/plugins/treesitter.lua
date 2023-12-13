-- For all syntax highlighting needs, just pulling out of core to make finding easier.

return {
  "luckasRanarison/tree-sitter-hypr",
}, {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    vim.list_extend(opts.ensure_installed, {
      ensure_installed = {
        "swift",
        "fish",
        "zig",
        "odin",
        "c",
        "markdown",
        "lua",
        "bash",
        "hypr",
      },
    })
  end,
}
