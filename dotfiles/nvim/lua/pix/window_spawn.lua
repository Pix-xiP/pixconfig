local M = {}

M.exists = false

M.ExistsGroup = vim.api.nvim_create_augroup("PixExistsGroup", {})

vim.api.nvim_create_autocmd("WinClosed", {
	command = "lua require('pix.window_spawn').unexists()",
	group = M.ExistsGroup,
})
-- vim.api.nvim_exec( [[ augroup PixExistsGroup autocmd!  autocmd WinClosed * lua M.toggle_window() augroup END ]], false)

-- This function is for explicitly setting the exists flag to
-- be false, in the case the window shuts with ':q' or 'esc'
function M:unexists()
	if M.exists then
		M.exists = false
	end
end

function M:run_command(command)
	local file = io.popen(command, "r")
	if file == nil then
		return false, ""
	end
	local res = file:read("*a")
	local ok, _, _ = file:close()
	return ok, res
end

function M:toggle_window()
	if not M.exists then
		local cmd = vim.fn.input("Enter command: ")
		local ok, result = M:run_command(cmd)
		if not ok then
			return nil
		end
		local msg = {}
		for line in result:gmatch("[^\n]+") do
			table.insert(msg, line)
		end
		M:spawn_floating_window(msg)
		M.exists = true
	else
		vim.api.nvim_win_close(0, true)
		M.exists = false
	end
end

-- @param: Message == Table.
function M:spawn_floating_window(message)
	local w = 80
	local h = 20

	-- Create a new empty buffer
	local buf = vim.api.nvim_create_buf(false, true)

	local cols = vim.api.nvim_get_option_value("columns", { scope = "local" })

	-- create the floating window
	local opts = {
		relative = "editor",
		width = w,
		height = h,
		col = (math.floor((cols - w) / 2) + 10),
		-- row = math.floor((lines_num - h) / 2),

		-- col = math.floor(500),
		row = math.floor(2),
		anchor = "NW",
		border = "rounded",
		title = "Pix Spawner",
	}
	-- local fwin
	local _ = vim.api.nvim_open_win(buf, true, opts)

	-- Insert the message into the buffer
	local lines = {}
	for _, line in pairs(message) do
		table.insert(lines, line)
	end

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end

return M
