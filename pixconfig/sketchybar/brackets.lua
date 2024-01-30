local sbar = require("sketchybar")
local colours = require("colours")
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
local total = { items.brew.brew.name, items.battery.battery.name }

sbar.add("bracket", total, {
	background = { color = colours.rose_pallete.overlay, border_color = colours.rose_pallete.muted },
})

-- sbar.add("bracket", items.volume.bracket, {
-- 	background = { color = colours.grey, border_color = colours.magenta },
-- })
--
-- sbar.add("bracket", { items.brew.brew.name, items.wifi.wifi.name }, {
-- 	background = { color = colours.magenta, border_color = colours.red },
-- })

print("Setting up brackets")

return M
