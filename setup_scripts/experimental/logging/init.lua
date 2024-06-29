function info(msg)
	print("INFO:", msg)
end

function warn(msg)
	print("WARN:", msg)
end

-- function error(msg)
-- 	print("ERRO:", msg)
-- end

function success(msg)
	print("SUCC:", msg)
end

function fatal(msg)
	error("FATA:", msg)
	os.exit(1)
end
