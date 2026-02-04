vim.filetype.add({ pattern = { [".*/hyprland%.conf"] = "hyprlang" } })
vim.filetype.add({ pattern = { ["*.modulemap"] = "modulemap" } })
vim.filetype.add({ pattern = { ["^Brewfile$"] = "ruby" } })

vim.api.nvim_create_augroup("RpyFileSettings", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = "*.rpy",
	group = "RpyFileSettings",
	callback = function()
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
		vim.opt_local.expandtab = true
		vim.opt_local.autoindent = true
		vim.opt_local.smartindent = true
		vim.opt_local.textwidth = 0
		vim.opt_local.wrap = false
	end,
	desc = "Settings for rpy files",
})

-- treesitter enabled for files. (could be made per filetype)
-- Treesitter autocommand all wrapped up in one.
-- 	 - Highlights
-- 	 - Indent
-- 	 - Folding
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local bufnr = args.buf
		local ft = vim.bo[bufnr].filetype

		local lang = vim.treesitter.language.get_lang(ft)
		if not lang then
			return
		end

		-- Ensure language is registered (safe, but not sufficient alone)
		if not pcall(vim.treesitter.language.add, lang) then
			return
		end

		-- Hard gate: only proceed if a parser can actually be created for this buffer
		if not pcall(vim.treesitter.get_parser, bufnr, lang) then
			return
		end

		-- highlights (pcall just in case; avoids assert spam)
		if not pcall(vim.treesitter.start, bufnr, lang) then
			return
		end

		-- folding (window-local)
		local win = vim.fn.bufwinid(bufnr)
		if win ~= -1 then
			vim.wo[win].foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.wo[win].foldmethod = "expr"
		end

		-- indent (buffer-local)
		vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
