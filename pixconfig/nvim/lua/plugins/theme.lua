-- Setting the theme!
local catppuccin = {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      lazy = true,
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      --term_colors = true,
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
    },
  },
}

local night_fox = {
  {
    "EdenEast/nightfox.nvim",
    name = "nightfox",
    opts = {
      lazy = true,
      transparent = true,
    },
  },
}

-- local rose_pine_moon = {
--   "rose-pine/neovim",
--   name = "rose-pine-moon",
--   opts = {
--     lazy = true,
--     variant = "moon",
--     dark_variant = "moon",
--     disable_background = true,
--     disable_float_background = true,
--   },
-- }
local rose_pine = {
  "rose-pine/neovim",
  name = "rose-pine",
  opts = {
    lazy = true,
    disable_background = true,
    disable_float_background = true,
  },
}

local lazy_theme = {
  "LazyVim/LazyVim",
  opts = {
    colorscheme = "rose-pine",
  },
}

return {
  rose_pine,
  -- rose_pine_moon,
  catppuccin,
  night_fox,
  lazy_theme,
}
