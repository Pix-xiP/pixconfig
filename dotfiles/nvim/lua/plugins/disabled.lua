-- disabled.lua - a file for all the stuff we want to turn off inside lazy
-- until such time that I make my own completely.

return {
	{
		"ggandor/flit.nvim",
		enabled = false,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		enabled = false,
	},
	{
		"garymjr/nvim-snippets",
		enabled = false,
	},
	{
		"L3MON4D3/LuaSnip",
		enabled = false,
	},
	{
		"catppuccin/nvim",
		enabled = false,
	},
	{
		"hrsh7th/nvim-cmp", -- we use blink instead.
		optional = true,
		enabled = false,
	},
}
