local sbar = require("sketchybar")
local colours = require("colours")
local app_icons = require("app_icons")

local M = {}

function M.mouse_click(env)
	if env.BUTTON == "right" then
		-- sbar.exec("yabai -m space --destroy " .. env.SID .. " && sketchybar --trigger space_change")
		print("Unable to destroy because not true YABAI")
	else
		-- sbar.exec("yabai -m space --focus " .. env.SID)
		print("Unable to focus because not running true YABAI")
	end
end

function M.space_selection(env)
	local colour = env.SELECTED == "true" and colours.rose_pallete.highlight_high
	sbar.set(env.NAME, {
		icon = { highlight = env.SELECTED },
		label = { highlight = env.SELECETD },
		background = { border_color = colour },
	})
end

M.spaces = {}
for i = 1, 10, 1 do
	local space = sbar.add("space", {
		associated_space = i,
		icon = {
			string = i,
			padding_left = 7,
			padding_right = 7,
			color = colours.rose_pallete.text,
			highlight_color = colours.rose_pallete.love,
		},
		padding_left = 1,
		padding_right = 1,
		label = {
			padding_right = 20,
			color = colours.rose_pallete.text,
			highlight_color = colours.rose_pallete.love,
			font = "sketchybar-app-font:Regular:16.0",
			y_offset = -1,
			drawing = true,
		},
	})

	M.spaces[i] = space.name
	space:subscribe("space_change", M.space_selection)
	space:subscribe("mouse.clicked", M.mouse_click)
end

-- This is the bracket around the spaces?
sbar.add("bracket", M.spaces, {
	background = { color = colours.rose_pallete.surface, border_color = colours.rose_pallete.overlay },
})

M.space_creator = sbar.add("item", {
	position = "left",
	padding_left = 5,
	padding_right = 5,
	icon = {
		string = "􀆊",
		font = { style = "Heavy", size = 16.0 },
	},
	label = { drawing = false },
	associated_display = "active",
})

M.space_creator:subscribe("mouse.clicked", function(_)
	print("cannot change space due to not true YABAI")
	-- sbar.exec("yabai -m space --create && sketchybar --trigger space_change")
end)

M.space_creator:subscribe("space_windows_change", function(env)
	local icon_line = ""
	local no_app = true
	for app, _ in pairs(env.INFO.apps) do
		no_app = false
		local lookup = app_icons[app]
		local icon = ((lookup == nil) and app_icons["default"] or lookup)
		icon_line = icon_line .. " " .. icon
	end
	if no_app then
		icon_line = " —"
	end

	sbar.animate("tanh", 10, function()
		sbar.set(M.spaces[env.INFO.space], {
			label = { string = icon_line, color = colours.rose_pallete.iris },
		})
	end)
end)

print("Spaces running")

return M

-- -- local settings = require("settings")
-- local colors = require("colours")
-- local app_icons = require("app_icons")
-- local sbar = require("sketchybar")
--
-- local spaces = {}
--
-- for i = 1, 10, 1 do
-- 	local space = sbar.add("space", "space." .. i, {
-- 		space = i,
-- 		icon = {
-- 			font = { family = "SF Pro" },
-- 			string = i,
-- 			padding_left = 15,
-- 			padding_right = 8,
-- 			color = colors.basics.white,
-- 			highlight_color = colors.basics.red,
-- 		},
-- 		label = {
-- 			padding_right = 20,
-- 			color = colors.basics.grey,
-- 			highlight_color = colors.basics.white,
-- 			font = "sketchybar-app-font:Regular:16.0",
-- 			y_offset = -1,
-- 		},
-- 		padding_right = 1,
-- 		padding_left = 1,
-- 		background = {
-- 			color = colors.basics.bg1,
-- 			border_width = 3,
-- 			border_color = colors.basics.transparent,
-- 		},
-- 		popup = { background = { border_width = 5, border_color = colors.basics.black } },
-- 	})
--
-- 	spaces[i] = space
--
-- 	-- Padding space
-- 	sbar.add("space", "space.padding." .. i, {
-- 		space = i,
-- 		script = "",
-- 		width = 3,
-- 	})
--
-- 	local space_popup = sbar.add("item", {
-- 		position = "popup." .. space.name,
-- 		padding_left = 5,
-- 		padding_right = 0,
-- 		background = {
-- 			drawing = true,
-- 			image = {
-- 				corner_radius = 9,
-- 				scale = 0.2,
-- 			},
-- 		},
-- 	})
--
-- 	space:subscribe("space_change", function(env)
-- 		local selected = env.SELECTED == "true"
-- 		local color = selected and colors.basics.red or colors.basics.bg2
-- 		space:set({
-- 			icon = { highlight = selected },
-- 			label = { highlight = selected },
-- 			background = { border_color = selected and colors.basics.black or colors.basics.bg2 },
-- 		})
-- 		-- space_bracket:set({
-- 		-- 	background = { border_color = selected and colors.basics.black or colors.basics.bg2 },
-- 		-- })
-- 	end)
--
-- 	space:subscribe("mouse.clicked", function(env)
-- 		if env.BUTTON == "other" then
-- 			space_popup:set({ background = { image = "space." .. env.SID } })
-- 			space:set({ popup = { drawing = "toggle" } })
-- 		else
-- 			local op = (env.BUTTON == "right") and "--destroy" or "--focus"
-- 			sbar.exec("yabai -m space " .. op .. " " .. env.SID)
-- 		end
-- 	end)
--
-- 	space:subscribe("mouse.exited", function(_)
-- 		space:set({ popup = { drawing = false } })
-- 	end)
-- end
--
-- local space_window_observer = sbar.add("item", {
-- 	drawing = false,
-- 	updates = true,
-- })
--
-- space_window_observer:subscribe("space_windows_change", function(env)
-- 	local icon_line = ""
-- 	local no_app = true
-- 	for app, count in pairs(env.INFO.apps) do
-- 		no_app = false
-- 		local lookup = app_icons[app]
-- 		local icon = ((lookup == nil) and app_icons["default"] or lookup)
-- 		icon_line = icon_line .. " " .. icon
-- 	end
--
-- 	if no_app then
-- 		icon_line = " —"
-- 	end
-- 	sbar.animate("tanh", 10, function()
-- 		spaces[env.INFO.space]:set({ label = icon_line })
-- 	end)
-- end)
--
-- -- spaces_indicator:subscribe("swap_menus_and_spaces", function(env)
-- --   local currently_on = spaces_indicator:query().icon.value == icons.switch.on
-- --   spaces_indicator:set({
-- --     icon = currently_on and icons.switch.off or icons.switch.on
-- --   })
-- -- end)
--
-- -- spaces_indicator:subscribe("mouse.entered", function(env)
-- --   sbar.animate("tanh", 30, function()
-- --     spaces_indicator:set({
-- --       background = {
-- --         color = { alpha = 1.0 },
-- --         border_color = { alpha = 1.0 },
-- --       },
-- --       icon = { color = colors.basics.bg1 },
-- --       label = { width = "dynamic" }
-- --     })
-- --   end)
-- -- end)
--
-- -- spaces_indicator:subscribe("mouse.exited", function(env)
-- --   sbar.animate("tanh", 30, function()
-- --     spaces_indicator:set({
-- --       background = {
-- --         color = { alpha = 0.0 },
-- --         border_color = { alpha = 0.0 },
-- --       },
-- --       icon = { color = colors.basics.grey },
-- --       label = { width = 0, }
-- --     })
-- --   end)
-- -- end)
--
-- -- spaces_indicator:subscribe("mouse.clicked", function(env)
-- --   sbar.trigger("swap_menus_and_spaces")
-- -- end)
