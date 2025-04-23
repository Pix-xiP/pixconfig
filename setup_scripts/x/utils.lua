local M = {}

function M.tprint(tbl, indent)
	if not indent then
		indent = 0
	end
	local toprint = string.rep(" ", indent) .. "{\r\n"
	indent = indent + 2
	for k, v in pairs(tbl) do
		toprint = toprint .. string.rep(" ", indent)
		if type(k) == "number" then
			toprint = toprint .. "[" .. k .. "] = "
		elseif type(k) == "string" then
			toprint = toprint .. k .. "= "
		end
		if type(v) == "number" then
			toprint = toprint .. v .. ",\r\n"
		elseif type(v) == "string" then
			toprint = toprint .. '"' .. v .. '",\r\n'
		elseif type(v) == "table" then
			toprint = toprint .. M.tprint(v, indent + 2) .. ",\r\n"
		else
			toprint = toprint .. '"' .. tostring(v) .. '",\r\n'
		end
	end
	toprint = toprint .. string.rep(" ", indent - 2) .. "}"
	return toprint
end

---@param t1 table first table to merge
---@param t2 table second table to merge
---@param res table resulting merged table
function M.tbl_merge(t1, t2, res)
	for _, v in ipairs(t1) do
		table.insert(res, v)
	end
	for _, v in ipairs(t2) do
		table.insert(res, v)
	end
end

---@param t1 table
---@param t2 table
---@param res table
function M.tbl_merge2(t1, t2, res)
	table.move(t1, 0, #t1, res)
	table.move(t2, 0, #t2, res)
end

return M
