-- This will be where I add the majority of the files
-- that I want ot have added, plugins etc, instead of the init.lua direct.

return {

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        local theme = require("catppuccin")
        theme.setup({
          flavour = "mocha", -- latte, frappe, macchiato, mocha
          -- term_colors = true,
          transparent_background = true,
          no_italic = false,
          no_bold = false,
          styles = {
            comments = {},
            conditionals = {},
            loops = {},
            functions = {},
            keywords = {},
            strings = {},
            variables = {},
            numbers = {},
            booleans = {},
            properties = {},
            types = {},
          },
          -- color_overrides = {
          --   mocha = {
          --     base = "#000000",
          --   },
          -- },
          highlight_overrides = {
            mocha = function(C)
              return {
                TabLineSel = { bg = C.pink },
                NvimTreeNormal = { bg = C.none },
                CmpBorder = { fg = C.surface2 },
                Pmenu = { bg = C.none },
                NormalFloat = { bg = C.none },
                TelescopeBorder = { link = "FloatBorder" },
              }
            end,
          },
        })
        theme.load()
      end,
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000",
    },
  },
}
