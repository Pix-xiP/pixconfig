return {
  -- I want to be able to develop my own plugins, thanks Folke!
  {
    "folke/neodev.nvim",
    opts = {},
  },
  -- Which key for multi menu
  {
    "folke/which-key.nvim",
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["gs"] = { name = "+surround" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader><tab>"] = { name = "+tabs" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>c"] = { name = "+code" },
        ["<leader>f"] = { name = "+file/find" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>gh"] = { name = "+hunks" },
        ["<leader>q"] = { name = "+quit/session" },
        ["<leader>s"] = { name = "+search" },
        ["<leader>u"] = { name = "+ui" },
        ["<leader>w"] = { name = "+windows" },
        ["<leader>x"] = { name = "+diagnostics/quickfix" },
        ["<leader>m"] = { name = "+modify_buffer" },
        ["<leader>p"] = { name = "+pix_fn" },
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000",
    },
  },
  -- If I want to play around with smooth scrolling..
  -- {
  --   "karb94/neoscroll.nvim",
  --   config = function()
  --     require("neoscroll").setup()
  --   end,
  -- },
  {
    "L3MON4D3/LuaSnip",
    opts = {
      enabled = false,
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
  {
    "mbbill/undotree",
    lazy = true,
    keys = {
      { "<leader>cu", "<cmd>UndotreeToggle<cr>", desc = "Toggle undotree" },
    },
    opts = {},
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      colors = {
        error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
        warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
        info = { "DiagnosticInfo", "#2563EB" },
        hint = { "DiagnosticHint", "#10B981" },
        default = { "Identifier", "#7C3AED" },
        test = { "Identifier", "#FF00FF" },
        pix_todo = { "#3e8fb0" },
        pix_note = { "#c4a7e7" },
        pix_hack = { "#eb6f92" },
      },
      keywords = {
        PIXNOTE = { icon = "N", color = "pix_note", alt = { "THOUGHT" } },
        PIXHACK = { icon = "? ", color = "pix_hack", alt = { "HACKFIX" } },
        PIXTODO = { icon = "P", color = "pix_todo", alt = { "TODO: (Pix):" } },
      },
    },
  },
  {
    "laytan/cloak.nvim",
    enabled = true,
    cloak_character = "*",
    highlight_group = "Comment",
    cloak_length = nil,
    try_all_patterns = true,
    patterns = {
      file_pattern = ".env",
      cloak_pattern = "=.+",
      replace = nil,
    },
  },
  {
    "dlvhdr/gh-blame.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
    keys = {
      { "<leader>gb", "<cmd>GhBlameCurrentLine<cr>", desc = "GitHub Blame Current Line" },
    },
  },
  {
    "ellisonleao/glow.nvim",
    config = true,
    cmd = "Glow",
  },
}
