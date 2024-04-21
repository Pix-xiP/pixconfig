-- A file containied plugins I want turned off.
--

return {
  {
    "folke/tokyonight.nvim",
    enabled = false, -- Colorscheme :>
  },
  {
    "ggandor/flit.nvim", -- This is basically small leap
    enabled = false, -- didn't find that useful, pull it out.
  },
  -- {
  --   "nvim-pack/nvim-spectre", -- Find and Replace
  --   enabled = false, -- Bring it back if you don't wanna use s/<pattern>/<replace>/g
  -- },
  {
    "echasnovski/mini.pairs", -- Its just getting in the way at this point.
    enabled = false,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
}
