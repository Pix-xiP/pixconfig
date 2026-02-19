-- boostrap and setup lazy and the rest of the config.
require("config.lazy")
require("config.options")
require("config.autocmds")
require("config.keymaps")

-- Require fennel written config, autocompiled with 'nfnl' into this directory
-- Edit these files in ./fnl/pix-fnl/...
-- Could in theory just add this folder to config.lazy.spec.imports table
-- require("pix-fnl.config.options")
-- require("pix-fnl.config.keymaps")
-- require("pix-fnl.config.autocmds")

-- pretty print dump of objects with treesitter highlighting
_G.dd = function(...)
	Snacks.debug.inspect(...)
end
_G.bt = function()
	Snacks.debug.backtrace()
end
vim.print = _G.dd

-- append imports to the lazy.lua file inside of config
-- to allow for more folders to be included
-- presently its:
-- { "plugins", "pix" }

-- also append lazyvim.plugins in front to build off of this for the time being.
