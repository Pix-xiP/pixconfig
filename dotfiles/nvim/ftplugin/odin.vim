if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1 
let b:undo_ftplugin = "setlocal comments< expandtab< tabstop< shiftwidth< smartindent<"

setlocal comments=s1:/*,mb:*,ex:*/,://
setlocal expandtab
setlocal sw=2 sts=2
setlocal nosmartindent
