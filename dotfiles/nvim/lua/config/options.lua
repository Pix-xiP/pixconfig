-- leader key
vim.g.mapleader = " "
vim.g.localleader = "\\"

vim.opt.relativenumber = true

vim.opt.scrolloff = 10 -- number of lines above and below the cursor
vim.opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time

vim.opt.colorcolumn = "120" -- line to show 'max width'

vim.opt.termguicolors = true
vim.g.pix_var = "Pix's Neovim"

vim.opt.ignorecase = true -- search case insensitive
vim.opt.smartcase = true -- search case sensitivie IF capitial letter at start

-- preview of changes during 'sub' (:%s/to/from/gI)
vim.opt.inccommand = "split"

-- some basic netrw changes in case other things haven't loaded.
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = -28

-- root dir detection
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }
vim.g.lazygit_config = true

vim.g.autoformat = true

-- don't hide deprecation warnings
vim.g.deprecation_warnings = false

-- "bigfile" for use with snacks to allow for faster loading of large files
vim.g.bigfile_size = 1024 * 1024 * 1.5 -- 1.5 MB

-- show current document symbols from Trouble in Lualine
vim.g.trouble_lualine = true

-- turn on ai cmp
-- vim.g.ai_cmp = true

vim.opt.autowrite = true -- enable autowrite
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- sync with system clipboard
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.conceallevel = 2 -- Hide * markup for bold and italic but not markers with substitutions
vim.opt.confirm = true -- confirm to save changes before exiting modified buffer
vim.opt.cursorline = true -- enable highlighting of the current line
vim.opt.expandtab = false -- use tabs instead of spaces. TODO: may want to change the default..
vim.opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}
vim.opt.foldlevel = 99
-- opt.formatexpr = "v:lua.require'lazyvim.util'.format.formatexpr()"
-- opt.formatoptions = "jcroqlnt" -- tcqj
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.jumpoptions = "view"
vim.opt.laststatus = 3 -- global statusline
vim.opt.linebreak = true -- Wrap lines at convenient points
vim.opt.list = true -- Show some invisible characters (tabs...
vim.opt.mouse = "a" -- Enable mouse mode
vim.opt.number = true -- Print line number
vim.opt.pumblend = 10 -- Popup blend
vim.opt.pumheight = 10 -- Maximum number of entries in a popup
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
vim.opt.shiftround = true -- Round indent
vim.opt.shiftwidth = 2 -- Size of an indent
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })
vim.opt.showmode = false -- Dont show mode since we have a statusline
vim.opt.sidescrolloff = 8 -- Columns of context
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.spelllang = { "en" }
vim.opt.spelloptions:append("noplainbuffer")
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitkeep = "screen"
vim.opt.splitright = true -- Put new windows right of current
-- vim.opt.statuscolumn = [[%!v:lua.require'lazyvim.util'.ui.statuscolumn()]]
vim.opt.tabstop = 2 -- Number of spaces tabs count for
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 200 -- Save swap file and trigger CursorHold
vim.opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
vim.opt.wildmode = "longest:full,full" -- Command-line completion mode
vim.opt.winminwidth = 5 -- Minimum window width
vim.opt.wrap = false -- Disable line wrap

if vim.fn.has("nvim-0.10") == 1 then
	vim.opt.smoothscroll = true
	-- opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
	vim.opt.foldmethod = "expr"
	vim.opt.foldtext = ""
else
	vim.opt.foldmethod = "indent"
	-- opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
