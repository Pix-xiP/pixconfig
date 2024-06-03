-- Setting the theme!

-- Purrfect for pastel pleasure
-- local catppuccin = {
--   {
--     "catppuccin/nvim",
--     name = "catppuccin",
--     opts = {
--       lazy = true,
--       flavour = "mocha", -- latte, frappe, macchiato, mocha
--       --term_colors = true,
--       transparent_background = true,
--       no_italic = false,
--       no_bold = false,
--       styles = {
--         comments = {},
--         conditionals = {},
--         loops = {},
--         functions = {},
--         keywords = {},
--         strings = {},
--         variables = {},
--         numbers = {},
--         booleans = {},
--         properties = {},
--         types = {},
--       },
--       highlight_overrides = {
--         mocha = function(C)
--           return {
--             TabLineSel = { bg = C.pink },
--             NvimTreeNormal = { bg = C.none },
--             CmpBorder = { fg = C.surface2 },
--             Pmenu = { bg = C.none },
--             NormalFloat = { bg = C.none },
--             TelescopeBorder = { link = "FloatBorder" },
--           }
--         end,
--       },
--     },
--   },
-- }

return {
  -- {
  --   "cdmill/neomodern.nvim",
  --   name = "neomodern",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("neomodern").setup({
  --       -- Main options --
  --       style = "iceclimber", -- choose between 'iceclimber', 'coffeecat', 'darkforest', 'campfire', 'roseprime', 'daylight'
  --       toggle_style_key = nil, -- keymap to cycle between styles
  --       toggle_style_list = { -- a table of which styles to cycle through, by default all styles are included
  --         "iceclimber",
  --         "coffeecat",
  --         "darkforest",
  --         "campfire",
  --         "roseprime",
  --         "daylight",
  --       },
  --       transparent = false, -- don't set background
  --       term_colors = true, -- if true enable the terminal
  --
  --       -- Formatting --
  --       code_style = {
  --         comments = "italic",
  --         conditionals = "none",
  --         functions = "none",
  --         keywords = "none",
  --         headings = "bold", -- markdown headings
  --         operators = "none",
  --         keyword_return = "none",
  --         strings = "none",
  --         variables = "none",
  --       },
  --
  --       -- UI options --
  --       ui = {
  --         cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
  --         colored_docstrings = true, -- if true, docstrings will be highlighted like strings, otherwise they will be highlighted like comments
  --         plain = false, -- don't set background for search
  --         show_eob = true, -- show the end-of-buffer tildes
  --
  --         -- Plugins Related --
  --         lualine = {
  --           bold = true,
  --           plain = false, -- use a less distracting lualine. note: works best when no lualine separators are used
  --         },
  --         telescope = "bordered", -- choose between 'borderless' or 'bordered'
  --         diagnostics = {
  --           darker = true, -- darker colors for diagnostic
  --           undercurl = true, -- use undercurl for diagnostics
  --           background = true, -- use background color for virtual text
  --         },
  --       },
  --
  --       -- Custom Highlights --
  --       colors = {}, -- Override default colors
  --       highlights = {}, -- Override highlight groups
  --     })
  --     require("neomodern").load()
  --   end,
  -- },
  {
    -- Purrfect for pastel pleasure
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
  {
    -- Them SOHO vibes bby
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    opts = {
      lazy = true,
      variant = "main", -- moon
      dark_varient = "main", -- moon
      disable_background = true,
      disable_float_background = true,
    },
  },
  {
    "mcchrish/zenbones.nvim",
    dependencies = { "rktjmp/lush.nvim" },
    config = function()
      -- vim.g.rosebones = {
      --   transparent_background = true,
      -- }
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "catppuccin",
      -- colorscheme = "rosebones",
      -- colorscheme = "rose-pine",
      -- colorscheme = "neomodern",
      colorscheme = "umbra",
    },
  },
  -- {
  --   "shmerl/neogotham",
  --   lazy = false, -- to make sure it's loaded on startup
  --   priority = 1000, -- to load before other plugins
  --   config = function()
  --     vim.cmd.colorscheme("neogotham")
  --   end,
  -- },
  {
    -- Bayonetta insprised theme *chefs kiss*
    "LZDQ/umbra.nvim",
    name = "umbra",
    lazy = false,
    priority = 1000,
    config = {
      -- local umbra = require('umbra')

      -- Main options --
      -- Default theme style. Choose between 'bloodmoon', 'moonlight', 'darkest', 'dark', 'darker',
      --                                     'cool', 'deep', 'warm', 'warmer' and 'light'
      style = "moonlight",
      transparent = false, -- Show/hide background
      term_colors = true, -- Change terminal color as per the selected theme style
      ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
      cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

      -- toggle theme style ---
      toggle_style_key = nil,
      toggle_style_list = {},
      -- toggle_style_key = "!", -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
      -- toggle_style_list = {
      --   "moonlight",
      --   "darkest",
      --   "bloodmoon",
      --   -- 'deep',
      --   -- 'warm',
      --   "warmer",
      --   -- 'dark',
      --   -- 'darker',
      --   "cool",
      --   "light",
      -- }, -- List of styles to toggle between

      -- Change code style ---
      -- Options are italic, bold, underline, none
      -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
      code_style = {
        comments = "italic",
        keywords = "none",
        functions = "bold",
        strings = "none",
        variables = "none",
      },

      -- Lualine options --
      lualine = {
        transparent = false, -- lualine center bar transparency
      },

      -- Custom Highlights --
      colors = {}, -- Override default colors
      highlights = { -- Override highlight groups
      },

      -- Plugins Config --
      diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true, -- use undercurl instead of underline for diagnostics
        background = true, -- use background color for virtual text
      },
    },
  },
}
