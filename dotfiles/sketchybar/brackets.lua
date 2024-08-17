local items = require("items")

local M = {}

function M.merge_lists(t1, t2)
	local merged = {}
	for _, v in pairs(t1) do
		table.insert(merged, v)
	end
	for _, v in pairs(t2) do
		table.insert(merged, v)
	end
	return merged
end

-- -- I don't think I like this.. might just be easier to do it by hand?
-- local temp = M.merge_lists(items.volume.bracket, items.brew.bracket)
-- local temp2 = M.merge_lists(temp, items.battery.bracket)
-- local total = M.merge_lists(temp2, items.wifi.bracket)
--
-- instead why not just add the first and last items? Does look abit odd, but /shrug
local total = { items.brew.brew.name, items.discord.discord.name }

sbar.add("bracket", total, {
	padding_left = 5,
	padding_right = 5,

	background = {
		color = colours.rosepine.main.base,
		-- border_color = colours.rosepine.main.muted,
	},
})

print("Brackets loaded")

return M
