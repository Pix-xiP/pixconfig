-- Setting the theme!

-- Purrfect for pastel pleasure
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

-- Them SOHO vibes bby
local rose_pine = {
  "rose-pine/neovim",
  name = "rose-pine",
  opts = {
    lazy = true,
    variant = "main", -- moon
    dark_varient = "main", -- moon
    disable_background = true,
    disable_float_background = true,
  },
}

local zenbones = {
  "mcchrish/zenbones.nvim",
  dependencies = { "rktjmp/lush.nvim" },
  config = function()
    vim.g.rosebones = {
      transparent_background = true,
    }
  end,
}

local lazy_theme = {
  "LazyVim/LazyVim",
  opts = {
    colorscheme = "rosebones",
    -- colorscheme = "rose-pine",
    -- colorscheme = "ayu",
  },
}

return {
  zenbones,
  rose_pine,
  -- catppuccin,
  -- night_fox,
  lazy_theme,
}
