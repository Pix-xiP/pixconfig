local ft = vim.filetype

ft.add({ pattern = { [".*/hyprland%.conf"] = "hyprlang" } })
ft.add({ pattern = { ["*.modulemap"] = "modulemap" } })

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
