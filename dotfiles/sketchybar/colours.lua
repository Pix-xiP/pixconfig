local T = {}

T.basics = {
	black = 0xff181926,
	white = 0xffcad3f5,
	red = 0xffed8796,
	green = 0xffa6da95,
	blue = 0xff8aadf4,
	yellow = 0xffeed49f,
	orange = 0xfff5a97f,
	magenta = 0xffc6a0f6,
	grey = 0xff939ab7,
	transparent = 0x00000000,

	bar = {
		bg = 0xd01e1e2e,
		border = 0xff494d64,
	},
	popup = {
		bg = 0xff1e1e2e,
		border = 0xffcad3f5,
	},
	bg1 = 0x809c3e4f,
	bg2 = 0xff494d64,
}
T.rosepine = {
	moon = {
		nc = "0xff1f1d30",

		-- Primary Background
		-- General background, e.g. windows, tabs
		-- Extended panels, e.g. sidebars
		base = "0xff232136",

		-- Secondary background atop base
		-- Accessory panels, e.g. popups, floats, editor terminals
		-- Inputs, e.g. text search, checkboxes
		surface = "0xff2a273f",

		-- Tertiary background atop surface
		-- Active backgrounds, e.g. tabs, list items
		-- High contrast inputs, e.g. text search, checkboxes
		-- Hover selections
		-- Terminal black
		overlay = "0xff393552",

		-- Low contrast foreground
		-- Ignored content, e.g. ignored Git files
		-- Terminal bright black
		muted = "0xff6e6a86",

		-- Medium contrast foreground
		-- Inactive foregrounds, e.g. tabs, list items
		subtle = "0xff908caa",

		-- Text
		-- High contrast foreground
		-- Active foregrounds, e.g. tabs, list items
		-- Cursor foreground paired with highlight high background
		-- Selection foreground paired with highlight med background
		-- Terminal white, bright white
		text = "0xffe0def4",

		-- Per favore ama tutti
		-- Diagnostic errors
		-- Deleted Git files
		-- Terminal red, bright red
		love = "0xffeb6f92",

		-- Lemon tea on a summer morning
		-- Diagnostic warnings
		-- Terminal yellow, bright yellow
		gold = "0xfff6c177",

		-- A beautiful yet cautious blossom
		-- Matching search background paired with base foreground
		-- Modified Git files
		-- Terminal cyan, bright cyan
		rose = "0xffea9a97",

		-- Fresh winter greenery
		-- Renamed Git files
		-- Terminal green, bright green
		pine = "0xff3e8fb0",

		-- Saltwater tidepools
		-- Diagnostic information
		-- Git additions
		-- Terminal blue, bright blue
		foam = "0xff9ccfd8",

		-- Smells of groundedness
		-- Diagnostic hints
		-- Inline links
		-- Merged and staged Git modifications
		-- Terminal magenta, bright magenta
		iris = "0xffc4a7e7",

		-- Low contrast highlight
		-- Cursorline background
		highlight_low = "0xff2a283e",

		-- Medium contrast highlight
		-- Selection background paired with text foreground
		highlight_med = "0xff44415a",

		-- High contrast highlight
		-- Borders / visual dividers
		-- Cursor background paired with text foreground
		highlight_high = "0xff56526e",

		none = "NONE",
	},
	main = {
		nc = "0xff1f1d30",

		-- Primary Background
		-- General background, e.g. windows, tabs
		-- Extended panels, e.g. sidebars
		base = "0xff191724",

		-- Secondary background atop base
		-- Accessory panels, e.g. popups, floats, editor terminals
		-- Inputs, e.g. text search, checkboxes
		surface = "0xff1f1d2e",

		-- Tertiary background atop surface
		-- Active backgrounds, e.g. tabs, list items
		-- High contrast inputs, e.g. text search, checkboxes
		-- Hover selections
		-- Terminal black
		overlay = "0xff26233a",

		-- Low contrast foreground
		-- Ignored content, e.g. ignored Git files
		-- Terminal bright black
		muted = "0xff6e6a86",

		-- Medium contrast foreground
		-- Inactive foregrounds, e.g. tabs, list items
		subtle = "0xff908caa",

		-- Text
		-- High contrast foreground
		-- Active foregrounds, e.g. tabs, list items
		-- Cursor foreground paired with highlight high background
		-- Selection foreground paired with highlight med background
		-- Terminal white, bright white
		text = "0xffe0def4",

		-- Per favore ama tutti
		-- Diagnostic errors
		-- Deleted Git files
		-- Terminal red, bright red
		love = "0xffeb6f92",

		-- Lemon tea on a summer morning
		-- Diagnostic warnings
		-- Terminal yellow, bright yellow
		gold = "0xfff6c177",

		-- A beautiful yet cautious blossom
		-- Matching search background paired with base foreground
		-- Modified Git files
		-- Terminal cyan, bright cyan
		rose = "0xffebbcba",

		-- Fresh winter greenery
		-- Renamed Git files
		-- Terminal green, bright green
		pine = "0xff31748f",

		-- Saltwater tidepools
		-- Diagnostic information
		-- Git additions
		-- Terminal blue, bright blue
		foam = "0xff9ccfd8",

		-- Smells of groundedness
		-- Diagnostic hints
		-- Inline links
		-- Merged and staged Git modifications
		-- Terminal magenta, bright magenta
		iris = "0xffc4a7e7",

		-- Low contrast highlight
		-- Cursorline background
		highlight_low = "0xff21202e",

		-- Medium contrast highlight
		-- Selection background paired with text foreground
		highlight_med = "0xff403d52",

		-- High contrast highlight
		-- Borders / visual dividers
		-- Cursor background paired with text foreground
		highlight_high = "0xff524f67",

		none = "NONE",
	},
}

return T
