local p = require("pix.window_spawn")

return {
  {
    dir = "~/.config/nvim/lua/pix",
    keys = {
      {
        "<leader>fp",
        function()
          p:toggle_window()
        end,
      },
    },
  },
}
