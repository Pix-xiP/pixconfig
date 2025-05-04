local M = {}

M.exists = false
M.ExistsGroup = vim.api.nvim_create_augroup("PixPadExists", {})

vim.api.nvim_create_autocmd("WinClosed", {
	command = "lua require('pix.pixpad').unexists()",
	group = M.ExistsGroup,
})

function M:run_cmd(command)
	local file = io.popen(command, "r")
	if file == nil then
		return false, ""
	end
	local res = file:read("*a")
	local ok, _, _ = file:close()
	return ok, res
end

function M.toggle_pixpad()
	if not M.exists then
		local cmd = vim.fn.input("Enter command: ")
		local ok, result = M:run_cmd(cmd)
		if not ok then
			return nil
		end
		local msg = {}
		for line in result:gmatch("[^\n]+") do
			table.insert(msg, line)
		end
		M:spawn_pixpad(msg)
		M.exists = true
	else
		vim.api.nvim_win_close(0, true)
		M.exists = false
	end
end

---@param msg table<string,string>
function M:spawn_pixpad(msg)
	local buf = vim.api.nvim_create_buf(false, true)
	local cols = vim.api.nvim_get_option_value("columns", {})
	local nlines = vim.api.nvim_get_option_value("lines", {})

	local w = math.floor(cols * 0.8)
	local h = math.floor(nlines * 0.8)

	local opts = {
		relative = "editor",
		width = w,
		height = h,
		col = math.floor((cols - w) / 2) + 10,
		row = math.floor((nlines - h) / 2),
		anchor = "NW",
		border = "rounded",
		title = "PixPad",
	}

	local _ = vim.api.nvim_open_win(buf, true, opts)

	local lines = {}
	for _, line in pairs(msg) do
		table.insert(lines, line)
	end

	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
end

function M.unexists()
	if M.exists then
		M.exists = false
	end
end

return M
