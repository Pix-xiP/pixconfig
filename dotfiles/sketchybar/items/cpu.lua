local M = {}

-- Execute the event provider binary which provides the event "cpu_update" for
-- the cpu load data, which is fired every 2.0 seconds.
sbar.exec([[
killall -q cup_load >/dev/null;
/Users/pix/.config/sketchybar/helpers/event_providers/cpu_load/bin/cpu_load cpu_update 2.0
]])

M.cpu = sbar.add("graph", "widgets.cpu", 42, {
	position = "right",
	graph = { color = colours.rosepine.main.pine },
	background = {
		height = 22,
		-- color = colours.rosepine.main.overlay,
		color = { alpha = 0 },
		-- border_color = colours.rosepine.main.base,
		drawing = true,
	},
	-- icon = { string = icons.cpu },
	label = {
		string = "cpu ??%",
		font = {
			family = "SF Mono",
			style = "Bold",
			size = 13.0,
		},
		align = "right",
		padding_right = 0,
		width = 20,
		y_offset = 5,
		-- color = colours.rosepine.main.pine,
		color = colours.basics.blue,
	},
	padding_right = 9,
})

M.cpu:subscribe("cpu_update", function(env)
	-- Also available: env.user_load, env.sys_load
	local load = tonumber(env.total_load)
	M.cpu:push({ load / 100. })

	local color = colours.basics.blue
	if load > 30 then
		if load < 60 then
			color = colours.basics.yellow
		elseif load < 80 then
			color = colours.basics.orange
		else
			color = colours.basics.red
		end
	end

	M.cpu:set({
		graph = { color = color },
		label = "cpu " .. env.total_load .. "%",
	})
end)

---@diagnostic disable-next-line: unused-local
M.cpu:subscribe("mouse.clicked", function(env)
	sbar.exec("open -a 'Activity Monitor'")
end)

-- Background around the cpu item
M.cpu_background = sbar.add("bracket", "widgets.cpu.bracket", { M.cpu.name }, {
	background = {
		-- color = colours.basics.bg2
		color = colours.rosepine.main.base,
	},
})

-- Background around the cpu item
M.cpu_padding = sbar.add("item", "widgets.cpu.padding", {
	position = "right",
	width = 5,
})

print("CPU Running")

return M
