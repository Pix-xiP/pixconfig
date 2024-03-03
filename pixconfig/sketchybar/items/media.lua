local sbar = require("sketchybar")

local M = {}

local whitelist = { ["Spotify"] = true, ["Music"] = true, ["Youtube Music"] = true }

M.media = sbar.add("item", {
	icon = { drawing = false },
	position = "center",
	updates = true,
})

M.media:subscribe("media_change", function(env)
	if whitelist[env.INFO.app] then
		M.media:set({
			drawing = (env.INFO.state == "playing") and true or false,
			label = env.INFO.artist .. ": " .. env.INFO.title,
		})
	end
end)

return M
