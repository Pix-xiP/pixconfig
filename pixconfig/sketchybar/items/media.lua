local sbar = require("sketchybar")
local colours = require("colours")

local M = {}

local whitelist = {
	["Spotify"] = true,
	["Music"] = true,
	["Youtube Music"] = true,
	["Arc"] = true,
}

M.media = sbar.add("item", {
	icon = { drawing = false },
	position = "center",
	updates = true,
	popup = {
		background = {
			border_width = 2,
			corner_radius = 9,
		},
		height = 150,
		horizontal = true,
	},
})

M.cover = sbar.add("item", "cover", {
	position = "popup." .. M.media.name,
	padding_left = 12,
	padding_right = 10,
	label = { drawing = false },
	icon = { drawing = false },
})

function M.next()
	sbar.exec("nowplaying-cli next")
end

function M.prev()
	sbar.exec("nowplaying-cli previous")
end

function M.play_pause()
	sbar.exec("nowplaying-cli togglePlayPause")
end

M.media:subscribe("media_change", function(env)
	sbar.exec("nowplaying-cli get artworkData | base64 -d > /tmp/album_cover.jpg")
	if whitelist[env.INFO.app] then
		M.media:set({
			drawing = (env.INFO.state == "playing") and true or false,
			label = env.INFO.artist .. " - " .. env.INFO.title,
		})
		M.cover:set({
			background = {
				color = "0x00000000",
				image = {
					scale = 1.0,
					drawing = true,
					string = "/tmp/album_cover.jpg",
				},
			},
		})
	end
end)

M.media:subscribe("mouse_clicked", function(env)
	print("Clicked")
	if env.NAME == "next" then
		M.next()
	elseif env.NAME == "prev" then
		M.prev()
	elseif env.NAME == "play_pause" then
		M.play_pause()
	end
end)

M.media:subscribe("mouse.entered", function(env)
	M.media:set({ popup = { drawing = true } })
end)

M.media:subscribe("mouse.exited", function(env)
	M.media:set({ popup = { drawing = false } })
end)

return M
