return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
      },
    },
    keys = {
      {
        "<leader>sb",
        function()
          require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_ivy({
            previewer = false,
          }))
        end,
      },
    },
  },
}
