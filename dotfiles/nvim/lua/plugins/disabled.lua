-- disabled.lua - A file containied plugins I want turned off.

return {
	{
		"ggandor/flit.nvim", -- This is basically small leap
		enabled = false, -- didn't find that useful, pull it out.
	},
	{
		"echasnovski/mini.pairs", -- Its just getting in the way at this point.
		enabled = false,
	},
	{
		"nvim-neo-tree/neo-tree.nvim", -- I don't use a file tree to navigate anymore
		enabled = false,
	},
	--- Causing errors in zig atm..
	{
		"garymjr/nvim-snippets",
		enabled = false,
	},
}
