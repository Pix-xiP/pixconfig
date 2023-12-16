-- Non specific core things I want changed about my setup.

return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        local theme = require("catppuccin")
        theme.setup({
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
  {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = {
      { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle Outline open/shut" },
    },
    opts = {
      -- Put opts here bby
    },
  },
}
