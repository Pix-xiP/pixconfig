local icons = require("icons")
local secrets = require("secrets")

local M = {}

M.mail = sbar.add("item", {
	update_freq = 360,
	position = "right",
	click_script = "sketchybar --set $NAME popup.drawing=toggle",
	icon = {
		string = icons.mail,
		color = colours.rosepine.main.foam,
		drawing = true,
		-- font = "sketchybar-app-font:Regular:18.0",
		font = {
			family = settings.font.text,
			style = settings.font.style.regular,
			size = 17.0,
		},
	},
})

function M.mail_update()
	local acc = secrets.mail_account_name
	local script = [[
tell application "Mail"
  set box to mailbox "INBOX" of account "%s"
  set out to unread count of box
  return out
end tell
  ]]
	local cmd = string.format("osascript -e '%s'", string.format(script, acc))

	sbar.exec(cmd, function(count, exit_code)
		local colour
		if exit_code ~= 0 then
			print("Non-Zero exit code:", exit_code)
		end
		if tonumber(count) == 0 then
			colour = colours.rosepine.main.iris
		elseif tonumber(count) > 0 and tonumber(count) < 10 then
			colour = colours.rosepine.main.rose
		else
			colour = colours.rosepine.main.love
		end

		M.mail:set({
			icon = {
				color = colour,
			},
			label = {
				string = count,
				color = colour,
			},
		})
	end)
end

function M.mailbox_clicked(env)
	local mailbox = env.NAME:gsub("mailbox.", "")
	local script = [[ 
tell application "Mail"
  activate 
  set acc to account "%s"
end tell
  ]]
	local cmd = string.format("osascript -e '%s'", string.format(script, mailbox))
	sbar.exec(cmd)
end

M.mailboxes = {}
function M.get_mail(mailbox)
	local script = [[
on run
 tell application "Mail"
    set _output to ""
    repeat with a in every account whose enabled is true
      set _account_name to name of a
      set box to mailbox "INBOX" of account _account_name
      set _output to _output & unread count of box & "  " & _account_name & "\n"
    end repeat
    return _output
 end tell
end run
  ]]

	local cmd = string.format("osascript -e '%s'", string.format(script))

	sbar.exec(cmd, function(mailboxes, exit_code)
		if exit_code ~= 0 then
			print("Non-Zero exit code:", exit_code)
		end
		local i = 0
		for line in string.gmatch(mailboxes, "[^\n]+") do
			local splitter = {}
			for word in string.gmatch(line, "%S+") do
				table.insert(splitter, word)
			end
			local name = "mailbox." .. tostring(splitter[2])
			local box = sbar.add("item", name, {
				position = "popup." .. M.mail.name,
				icon = {
					string = icons.mail .. "  " .. splitter[1],
					color = colours.rosepine.main.iris,
					drawing = true,
					font = { size = "18", style = "Bold" },
				},
				label = {
					string = splitter[2],
					color = colours.rosepine.main.text,
					drawing = true,
				},
			})

			M.mailboxes[i] = box
			box:subscribe("mouse.clicked", function(env)
				M.mailbox_clicked(env)
			end)
			i = i + 1
		end
		return mailbox
	end)
end

M.title = sbar.add("item", "mail_title", {
	position = "popup." .. M.mail.name,
	background = { color = colours.rosepine.main.base },
	icon = {
		string = icons.alert,
		color = colours.rosepine.main.pine,
		drawing = true,
		font = "sketchybar-app-font:Regular:18.0",
	},
	label = "Mailboxes:",
})

sbar.add("event", "mail_check")

M.mail:subscribe("mail_check", "routine", "system_woke", function(_)
	M.get_mail()
	M.mail_update()
end)

M.mail:subscribe("mouse.entered", function()
	M.mail:set({ popup = { drawing = true } })
end)

M.mail:subscribe("mouse.exited", function()
	M.mail:set({ popup = { drawing = false } })
end)

M.bracket = { M.mail.name }

sbar.trigger("mail_check")

M.get_mail()

print("Mail running")

return M
