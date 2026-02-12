-- Bootsrap lazy.nvim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })

	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

---@type vim.Option
vim.opt.rtp:prepend(lazypath)

-- setup lazy.nvim for package management
require("lazy").setup({
	spec = {
		-- lets use LazyVim as a base?
		{ "LazyVim/LazyVim", import = "lazyvim.plugins" },

		-- load plugins etc here
		{ import = "plugins" },
		{ import = "pix-fnl.plugins" },
		-- { import = "pix" },
	},
	dev = {
		-- directory where local plugins ar stored
		path = "~/AdeptusCustodes/Lunar/nvim_plugins",
		--- plugins that match these patterns will use your local version instead of the remote
		--- @type string[]
		patterns = { "umbral" }, -- my theme <3
		-- should you go looking to github if the local is missing?
		fallback = true,
	},
	defaults = {
		lazy = false,
		version = false, -- always use the latest git commit
	},
	install = { colorscheme = { "tokyonight", "habamax" } },
	checker = { enabled = true }, -- automatically check for plugin updates
	performance = {
		rtp = {
			-- disable some plugins
			disabled_plugins = {
				"gzip",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
