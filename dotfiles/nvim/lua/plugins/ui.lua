-- Setting UI elements!

return {
  -- {
  --   -- Purrfect for pastel pleasure
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   opts = {
  --     lazy = true,
  --     flavour = "mocha", -- latte, frappe, macchiato, mocha
  --     --term_colors = true,
  --     transparent_background = true,
  --     no_italic = false,
  --     no_bold = false,
  --     styles = {
  --       comments = {},
  --       conditionals = {},
  --       loops = {},
  --       functions = {},
  --       keywords = {},
  --       strings = {},
  --       variables = {},
  --       numbers = {},
  --       booleans = {},
  --       properties = {},
  --       types = {},
  --     },
  --     highlight_overrides = {
  --       mocha = function(C)
  --         return {
  --           TabLineSel = { bg = C.pink },
  --           NvimTreeNormal = { bg = C.none },
  --           CmpBorder = { fg = C.surface2 },
  --           Pmenu = { bg = C.none },
  --           NormalFloat = { bg = C.none },
  --           TelescopeBorder = { link = "FloatBorder" },
  --         }
  --       end,
  --     },
  --   },
  -- },
  -- {
  --   -- Them SOHO vibes bby
  --   "rose-pine/neovim",
  --   name = "rose-pine",
  --   priority = 1000,
  --   opts = {
  --     lazy = true,
  --     variant = "main", -- moon
  --     dark_varient = "main", -- moon
  --     disable_background = true,
  --     disable_float_background = true,
  --   },
  -- },
  -- {
  --   -- Bayonetta insprised theme *chefs kiss*
  --   "LZDQ/umbra.nvim",
  --   name = "umbra",
  --   lazy = false,
  --   priority = 1000,
  --   config = {
  --     -- local umbra = require('umbra')
  --
  --     -- Main options --
  --     -- Default theme style. Choose between 'bloodmoon', 'moonlight', 'darkest', 'dark', 'darker',
  --     --                                     'cool', 'deep', 'warm', 'warmer' and 'light'
  --     style = "moonlight",
  --     transparent = false, -- Show/hide background
  --     term_colors = true, -- Change terminal color as per the selected theme style
  --     ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
  --     cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
  --
  --     -- toggle theme style ---
  --     toggle_style_key = nil,
  --     toggle_style_list = {},
  --     -- toggle_style_key = "!", -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
  --     -- toggle_style_list = {
  --     --   "moonlight",
  --     --   "darkest",
  --     --   "bloodmoon",
  --     --   -- 'deep',
  --     --   -- 'warm',
  --     --   "warmer",
  --     --   -- 'dark',
  --     --   -- 'darker',
  --     --   "cool",
  --     --   "light",
  --     -- }, -- List of styles to toggle between
  --
  --     -- Change code style ---
  --     -- Options are italic, bold, underline, none
  --     -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
  --     code_style = {
  --       comments = "italic",
  --       keywords = "none",
  --       functions = "bold",
  --       strings = "none",
  --       variables = "none",
  --     },
  --
  --     -- Lualine options --
  --     lualine = {
  --       transparent = false, -- lualine center bar transparency
  --     },
  --
  --     -- Custom Highlights --
  --     colors = {}, -- Override default colors
  --     highlights = { -- Override highlight groups
  --     },
  --
  --     -- Plugins Config --
  --     diagnostics = {
  --       darker = true, -- darker colors for diagnostic
  --       undercurl = true, -- use undercurl instead of underline for diagnostics
  --       background = true, -- use background color for virtual text
  --     },
  --   },
  -- },
  {
    "Shadorain/shadotheme",
    lazy = false, -- to make sure it's loaded on startup
    priority = 1000, -- to load before other plugins
  },
  {
    "brenoprata10/nvim-highlight-colors",
    lazy = true,
    opts = {
      ---Render style
      ---@usage 'background'|'foreground'|'virtual'
      render = "background",

      ---Set virtual symbol (requires render to be set to 'virtual')
      virtual_symbol = "■",

      ---Set virtual symbol suffix (defaults to '')
      virtual_symbol_prefix = "",

      ---Set virtual symbol suffix (defaults to ' ')
      virtual_symbol_suffix = " ",

      ---Set virtual symbol position()
      ---@usage 'inline'|'eol'|'eow'
      ---inline mimics VS Code style
      ---eol stands for `end of column` - Recommended to set `virtual_symbol_suffix = ''` when used.
      ---eow stands for `end of word` - Recommended to set `virtual_symbol_prefix = ' ' and virtual_symbol_suffix = ''` when used.
      virtual_symbol_position = "inline",

      ---Highlight hex colors, e.g. '#FFFFFF'
      enable_hex = true,

      ---Highlight short hex colors e.g. '#fff'
      enable_short_hex = true,

      ---Highlight rgb colors, e.g. 'rgb(0 0 0)'
      enable_rgb = true,

      ---Highlight hsl colors, e.g. 'hsl(150deg 30% 40%)'
      enable_hsl = true,

      ---Highlight CSS variables, e.g. 'var(--testing-color)'
      enable_var_usage = true,

      ---Highlight named colors, e.g. 'green'
      enable_named_colors = true,

      ---Highlight tailwind colors, e.g. 'bg-blue-500'
      enable_tailwind = false,

      ---Set custom colors
      ---Label must be properly escaped with '%' to adhere to `string.gmatch`
      --- :help string.gmatch
      custom_colors = {
        { label = "%-%-theme%-primary%-color", color = "#0f1219" },
        { label = "%-%-theme%-secondary%-color", color = "#5a5d64" },
      },

      -- Exclude filetypes or buftypes from highlighting e.g. 'exclude_buftypes = {'text'}'
      exclude_filetypes = {},
      exclude_buftypes = {},
    },
    init = function()
      require("nvim-highlight-colors").turnOn()
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "catppuccin",
      -- colorscheme = "rosebones",
      -- colorscheme = "rose-pine",
      -- colorscheme = "neomodern",
      -- colorscheme = "umbra",
      -- colorscheme = "darkrose",
      -- colorscheme = "shado",
      colorscheme = function()
        vim.cmd.colorscheme("shado")
        local function hl(...)
          vim.api.nvim_set_hl(0, ...)
        end

        -- No Transparent:
        -- hl("Normal", { bg = "#090917" })
        -- hl("Comment", { fg = "#6260a2", italic = true })
        -- For transparent:
        hl("Normal", { bg = "none" })
        hl("NormalFloat", { bg = "none" })
        hl("Comment", { bg = "none", fg = "#6260a2", italic = true })
        hl("LineNr", { fg = "#505079", bg = "none" })
      end,
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      sections = {
        lualine_a = {
          {
            "mode",
            icons_enabled = true,
            separator = {
              -- left = "",
              -- right = "",
              right = "",
            },
            fmt = function()
              local mode_map = {
                n = "N (ᴗ_ ᴗ。)",
                nt = "N (ᴗ_ ᴗ。)",
                i = "I (•̀ - •́ )",
                R = "R ( •̯́ ₃ •̯̀)",
                v = "V (⊙ _ ⊙ )",
                V = "V (⊙ _ ⊙ )",
                no = "C Σ(°△°||)",
                ["\22"] = "V (⊙ _ ⊙ )",
                t = "T (⌐■_■)",
                ["!"] = "C Σ(°△°||)",
                c = "C Σ(°△°||)",
                s = "S SUB",
              }
              return mode_map[vim.api.nvim_get_mode().mode] or vim.api.nvim_get_mode().mode
            end,
          },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters = {
        markdownlint = {
          args = { "--config", "~/.config/formatting/markdownlint.jsonc", "--" },
        },
      },
    },
  },
  -- {
  --   "OXY2DEV/markview.nvim",
  --   lazy = false,
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "nvim-tree/nvim-web-devicons",
  --   },
  -- },
}
