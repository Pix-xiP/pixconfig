vim.opt_local.commentstring = "# %s"
vim.opt_local.iskeyword:append("-")
vim.opt_local.omnifunc = "syntaxcomplete#Complete"
vim.b.undo_ftplugin = "setlocal commentstring< iskeyword< omnifunc<"
