-- Adding coding related things to this file moving forward.
-- Basing the file layout design off of Folke's LazyVim cause I like it :>

return {
  -- Using Folke's mini surround from LazyVim cause I like this setup:
  {
    "echasnovski/mini.surround",
    version = "*",
    opts = {
      -- Add custom surroundings to be used on top of builtin ones. For more
      -- information with examples, see `:h MiniSurround.config`.
      custom_surroundings = nil,

      -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
      highlight_duration = 500,

      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
  },
  {
    "ej-shafran/compile-mode.nvim",
    -- tag = "v5.*",
    branch = "latest",
    -- you can just use the latest version:
    -- branch = "latest",
    -- or the most up-to-date updates:
    -- branch = "nightly",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- if you want to enable coloring of ANSI escape codes in compilation output, add:
      { "m00qek/baleia.nvim", tag = "v1.3.0" },
    },
    config = function()
      vim.g.compile_mode = {
        -- to add ANSI escape code support, add:
        baleia_setup = true,
        default_command = "",
        error_threshold = require("compile-mode").level.INFO,
        recompile_no_fail = true,
      }
    end,
  },
  {
    "Kicamon/markdown-table-mode.nvim",
    opts = {
      insert = true,
      insert_leave = true,
    },
  },
}
